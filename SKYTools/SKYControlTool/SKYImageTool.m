//
//  SKYImageTool.m
//  SKY框架
//
//  Created by SKY on 17/2/13.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "SKYImageTool.h"
#import <ImageIO/ImageIO.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface SKYImageTool ()
{
    CGImageSourceRef gif;
    NSDictionary *gifProperties;
    size_t index;
    size_t count;
    NSTimer *timer;
}
@end


@implementation SKYImageTool
#pragma mark -- 获取图片格式
//通过图片Data数据第一个字节来获取图片扩展名
+ (NSString *)sky_imageFormatWithImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

//通过图片字符串的截取来获取图片的扩展名
+ (NSString *)sky_imageFormatWithImageURL:(NSString *)url {
    NSString *extensionName = url.pathExtension;
    if ([extensionName.lowercaseString isEqualToString:@"jpeg"]) {
        return @"jpeg";
    }
    if ([extensionName.lowercaseString isEqualToString:@"gif"]) {
        return @"gif";
    }
    if ([extensionName.lowercaseString isEqualToString:@"png"]) {
        return @"png";
    }
    return nil;
}



#pragma mark -- 图片的压缩处理
+ (UIImage *)sky_pressImage:(UIImage *)image {//压
    if (image == nil) {
        return nil;
    }
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    if (imgData.length>2*1024*1024) {//2M以及以上
        imgData=UIImageJPEGRepresentation(image, 0.1);
    }else if (imgData.length>1024*1024) {//1M-2M
        imgData=UIImageJPEGRepresentation(image, 0.2);
    }else if (imgData.length>512*1024) {//0.5M-1M
        imgData=UIImageJPEGRepresentation(image, 0.5);
    }else if (imgData.length>200*1024) {//0.25M-0.5M
        imgData=UIImageJPEGRepresentation(image, 0.8);
    }
    
    UIImage *newImage = [UIImage imageWithData:imgData];
    return newImage;
}


//缩小尺寸
+ (UIImage *)sky_pressImage:(UIImage *)image targetWidth:(CGFloat)targetWidth {
    if (image == nil) {
        return nil;
    }
    CGSize imageSize = image.size;
    CGFloat width  = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;//等比压缩size
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [image drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


//压缩图片到指定大小
+ (NSData *)sky_pressImage:(UIImage *)image toTargetMaxFileSize:(CGFloat)maxFileSize {
    if (!image) {
        return nil;
    }
    CGFloat compression = 0.8f;
    NSData *compressedData = UIImageJPEGRepresentation(image, compression);
    while ([compressedData length] > maxFileSize) {
        compressedData = UIImageJPEGRepresentation([self sky_pressImage:image targetWidth:image.size.width*compression], compression);
    }
    return compressedData;
}



#pragma mark -- CIImage生成所需尺寸的Image
+ (UIImage *)sky_getUIImageWithCIImage:(CIImage *)cIImage size:(CGSize) size {
    //计算新size
    CGRect extent = CGRectIntegral(cIImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    // 重绘image
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CIContext     *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:cIImage fromRect:extent];
    CGContextDrawImage(contextRef, extent, imageRef);
    CGImageRef scaledImage = CGBitmapContextCreateImage(contextRef);
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    
    return [UIImage imageWithCGImage:scaledImage];
}



#pragma mark -- 获取图片
//生成单色图片
+ (UIImage *)sky_getImageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//在指定的视图内进行截屏操作,返回截屏后的图片
+ (UIImage *)sky_getImageWithScreenView:(UIView *)view {
    //根据屏幕大小，获取上下文
    UIGraphicsBeginImageContext([[UIScreen mainScreen] bounds].size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

//获取瓦片平铺图片
+ (UIImage *)sky_getStretchImageWithImageName:(NSString *)name point:(CGPoint)point{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:point.x topCapHeight:point.y];
}




#pragma mark -- 自定义gif图
- (id)initWithFrame:(CGRect)frame gifImagePath:(NSString *)gifImagePath {
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:gifImagePath], (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(play) userInfo:nil repeats:YES];/**< 0.12->0.06 */
        [timer fire];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame gifImageData:(NSData *)gifImageData {
    self = [super initWithFrame:frame];
    if (self) {
        gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount] forKey:(NSString *)kCGImagePropertyGIFDictionary];
        gif = CGImageSourceCreateWithData((CFDataRef)gifImageData, (CFDictionaryRef)gifProperties);
        count =CGImageSourceGetCount(gif);
        timer = [NSTimer scheduledTimerWithTimeInterval:0.06 target:self selector:@selector(play) userInfo:nil repeats:YES];/**< 0.12->0.06 */
        [timer fire];
    }
    return self;
}

- (void)play {
    if (count > 0) {
        index ++;
        index = index%count;
        CGImageRef ref = CGImageSourceCreateImageAtIndex(gif, index, (CFDictionaryRef)gifProperties);
        self.layer.contents = (__bridge id)ref;
        CFRelease(ref);
    } else {
        static dispatch_once_t onceToken;
        // 只执行一次
        dispatch_once(&onceToken, ^{
            NSLog(@"[DHGifImageOperation]:请检测网络或者http协议");
        });
    }
}

- (void)removeFromSuperview {
    [timer invalidate];
    timer = nil;
    [super removeFromSuperview];
}


- (id)initWithFrame:(CGRect)frame gifImageName:(NSString *)gifImageName {
    self = [super initWithFrame:frame];
    if (self) {
        NSString *gifImgName = [gifImageName stringByReplacingOccurrencesOfString:@".gif" withString:@""];
        NSData *gifData      = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:gifImgName ofType:@"gif"]];
        UIWebView *webView   = [[UIWebView alloc] initWithFrame:frame];
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setScalesPageToFit:YES];
        [webView.scrollView setScrollEnabled:NO];
        [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"" baseURL:[NSURL URLWithString:@""]];
        
        UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clearButton setFrame:webView.frame];
        [clearButton setBackgroundColor:[UIColor clearColor]];
        [clearButton addTarget:self action:@selector(activiTap:) forControlEvents:UIControlEventTouchUpInside];
        [webView addSubview:clearButton];
        [self addSubview:webView];
    }
    return self;
}

- (void)activiTap:(UITapGestureRecognizer*)recognizer{
    NSLog(@"[DHGifImageOperation.h]:activiTap:recognizer");
}





#pragma mark -- 防止压缩图片过多导致内存警告
//static size_t getAssetBytesCallback(void  *info, void *buffer, off_t position, size_t count) {
//    ALAssetRepresentation *rep = (__bridge id)info;
//    
//    NSError *error = nil;
//    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
//    
//    if (countRead == 0 && error) {
//        // We have no way of passing this info back to the caller, so we log it, at least.
//       // NDDebug(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
//    }
//    
//    return countRead;
//}
//
//static void releaseAssetCallback(void *info) {
//    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
//    // This release balances that retain.
//    CFRelease(info);
//}
//
//// Returns a UIImage for the given asset, with size length at most the passed size.
//// The resulting UIImage will be already rotated to UIImageOrientationUp, so its CGImageRef
//// can be used directly without additional rotation handling.
//// This is done synchronously, so you should call this method on a background queue/thread.
//- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size {
//    NSParameterAssert(asset != nil);
//    NSParameterAssert(size > 0);
//    
//    ALAssetRepresentation *rep = [asset defaultRepresentation];
//    
//    CGDataProviderDirectCallbacks callbacks = {
//        .version = 0,
//        .getBytePointer = NULL,
//        .releaseBytePointer = NULL,
//        .getBytesAtPosition = getAssetBytesCallback,
//        .releaseInfo = releaseAssetCallback,
//    };
//    
//    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
//    CGImageSourceRef source = CGImageSourceCreateWithDataProvider(provider, NULL);
//    
//    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, (__bridge CFDictionaryRef) @{
//                                                                                                      (NSString *)kCGImageSourceCreateThumbnailFromImageAlways : @YES,
//                                                                                                      (NSString *)kCGImageSourceThumbnailMaxPixelSize : [NSNumber numberWithInt:size],
//                                                                                                      (NSString *)kCGImageSourceCreateThumbnailWithTransform : @YES,
//                                                                                                      });
//    CFRelease(source);
//    CFRelease(provider);
//    
//    if (!imageRef) {
//        return nil;
//    }
//    
//    UIImage *toReturn = [UIImage imageWithCGImage:imageRef];
//    
//    CFRelease(imageRef);
//    
//    return toReturn;
//}





@end
