//
//  SKYFileTool.h
//  SKY框架
//
//  Created by SKY on 17/3/15.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SKYFileTool : NSObject
//文件操作
+ (BOOL)sky_writeMessage:(NSDictionary *)message toPlistName:(NSString *)plistName;//将信息写入自定义的plist文件路径下
+ (BOOL)sky_writeImageToSandBox:(UIImage *)image imageName:(NSString *)name;//保存图片
+ (UIImage *)sky_getImageAtSandBoxWithImageName:(NSString *)name;//获取图片
+ (BOOL)sky_deleteImageWithImagerName:(NSString *)name;//删除图片
+ (BOOL)sky_moveDirWithPrePath:(NSString *)prePath toPath:(NSString *)toPath;//移动文件
+ (BOOL)sky_creatFloderAtFilePath:(NSString *)filePath;//创建文件夹

//路径获取
+ (NSString *)sky_getDocumentFileFullPathWithFilePath:(NSString *)filePath;//1.获得Document文件夹下文件路径
+ (NSString *)sky_getCachesFileFullPathWithFilePath:(NSString *)filePath;//2.获得Library/Caches文件夹下文件路径
+ (NSString *)sky_getDownloadFileFullPathWithFilePath:(NSString *)filePath;//3. 获得应用程序沙盒的Downloads文件路径
+ (NSString *)sky_getTempFileFullPathWithFilePath:(NSString *)filePath;//4. 获得应用程序沙盒的tmp文件路径
@end
