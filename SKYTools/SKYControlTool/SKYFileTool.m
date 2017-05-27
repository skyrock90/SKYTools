//
//  SKYFileTool.m
//  SKY框架
//
//  Created by SKY on 17/3/15.
//  Copyright © 2017年 SKY. All rights reserved.
//


/*应用沙盒一般包括以下几个文件目录：应用程序包、Documents、Libaray（下面有Caches和Preferences目录）、tmp。
 
 应用程序包：包含所有的资源文件和可执行文件。
 
 Documents：保存应用运行时生成的需要持久化的数据，iTunes会自动备份该目录。苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
 
 tmp：保存应用运行时所需的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行时，系统也有可能会清除该目录下的文件，iTunes不会同步该目录。iphone重启时，该目录下的文件会丢失。
 
 Library：存储程序的默认设置和其他状态信息，iTunes会自动备份该目录。
 
 Libaray/Caches:存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除。一般存放体积比较大，不是特别重要的资源。
 
 Libaray/Preferences:保存应用的所有偏好设置，ios的Settings（设置）应用会在该目录中查找应用的设置信息，iTunes会自动备份该目录。
 */


#import "SKYFileTool.h"

@implementation SKYFileTool
#pragma mark -- 将信息写入自定义plist文件
+ (BOOL)sky_writeMessage:(id)message toPlistName:(NSString *)plistName {
    //创建plist文件夹
    NSString *floderPath = [self sky_getDocumentFileFullPathWithFilePath:@"SKYPlistFloder"];
    [self sky_creatFloderAtFilePath:floderPath];
    
    //写入plist文件
    NSString *plistPath = [NSString stringWithFormat:@"%@/%@",floderPath,plistName];
    BOOL isSuccess = [message writeToFile:plistPath atomically:YES];
    //[[NSFileManager defaultManager] createFileAtPath:filePath contents:fileData attributes:nil];
    return isSuccess;
}


#pragma mark -- 沙盒目录下图片文件处理
//保存图片
+ (BOOL)sky_writeImageToSandBox:(UIImage *)image imageName:(NSString *)name {
    if (image == nil) {
        return NO;
    }
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    //创建plist文件夹
    NSString *floderPath = [self sky_getCachesFileFullPathWithFilePath:@"SKYImagesFloder"];
    [self sky_creatFloderAtFilePath:floderPath];
    
    //将图片写入文件夹
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@",floderPath,name];
    BOOL isSuccess = [imageData writeToFile:imagePath atomically:YES];
    
    return isSuccess;
}

//获取图片
+ (UIImage *)sky_getImageAtSandBoxWithImageName:(NSString *)name {
    //获取文件路径
    NSString *fullPath = [self sky_getCachesFileFullPathWithFilePath:[NSString stringWithFormat:@"SKYImagesFloder/%@",name]];

    // 将图片读出
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //[NSData dataWithContentsOfFile:filePath options:0 error:NULL];
    return savedImage;
}

//删除图片
+ (BOOL)sky_deleteImageWithImagerName:(NSString *)name {
    //获取文件路径
    NSString *fullPath = [self sky_getCachesFileFullPathWithFilePath:[NSString stringWithFormat:@"SKYImagesFloder/%@",name]];
    BOOL isSuccess = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:nil];
    
    return isSuccess;
}




#pragma mark -- 创建文件夹
+ (BOOL)sky_creatFloderAtFilePath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断文件夹是否存在，如果不存在，则创建
    BOOL isSuccess = NO;
    if (![fileManager fileExistsAtPath:filePath]) {
        isSuccess = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        isSuccess = YES;
        NSLog(@"FileDir is exists.");
    }
    
    return isSuccess;
}


#pragma mark -- 沙盒下移动文件
+ (BOOL)sky_moveDirWithPrePath:(NSString *)prePath toPath:(NSString *)toPath {
    NSError *error=nil;
    if([[NSFileManager defaultManager] moveItemAtPath:prePath toPath:toPath error:&error]) {
        return YES;
    }else{
        return NO;
    }
}



#pragma mark -- 获取沙盒目录
//1.获得Document文件夹下文件路径
+ (NSString*)sky_getDocumentFileFullPathWithFilePath:(NSString *)filePath {
    //沙盒中的文件路径
    NSArray  *sandBoxPath   = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [sandBoxPath objectAtIndex:0];
    NSString *fullPath =[documentPath stringByAppendingPathComponent:filePath];//根据需要更改文件名
    
    return fullPath;
}


//2.获得Library/Caches文件夹下文件路径
+ (NSString*)sky_getCachesFileFullPathWithFilePath:(NSString *)filePath {
    //沙盒中的文件路径
    NSArray  *cachesArr     =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
    NSString *cachesPath   = [cachesArr objectAtIndex:0];
    NSString *fullPath =[cachesPath stringByAppendingPathComponent:filePath];//根据需要更改文件名
    
    return fullPath;
}


//3. 获得应用程序沙盒的Downloads文件路径
+ (NSString *)sky_getDownloadFileFullPathWithFilePath:(NSString *)filePath {
    NSArray  *downloadPaths = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory,NSUserDomainMask,YES);
    NSString *downloadPath  = [downloadPaths objectAtIndex:0];
    NSString *fullPath = [downloadPath stringByAppendingPathComponent:filePath];
    
    return fullPath;
}

//4. 获得应用程序沙盒的tmp文件路径
+ (NSString *)sky_getTempFileFullPathWithFilePath:(NSString *)filePath {
    NSString *tempPath = NSTemporaryDirectory();
    NSString *fullPath    = [tempPath stringByAppendingPathComponent:filePath];
    
    return fullPath;
}

@end
