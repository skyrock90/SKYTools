//
//  NSDate+SKY.h
//  SKYToolsDemo
//
//  Created by SKY on 17/5/26.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SKY)
/**
 *  常用日期结构：
 yyyy-MM-dd HH:mm:ss.SSS
 yyyy-MM-dd HH:mm:ss
 yyyy-MM-dd
 MM dd yyyy
 */

//获取当月天数
+ (NSInteger)sky_getMonthDayCountWithDate:(NSDate *)date;

//获取date上月的天数
+ (NSInteger)sky_getLastMonthDayCountWithDate:(NSDate *)date;

//获取当月第一天的序数
+ (NSInteger)sky_getFirstDayIndexOfMonthDate:(NSDate *)date;

//获取date在当月的序数
+ (NSInteger)sky_getDayIndexOfMonthDate:(NSDate *)date;

//获取当前时间
+ (NSString *)sky_getTodayDateStrWithDateformatterStr:(NSString *)formatterStr;

//字符串转date
+ (NSDate *)sky_getDatefromDateStr:(NSString *)dateStr formatterStr:(NSString *)formatterStr;

//获取N天后的日期
+ (NSString *)sky_getNewDateFromDate:(NSDate *)date afterDays:(NSInteger)dayNum;

//获取N年后的日期
+ (NSDate *)sky_getNewDateFromDate:(NSDate *)date afterYears:(NSInteger)years;

//比较日期大小
+ (NSComparisonResult)sky_compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay;

//获取日期提醒标题
+(NSString *)sky_getTimeMarkFrom:(NSString *)fromDateStr To:(NSString *)endDateStr;
@end
