//
//  SKYDeviceTool.h
//  SKY框架
//
//  Created by SKY on 17/4/12.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SKYDeviceTool : NSObject

+ (NSString *)sky_getPhoneName;//获取设备名称
+ (NSDictionary *)sky_getDeviceWANIPAdress;//获取设备外网IP
+ (NSString *)sky_getUsedDiskSpace;// 获取已使用的磁盘空间
+ (NSString *)sky_getFreeDiskSpace;// 获取未使用的磁盘空间
+ (NSString *)sky_getTotalDiskSpace;// 获取磁盘总空间
+ (NSString *)sky_getDeviceId;//获取设备id
+ (double)sky_getHeightRatioValue;//获取设备设定高比
+ (CGFloat)sky_getBatteryLevel;//获取设备电量
+ (NSString *)sky_getDeviceType;//获取设备型号
@end
