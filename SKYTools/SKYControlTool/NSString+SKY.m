//
//  NSString+SKY.m
//  SKY框架
//
//  Created by SKY on 17/3/13.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "NSString+SKY.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (SKY)

#pragma mark -- md5加密
+ (NSString *)sky_md5To32bitWith:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr),digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02x", digest[i]];
    }

    return result;
}


#pragma mark  base64编码
/*
 Base64编码方法要求把每三个8Bit的字节转换为四个6Bit的字节，其中，转换之后的这四个字节中每6个有效bit为是有效数据，空余的那两个 bit用0补上成为一个字节。因此Base64所造成数据冗余不是很严重，Base64是当今比较流行的编码方法，因为它编起来速度快而且简单
 Base64就是(邮件截取)背景下产生的加密方法。它的特点是：1、速度非常快。2、能够将字符串A转换成字符串B，而且如果你光看字符串B，是绝对猜不出字符串A的内容来的。
 */
+ (NSString *)sky_base64EncodeWithString:(NSString *)inputStr {//编码
    
    NSData *encodeData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeBase64Str = [encodeData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return encodeBase64Str;
}

+ (NSString *)sky_base64DecodeWithString:(NSString *)inputStr {//解码
    
    NSData *base64Data = [[NSData alloc]initWithBase64EncodedString:inputStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *decodeBase64Str = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    
    return decodeBase64Str;
}


#pragma mark -- 对 URL 进行 Encode/Decode
//对 URL 进行 Encode
+ (NSString *)sky_EncodedWithURLStr:(NSString *)str{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedString = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    return encodedString;
}

//对 URL 进行 Decode
+ (NSString *)sky_DecodeWithURLStr:(NSString *)str {
    NSString *result = [str stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByRemovingPercentEncoding];
    
    return result;
}


#pragma mark -- 计算文本的size
//获取自适应文字的高度
+ (CGFloat)sky_getHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}


//获取自适应文字的宽度
+ (CGFloat)sky_getWidthWithText:(NSString *)text font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = text;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}

//获取自适应文字的size
+ (CGSize)sky_getAutoSizeWithString:(NSString *)str size:(CGSize)size font:(UIFont *)font {
    if ([str isEqualToString:@""]) {
        return CGSizeMake(0, 0);
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 0;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    return [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}


//获取一个字符串数组中字符串的最大长度
+ (CGFloat)sky_getMaxWidthWithStrArray:(NSArray *)strArray font:(UIFont *)font {
    CGFloat maxLength = 0;
    for (NSString *textStr in strArray) {
        CGFloat labelWidth = [self sky_getWidthWithText:textStr font:font];
        if (labelWidth > maxLength) {
            maxLength = labelWidth;
        }
    }
    return maxLength;
}


#pragma mark -- 字符串处理
+ (BOOL)sky_isEmptyStrWith:(NSString *)str{
    return (str == nil || [str isKindOfClass:[NSNull class]] || str.length == 0);
}

//格式化字符串 将null转为@"" 取出首尾换行符及空格
+ (NSString *)sky_formatStringWith:(NSString *)str {
    //判空处理
    if (str == nil || [str isKindOfClass:[NSNull class]] || str.length == 0 || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"]) {
        return @"";
    }
    //去掉首尾换行符及空格
    NSString * newStr = [NSString stringWithFormat:@"%@",str];
    newStr = [newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return newStr;
}

//去除字符串中特殊字符
+ (NSString *)sky_removeSpecialCharacterWith:(NSString *)string {
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@-/:;()$&@\".,?!'{}[]#%^*+=_~<>|€£¥•，"];
    NSString *newStr = [string stringByTrimmingCharactersInSet:set];
    
    return newStr;
}



//unicode码 转成普通文字.  (\u6790)
+ (NSString *)sky_formatStrWithUnicodeStr:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData   *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    //[NSPropertyListSerialization propertyListFromData:tempData  mutabilityOption:NSPropertyListImmutable format:NULLerrorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}



+ (BOOL)sky_stringContrainsEmoji:(NSString *)string {
    BOOL returnValue = NO;
    const unichar hs = [string characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (string.length > 1) {
            const unichar ls = [string characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (string.length > 1) {
        const unichar ls = [string characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }

    return returnValue;
}



#pragma mark -- 判断是否为邮箱
+ (BOOL)sky_isEmailWith:(NSString *)str {
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[str lowercaseString]];
}

@end
