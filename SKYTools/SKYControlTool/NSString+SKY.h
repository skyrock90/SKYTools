//
//  NSString+SKY.h
//  SKY框架
//
//  Created by SKY on 17/3/13.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SKY)
//md5加密
+ (NSString *)sky_md5To32bitWith:(NSString *)str;

//base64编解码
+ (NSString *)sky_base64EncodeWithString:(NSString *)inputStr;
+ (NSString *)sky_base64DecodeWithString:(NSString *)inputStr;

//encode /decode
+ (NSString *)sky_EncodedWithURLStr:(NSString *)str;
+ (NSString *)sky_DecodeWithURLStr:(NSString *)str;


//判断是否是邮箱
+ (BOOL)sky_isEmailWith:(NSString *)str;


//字符串格式化
+ (NSString *)sky_formatStringWith:(NSString *)str;//格式化字符串(去除nil null 空格 换行)
+ (BOOL)sky_isEmptyStrWith:(NSString *)str;//判断是否为空串
+ (NSString *)sky_formatStrWithUnicodeStr:(NSString *)unicodeStr;//unicode码 转成普通文字
+ (NSString *)sky_removeSpecialCharacterWith:(NSString *)string;//去除特殊字符
/*
 字符串拆分
[value enumerateSubstringsInRange:NSMakeRange(0, value.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
}];
 */
+ (BOOL)sky_stringContrainsEmoji:(NSString *)string;//判断拆分后的子字符串是否为表情

//计算文本的size
+ (CGSize)sky_getAutoSizeWithString:(NSString *)str size:(CGSize)size font:(UIFont *)font;//获取自适应文字的size
+ (CGFloat)sky_getHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font;//获取自适应文字的高度
+ (CGFloat)sky_getWidthWithText:(NSString *)text font:(UIFont *)font;//获取自适应文字的宽度
+ (CGFloat)sky_getMaxWidthWithStrArray:(NSArray *)strArray font:(UIFont *)font;//获取一个字符串数组中字符串的最大长度

@end
