//
//  SKYPredicate.m
//  SKY框架
//
//  Created by SKY on 17/4/5.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "SKYPredicate.h"
#import "NSString+SKY.h"

@implementation SKYPredicate

#pragma mark -- 取两个数组的交/并/差集
//并集
+ (NSArray *)sky_getUnionDataWith:(NSArray *)array1 array2:(NSArray *)array2 {
    NSMutableSet *set1 = [NSMutableSet setWithArray:array1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array2];
    [set1 unionSet:set2];       //取并集后 set1中为并集
    NSArray *newArray = [set1 allObjects];
    
    return newArray;
}

//交集
+ (NSArray *)sky_getIntersectDataWith:(NSArray *)array1 array2:(NSArray *)array2 {
    NSMutableSet *set1 = [NSMutableSet setWithArray:array1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array2];
    [set1 intersectSet:set2];  //取交集后 set1中为交集
    NSArray *newArray = [set1 allObjects];
    
    return newArray;
}

//差集
+ (NSArray *)sky_getMinusDataWith:(NSArray *)array1 array2:(NSArray *)array2 {
    NSMutableSet *set1 = [NSMutableSet setWithArray:array1];
    NSMutableSet *set2 = [NSMutableSet setWithArray:array2];
    [set1 minusSet:set2];      //取差集后 set1中为差集
    NSArray *newArray = [set1 allObjects];
    
    return newArray;
}


//过滤掉子数组中与根数组相同的元素
+ (NSArray *)sky_getNewSubDataWith:(NSArray *)rootArray subArray:(NSArray *)subArray {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", rootArray];
    NSArray *newSubArray = [subArray filteredArrayUsingPredicate:predicate];

    return newSubArray;
}


//谓词的条件指令 逻辑指令 && ,||, !, <,<=,>=,>==,BETWEEN {}
//    BEGANWITH：以指定字符开始
//    ENDSWITH :以指定字符结束
//    CONTAINS 包含指定字符,可
//使用修饰符 -c 不区分大小写 -d 不区分注音符号
//like 匹配任意多个字符
//name中只要有s字符就满足条件
//    predicate = [NSPredicate predicateWithFormat:@"name like '*s*'"];
//?代表一个字符，下面的查询条件是：name中第二个字符是s的
//    predicate = [NSPredicate predicateWithFormat:@"name like '?s'"];

#pragma mark -- 查询符合条件的数据
//精确查找
+ (NSArray *)sky_getContainsDataInArray:(NSArray *)array property:(NSString *)property value:(NSString *)value {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS %@",property,value];//过滤条件
    
    //开始过滤
    NSArray *newArray = [array filteredArrayUsingPredicate:predicate];
    
    return newArray;
}

//模糊查找
+ (NSArray *)sky_getLikeDataInArray:(NSArray *)array property:(NSString *)property value:(NSString *)value {
    //拆分字符串 过滤符合单个字符的数据
    __block NSMutableArray *newArray = [NSMutableArray array];
    value = [NSString sky_removeSpecialCharacterWith:value];//去除特殊字符
    
    //过滤系统自带表情符号
    [value enumerateSubstringsInRange:NSMakeRange(0, value.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (substring.length <= 1 && ![NSString sky_stringContrainsEmoji:substring]) {//判断是否为表情符号
            NSString *predStr = [NSString stringWithFormat:@"%@ like[cd] '*%@*'",property,substring];
            if (substring.length > 0) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:predStr];//过滤条件
                NSArray *tempArray = [array filteredArrayUsingPredicate:predicate];
                
                //取两个数组的并集
                NSArray *unionArray = [self sky_getUnionDataWith:newArray array2:tempArray];
                newArray = [NSMutableArray arrayWithArray:unionArray];
            }
        }
    }];


    //过滤符合整个字符的数据
    NSString *allPredStr = [NSString stringWithFormat:@"%@ like[cd] '*%@*'",property,value];
    NSPredicate *allPredicate = [NSPredicate predicateWithFormat:allPredStr];//过滤条件
    NSArray *allTempArray = [array filteredArrayUsingPredicate:allPredicate];

    //遍历全字符数据
    for (id obj in allTempArray) {
        if (![newArray containsObject:obj]) {
            [newArray addObject:obj];
        }else{
            [newArray removeObject:obj];
            [newArray insertObject:obj atIndex:0];
        }
    }
    
    return newArray;
}

#pragma mark -- 邮箱电话号码验证
//验证email
+ (BOOL)sky_validateEmail:(NSString *)email {
    NSString *strRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,5}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    
    return [predicate evaluateWithObject:email];
}

//验证电话号码
+ (BOOL)sky_validateTelNumber:(NSString *)number {
    NSString *strRegex = @"[0-9]{1,20}";
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    
    return [predicate evaluateWithObject:number];
}

#pragma mark -- 获取字符串拼音
+ (NSString *)sky_getPinyinWithString:(NSString *)string {
    NSString * pinyin = nil;
    if ([string length]) {
        NSMutableString * mutStr = [[NSMutableString alloc] initWithString:string];
        if (CFStringTransform((__bridge CFMutableStringRef)mutStr, 0, kCFStringTransformMandarinLatin, NO)) {
        }
        if (CFStringTransform( (__bridge CFMutableStringRef)mutStr, 0, kCFStringTransformStripDiacritics, NO)) {
        }
        pinyin = mutStr;
    }
    return pinyin;
}


#pragma mark -- 获取字符串首字母
+ (NSString *)sky_getInitialsWithString:(NSString *)string {
    NSString * regex = @"^[a-zA-Z]*$";
    NSString * firstLetter = [string substringToIndex:1];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:firstLetter] == YES) {
        return [firstLetter uppercaseString];
    }else {
        return @"~";
    }
}

@end

