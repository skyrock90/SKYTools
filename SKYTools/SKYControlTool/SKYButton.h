//
//  SKYButton.h
//  SKY框架
//
//  Created by SKY on 17/3/31.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKYButton : UIButton
- (instancetype)initSearchBarButtonWithFrame:(CGRect)frame;
- (instancetype)initSearchButtonWithFrame:(CGRect)frame;
+ (UIButton *)sky_buttonWithTarget:(id)target action:(SEL)sel fontSize:(CGFloat)fontSize title:(NSString *)title;
@end
