//
//  SKYToolsDefine.h
//  SKYToolsDemo
//
//  Created by SKY on 17/5/26.
//  Copyright © 2017年 SKY. All rights reserved.
//

#ifndef SKYToolsDefine_h
#define SKYToolsDefine_h
//----------------------设备比例---------------------------
//当前设备的宽和320的比例
#define WRATIO                             [UIScreen mainScreen].bounds.size.width/320
#define SKYWRATIO(value)             WRATIO*value//基宽*比例
#define SKYHRATIO(value)              [SKYDeviceTool sky_getHeightRatioValue] * value//基高*比例
#define KRATIOUIFont(value)           [UIFont systemFontOfSize:value*HRATIO]//按比例缩放的字体


//----------------------颜色类---------------------------
// 16进制颜色转换
#define SKYHexColor(value, alpha)                                 [UIColor sky_colorWithHexValue:value andAlpha:alpha]
//RGBA色值
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/)       [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

//颜色
#define SKYBackgroundColor                  SKYHexColor(@"F1F0F3", 1)//系统背景色
#define SKYBlackTextColor                     SKYHexColor(@"333333",1)//黑色字体颜色
#define SKYSystemGrayTextColor				SKYHexColor(@"707070", 1)//深灰色字体颜色
#define SKYLightGrayTextColor               SKYHexColor(@"f2f2f2", 1)//浅灰色字体颜色


//----------------------字号---------------------------
#define SKYMinFont                     [UIFont systemFontOfSize:12*WRATIO]//小号字
#define SKYContentFont               [UIFont systemFontOfSize:14*WRATIO]//内容字号
#define SKYTitleFont                    [UIFont systemFontOfSize:16*WRATIO]//标题字号
#define SKYButtonFont                 [UIFont systemFontOfSize:16*WRATIO]//按钮字号


//-------------------获取设备大小------------------------
#define SKYDeviceBounds         [[UIScreen mainScreen] bounds]//设备的Bounds
#define SKYDeviceWidth           CGRectGetWidth(SKYDeviceBounds) //设备的宽度
#define SKYDeviceHeight          CGRectGetHeight(SKYDeviceBounds)//设备的高度(设置导航栏后高度统一减去64 44)



//-------------------系统/版本--------------------------------
#define SKYIOSVersion                 [[UIDevice currentDevice].systemVersion floatValue]//系统版本
#define SKYPadStatus                  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) //是否iPad
#define SKYAppVersion                 [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]//大版本
#define SKYAppBuild                    [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"]//build版本
#define SKYAppName                   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] //app名


//日志输出的控制
#if DEBUG
#define NSLog(...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define NSLog(...) nil
#endif


#endif /* SKYToolsDefine_h */
