//
//  SKYDeviceTool.m
//  SKY框架
//
//  Created by SKY on 17/4/12.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "SKYDeviceTool.h"
#import <sys/utsname.h>


@implementation SKYDeviceTool
#pragma mark -- 获取设备名称
+ (NSString *)sky_getPhoneName{
    NSString *iPhoneName = [UIDevice currentDevice].name;
    
    return iPhoneName;
}


#pragma mark -- 获取设备外网IP
+ (NSDictionary *)sky_getDeviceWANIPAdress {
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];
    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析 删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        return dict;
    }
    return nil;
}


#pragma mark -- 获取磁盘空间
// 获取磁盘总空间
+ (NSString *)sky_getTotalDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return nil;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    double dspace = space/(1024*1024);
    NSString *sizeStr = nil;
    if (dspace > 1024) {
        sizeStr = [NSString stringWithFormat:@"%.1fGB",dspace/1024];
    }else{
        sizeStr = [NSString stringWithFormat:@"%.1fMB",dspace];
    }
    
    return sizeStr;
}

// 获取未使用的磁盘空间
+ (NSString *)sky_getFreeDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return nil;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    double dspace = space/(1024*1024);
    NSString *sizeStr = nil;
    if (dspace > 1024) {
        sizeStr = [NSString stringWithFormat:@"%.1fGB",dspace/1024];
    }else{
        sizeStr = [NSString stringWithFormat:@"%.1fMB",dspace];
    }
    
    return sizeStr;
}

// 获取已使用的磁盘空间
+ (NSString *)sky_getUsedDiskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return nil;
    int64_t totalDisk =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    int64_t freeDisk  =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    
    if (totalDisk < 0 || freeDisk < 0) return nil;
    int64_t usedDisk = totalDisk - freeDisk;
    double dspace = usedDisk/(1024*1024);
    NSString *sizeStr = nil;
    if (dspace > 1024) {
        sizeStr = [NSString stringWithFormat:@"%.1fGB",dspace/1024];
    }else{
        sizeStr = [NSString stringWithFormat:@"%.1fMB",dspace];
    }
    
    return sizeStr;
}


#pragma mark -- 获取设备UUID
+ (NSString *)sky_getDeviceId{
    NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    return idfv;
}

#pragma mark -- 获取设定高比
+ (double)sky_getHeightRatioValue{
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        return 1;
    }
    else if ([UIScreen mainScreen].bounds.size.width == 375) {
        return 1.05;
    }else{
        return 1.1;
    }
}


#pragma mark -- 获取设备电量
+ (CGFloat)sky_getBatteryLevel {
    CGFloat batteryLevel = [[UIDevice currentDevice] batteryLevel];
    
    return batteryLevel;
}



#pragma mark -- 获取设备型号
+ (NSString *)sky_getDeviceType {

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform; 
}
@end
