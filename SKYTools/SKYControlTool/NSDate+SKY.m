//
//  NSDate+SKY.m
//  SKYToolsDemo
//
//  Created by SKY on 17/5/26.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "NSDate+SKY.h"

@implementation NSDate (SKY)
//获取当月天数
+ (NSInteger)sky_getMonthDayCountWithDate:(NSDate *)date {
    //本月天数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger currentMonthDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    
    return currentMonthDays;
}

//获取date上月的天数
+ (NSInteger)sky_getLastMonthDayCountWithDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *lastMonthDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    NSInteger lastMonthDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:lastMonthDate].length;
    
    return lastMonthDays;
}

//获取当月第一天的序数
+ (NSInteger)sky_getFirstDayIndexOfMonthDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstDayIndex = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate]-1;
    
    return firstDayIndex;
}

//获取date在当月的序数
+ (NSInteger)sky_getDayIndexOfMonthDate:(NSDate *)date {
    NSUInteger currentDayIndex = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date]-1;
    
    return currentDayIndex;
}


//获取今天日期字符串
+ (NSString *)sky_getTodayDateStrWithDateformatterStr:(NSString *)formatterStr{
    
    NSDate *  nowDate=[NSDate date];
    NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterStr];
    NSString *  locationString=[dateFormatter stringFromDate:nowDate];
    
    return locationString;
}


//string转date
+ (NSDate *)sky_getDatefromDateStr:(NSString *)dateStr formatterStr:(NSString *)formatterStr{
    NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterStr];
    NSDate *newDate = [dateFormatter dateFromString:dateStr];
    
    return newDate;
}

//获取N天后的日期
+ (NSString *)sky_getNewDateFromDate:(NSDate *)date afterDays:(NSInteger)dayNum {
    NSTimeInterval oneDayTime = 24 * 60 * 60;
    
    NSDate *newDate = [date dateByAddingTimeInterval: dayNum*oneDayTime];
    NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *  newDateStr = [dateFormatter stringFromDate:newDate];
    
    return newDateStr;
}

//获取N年后的date
+ (NSDate *)sky_getNewDateFromDate:(NSDate *)date afterYears:(NSInteger)years {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:years];//设置最大时间为：当前时间推后十年
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:date options:0];
    
    return newDate;
}


//比较日期大小
+ (NSComparisonResult)sky_compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay {
    NSDate *dateA = [self sky_getDatefromDateStr:oneDay formatterStr:@"yyyy-MM-dd"];
    NSDate *dateB = [self sky_getDatefromDateStr:anotherDay formatterStr:@"yyyy-MM-dd"];
    NSComparisonResult result = [dateA compare:dateB];
    
    return result;
}

//获取日期提醒标题
+(NSString *)sky_getTimeMarkFrom:(NSString *)fromDateStr To:(NSString *)endDateStr {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // [gregorian setFirstWeekday:2];
    
    //string转date
    NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromDate = [dateFormatter dateFromString:fromDateStr];
    NSDate *endDate   = [dateFormatter dateFromString:endDateStr];
    
    //获取今天时间
    NSString *todayStr = [NSDate sky_getTodayDateStrWithDateformatterStr:@"yyyy-MM-dd"];
    
    //去掉时分秒信息
    NSDate *startDate;
    NSDate *overDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&startDate interval:NULL forDate:fromDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&overDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:startDate toDate:overDate options:0];
    
    //天数
    NSInteger dayNum = dayComponents.day;
    if ([todayStr isEqualToString:endDateStr]) {//截止日期是今天
        if (dayNum == 0) {
            return @"今天";
        }else if (dayNum == 7) {
            return @"近7日";
        }else if (dayNum == 30) {
            return @"近1月";
        }else{
            return @"查询时间";
        }
    }else{
        return @"查询时间";
    }
}

@end
