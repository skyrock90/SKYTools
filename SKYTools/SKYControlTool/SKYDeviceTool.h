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

+ (NSString *)sky_getDeviceId;//获取设备id
+ (double)sky_getHeightRatioValue;//获取设备设定高比
+ (CGFloat)sky_getBatteryLevel;//获取设备电量
+ (NSString *)sky_getDeviceType;//获取设备型号
@end
