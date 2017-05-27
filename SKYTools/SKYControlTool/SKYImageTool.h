//
//  SKYImageTool.h
//  SKY框架
//
//  Created by SKY on 17/2/13.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKYImageTool : UIView
#pragma mark -- 获取图片格式
+ (NSString *)sky_imageFormatWithImageData:(NSData *)data;//通过图片Data数据第一个字节来获取图片扩展名(严谨)
+ (NSString *)sky_imageFormatWithImageURL:(NSString *)url;//通过图片URL的截取来获取图片的扩展名(不严谨)


#pragma mark -- 压缩图片
+ (UIImage *)sky_pressImage:(UIImage *)image;//压图片
+ (UIImage *)sky_pressImage:(UIImage *)image targetWidth:(CGFloat)targetWidth;//缩小尺寸
+ (NSData *)sky_pressImage:(UIImage *)image toTargetMaxFileSize:(CGFloat)maxFileSize;//压缩图片到指定大小
+ (UIImage *)sky_getUIImageWithCIImage:(CIImage *)cIImage size:(CGSize) size;//CIImage生成所需尺寸的Image

#pragma mark -- 获取图片
+ (UIImage *)sky_getImageWithColor:(UIColor *)color size:(CGSize)size;//生成单色图片
+ (UIImage *)sky_getImageWithScreenView:(UIView *)view;////在指定的视图内进行截屏操作,返回截屏后的图片
+ (UIImage *)sky_getStretchImageWithImageName:(NSString *)name point:(CGPoint)point;//获取瓦片平铺图片


#pragma mark -- 自定义gif图
/**
 *  自定义播放Gif图片(Path)
 *
 *  @param frame        位置和大小
 *  @param gifImagePath Gif图片路径
 *
 *  @return Gif图片对象
 */
- (id)initWithFrame:(CGRect)frame gifImagePath:(NSString *)gifImagePath;

/**
 *  自定义播放Gif图片(Data)(本地+网络)
 *
 *  @param frame        位置和大小
 *  @param gifImageData Gif图片Data
 *
 *  @return Gif图片对象
 */
- (id)initWithFrame:(CGRect)frame gifImageData:(NSData *)gifImageData;

/**
 *  自定义播放Gif图片(Name)
 *
 *  @param frame        位置和大小
 *  @param gifImageName Gif图片Name
 *
 *  @return Gif图片对象
 */
- (id)initWithFrame:(CGRect)frame gifImageName:(NSString *)gifImageName;









@end
