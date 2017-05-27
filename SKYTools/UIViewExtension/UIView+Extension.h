//
//  UIView+Extension.h
//  美食城
//
//  Created by ma c on 15/10/12.
//  Copyright (c) 2015年 bjsxt. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, RectCorner) {
    RectCornerTopLeft     = 1 << 0,
    RectCornerTopRight    = 1 << 1,
    RectCornerBottomLeft  = 1 << 2,
    RectCornerBottomRight = 1 << 3,
    RectCornerTopTwo      = 1 << 4,
    RectCornerBottomTwo   = 1 << 5,
};


@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

+ (UIView *)sky_getCornerViewWithBackColor:(UIColor *)backColor corner:(RectCorner)rectConer cornerRedius:(NSInteger)redius;//切任意圆角
@end
