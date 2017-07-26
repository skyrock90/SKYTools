//
//  SKYControlTool.m
//  
//
//  Created by SKY on 15/11/3.
//
//

#import "SKYControlTool.h"
#import <AVFoundation/AVFoundation.h>
#import "SKYToolsDefine.h"
#import "SKYImageTool.h"


@implementation SKYControlTool


#pragma mark -- json-dic互转
//json转dic
+ (NSDictionary *)sky_formatJsonStringToDicWith:(NSString *)json{
    if (json == nil) {
        return nil;
    }

    NSError *err;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return nil;
    }
    
    return dic;
}

//json转array
+ (NSMutableArray *)sky_formatJsonStringToArrayWith:(NSString *)json{
    if (json == nil) {
        return nil;
    }
    
    NSError *err;
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        return nil;
    }
    
    return array;
}


//dic转json
+ (NSString *)sky_formatDicToJsonStringWith:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//Array转json
+ (NSString *)sky_formatArrayToJsonStringWith:(NSArray *)array{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark -- 提示框
+ (void)sky_showAlertWithController:(id)controller Message:(NSString *)message doneTitle:(NSString *)doneTitle doneBlock:(DoneBlock)block{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:doneTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        if (block != nil) {
            block();
        }
    }]];
    
    //弹出提示框；
    if ([controller isKindOfClass:[UIViewController class]]) {
        [controller presentViewController:alert animated:true completion:nil];
    }else{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
    }
}

//提示框两个按钮加动作
+ (void)sky_showAlertWithController:(id)controller Message:(NSString *)message leftTitle:(NSString *)leftTitle righTitle:(NSString *)rightTitle leftBlock:(DoneBlock)leftBlock rightBlock:(DoneBlock)rightBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (leftBlock != nil) {
            leftBlock();//点击按钮的响应事件；
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (rightBlock != nil) {
            rightBlock();//点击按钮的响应事件；
        }
    }]];
    
    //弹出提示框；
    if ([controller isKindOfClass:[UIViewController class]]) {
        [controller presentViewController:alert animated:true completion:nil];
    }else{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
    }
}

#pragma mark -- 将字符串变为可变属性的字符串
+ (NSMutableAttributedString *)sky_changeString:(NSString *)string changeRange:(NSRange)range changeColor:(UIColor *)color changeFont:(CGFloat)font {
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc] initWithString:string];
    [mutStr addAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont systemFontOfSize:font]} range:range];
    return mutStr;
}

#pragma mark -- 高斯模糊效果
+ (void)sky_blurEffectWithImagerView:(UIImageView *)imageView {
    /**
     iOS8.0
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark,
     
     // iOS 10新增的枚举值
     UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     UIBlurEffectStyleProminent NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    // 加上以下代码可以使毛玻璃特效更明亮点
    UIVibrancyEffect *vibrancyView = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyView];
    visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [effectView.contentView addSubview:visualEffectView];
    
    [imageView addSubview:effectView];
    effectView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
}

#pragma mark -- 控制闪光灯
+ (void)sky_handleTorchSwitch:(BOOL)status {
    //闪光灯控制
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];//是否有摄像头
    if (device == nil || [device hasTorch] == NO) {
        [self sky_showAlertWithController:nil Message:@"此设备不支持手电筒" doneTitle:@"确定" doneBlock:nil];
        return;
    }
    
    [device lockForConfiguration:nil];//修改前必须先锁定
    if (status) {
        [device setTorchMode:AVCaptureTorchModeOn];
    } else {
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}



#pragma mark -- 设置倒计时
+ (void)sky_cutDownTimeButton:(UIButton *)button starTime:(NSInteger)starTime starColor:(UIColor *)starColor endColor:(UIColor *)endColor starTitle:(NSString *)starTitle endTitle:(NSString *)endTitle  {
    //设置定时器
    __block NSInteger totalTime = starTime;//倒计时时间
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);//每秒执行一次
    dispatch_source_set_event_handler(_timer, ^{
        if (totalTime <= 1) {//倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = endColor;
                [button setTitle:endTitle forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
            });
        } else {
            totalTime--;
            NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)totalTime];
            dispatch_async(dispatch_get_main_queue(), ^{
                button.backgroundColor = starColor;
                [button setTitle:[NSString stringWithFormat:@"%@%@",timeStr,starTitle] forState:UIControlStateNormal];
                button.userInteractionEnabled = NO;
            });
        }
    });
    dispatch_resume(_timer);
}



#pragma mark -- 设置导航栏
//导航栏背景色
+ (void)sky_setNavWithNavController:(UINavigationController *)controller color:(UIColor *)color {
    [controller.navigationBar setShadowImage:[[UIImage alloc] init]];//去掉导航栏底部黑色线条
    UIImage *backImage = [SKYImageTool sky_getImageWithColor:color size:CGSizeMake(SKYDeviceWidth, 64)];
    [controller.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];

    //状态栏设置
    UIView *statubarView = [[UIView alloc]initWithFrame:CGRectMake(0, -20, SKYDeviceWidth, 20)];//背景色设置
    statubarView.backgroundColor = color;
    [controller.navigationBar addSubview:statubarView];
    
    //设置导航栏标题字体的颜色和字号
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSBackgroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                     };
    controller.navigationBar.titleTextAttributes = textAttributes;
    controller.navigationBar.tintColor = [UIColor whiteColor];
}


//设置导航栏左侧返回按钮
+ (void)sky_setNavBackButtonWithController:(UIViewController *)controller target:(id)target backAction:(SEL)sel {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"white_back_arrow"] forState:UIControlStateNormal];
//    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);//调整button上内容位置
    button.titleEdgeInsets      = UIEdgeInsetsMake(0, -6, 0, 0);//调整title位置

    //将UIButton包装成UIBarButtonItem
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    controller.navigationItem.leftBarButtonItem = buttonItem;
}


#pragma mark -- 颜色UIcolr十六进制
+ (UIColor *)sky_colorWithHexValue:(NSString *)valueString andAlpha:(CGFloat)alpha {
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != valueString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:valueString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:alpha];
    return result;
}


@end
