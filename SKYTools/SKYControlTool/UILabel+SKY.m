//
//  UILabel+SKY.m
//  SKYToolsDemo
//
//  Created by SKY on 17/5/26.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "UILabel+SKY.h"
#import "NSString+SKY.h"
#import "UIView+Extension.h"


@implementation UILabel (SKY)
//可调行间距/字间距的label
+ (UILabel *)sky_labelWithContent:(NSString *)content font:(CGFloat)font textColor:(UIColor *)textColor lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace  {
    UILabel *label = [[UILabel alloc]init];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];//行间距
    
    //添加属性
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    [string addAttribute:NSKernAttributeName value:@(wordSpace) range:NSMakeRange(0, [content length])];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, [content length])];
    [string addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, [content length])];

    label.attributedText = string;
    [label sizeToFit];
    
    return label;
}

//定制绿色带边框label
+ (UILabel *)sky_labelWithBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)width textColor:(UIColor *)textColor font:(UIFont*)font text:(NSString *)text {
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.layer.borderWidth = width;
    label.layer.cornerRadius = 2.5;
    label.layer.borderColor = borderColor.CGColor;
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelWidth = [NSString sky_getWidthWithText:text font:font];
    label.size = CGSizeMake(labelWidth+12, 21);
    
    return label;
}


+ (UILabel *)sky_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    label.text = text;
    
    return  label;
}

+ (UILabel *)sky_labelWithFrame:(CGRect)frame text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor andBackColor:(UIColor *)backColor{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.backgroundColor = backColor;
    label.textColor = textColor;
    label.text = text;
    
    return  label;
}

@end
