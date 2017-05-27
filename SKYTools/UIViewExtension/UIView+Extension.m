//
//  UIView+Extension.m
//  美食城
//
//  Created by ma c on 15/10/12.
//  Copyright (c) 2015年 bjsxt. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

//切任意某个圆角
+ (UIView *)sky_getCornerViewWithBackColor:(UIColor *)backColor corner:(RectCorner)rectConer cornerRedius:(NSInteger)redius {
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = backColor;
    UIRectCorner rect = 0;
    if (rectConer == RectCornerTopLeft) {
        rect = UIRectCornerTopLeft;
    }else if (rectConer == RectCornerTopRight) {
        rect = UIRectCornerTopRight;
    }else if (rectConer == RectCornerBottomLeft) {
        rect = UIRectCornerBottomLeft;
    }else if (rectConer == RectCornerBottomRight) {
        rect = UIRectCornerBottomRight;
    }else if (rectConer == RectCornerTopTwo) {
        rect = UIRectCornerTopLeft | UIRectCornerTopRight;
    }else if (rectConer == RectCornerBottomTwo) {
        rect = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rect cornerRadii:CGSizeMake(redius, redius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    return view;
}



@end
