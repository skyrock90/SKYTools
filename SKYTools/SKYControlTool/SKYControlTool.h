//
//  SKYControlTool.h
//  
//
//  Created by SKY on 15/11/3.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef void(^DoneBlock)();
typedef void(^RunBlock)(id kobject);
@interface SKYControlTool : NSObject


#pragma mark -- json-dic互转
+ (NSDictionary *)sky_formatJsonStringToDicWith:(NSString *)json;//json转dic
+ (NSString *)sky_formatDicToJsonStringWith:(NSDictionary *)dic;//dic转jsonStr
+ (NSMutableArray *)sky_formatJsonStringToArrayWith:(NSString *)json;//json转array
+ (NSString *)sky_formatArrayToJsonStringWith:(NSArray *)array;//Array转jsonStr


#pragma mark -- 提示
//提示框
+ (void)sky_showAlertWithController:(id)controller Message:(NSString *)message doneTitle:(NSString *)doneTitle doneBlock:(DoneBlock)block;//展示一个简单的提示框
+ (void)sky_showAlertWithController:(id)controller Message:(NSString *)message leftTitle:(NSString *)leftTitle righTitle:(NSString *)rightTitle leftBlock:(DoneBlock)leftBlock rightBlock:(DoneBlock)rightBlock;//两个按钮提示框

#pragma mark -- 属性字符串
+ (NSMutableAttributedString *)sky_changeString:(NSString *)string changeRange:(NSRange)range changeColor:(UIColor *)color changeFont:(CGFloat)font;


#pragma mark -- 效果控制
//高斯模糊效果
+ (void)sky_blurEffectWithImagerView:(UIImageView *)imageView;

//控制闪光灯
+ (void)sky_handleTorchSwitch:(BOOL)status;


//倒计时
+ (void)sky_cutDownTimeButton:(UIButton *)button starTime:(NSInteger)starTime starColor:(UIColor *)starColor endColor:(UIColor *)endColor starTitle:(NSString *)starTitle endTitle:(NSString *)endTitle;

#pragma mark --设置导航栏
+ (void)sky_setNavWithNavController:(UINavigationController *)controller color:(UIColor *)color;
+ (void)sky_setNavBackButtonWithController:(UIViewController *)controller target:(id)target backAction:(SEL)sel;//设置导航栏返回按钮

#pragma mark -- 16进制颜色转换
+ (UIColor *)sky_colorWithHexValue:(NSString *)valueString andAlpha:(CGFloat)alpha;


@end
