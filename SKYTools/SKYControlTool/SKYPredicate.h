//
//  SKYPredicate.h
//  SKY框架
//
//  Created by SKY on 17/4/5.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKYPredicate : NSObject
/**
 查询符合条件的数据
 @param array       查询数据源
 @param property  查询(字典 模型)的字段
 @param value       查询包含的字符

 @return 符合条件的数据
 */
+ (NSArray *)sky_getContainsDataInArray:(NSArray *)array property:(NSString *)property value:(NSString *)value;


/**
 模糊查询符合条件的数据
 @param array       查询数据源
 @param property  查询(字典 模型)的字段
 @param value       查询包含的字符
 
 @return 符合条件的数据
 */
+ (NSArray *)sky_getLikeDataInArray:(NSArray *)array property:(NSString *)property value:(NSString *)value;

//验证邮箱
+ (BOOL)sky_validateEmail:(NSString *)email;

//验证电话号码
+ (BOOL)sky_validateTelNumber:(NSString *)number;

//获取字符串拼音
+ (NSString *)sky_getPinyinWithString:(NSString *)string;

//获取字符串首字母
+ (NSString *)sky_getInitialsWithString:(NSString *)string;
@end
