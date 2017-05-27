//
//  UILabel+SKY.h
//  SKYToolsDemo
//
//  Created by SKY on 17/5/26.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SKY)
+ (UILabel *)sky_labelWithContent:(NSString *)content font:(CGFloat)font textColor:(UIColor *)textColor lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;//可调行间距的label
+ (UILabel *)sky_labelWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)width textColor:(UIColor *)textColor font:(UIFont*)font text:(NSString *)text;//定制绿色带边框label

+ (UILabel *)sky_labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor andBackColor:(UIColor *)backColor;
+ (UILabel *)sky_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;
@end
