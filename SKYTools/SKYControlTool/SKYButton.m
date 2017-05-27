//
//  SKYButton.m
//  SKY框架
//
//  Created by SKY on 17/3/31.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "SKYButton.h"
#import "SKYToolsDefine.h"

@implementation SKYButton
- (instancetype)initSearchBarButtonWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 3;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.7;
        self.layer.borderColor = RGBA(230, 230, 230, 1).CGColor;
        //搜索
        UIImageView * searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(38, 8, 12, 12)];
        searchImage.image = [UIImage imageNamed:@"icon_search"];
        [self addSubview:searchImage];
        //占位
        UILabel * placeHolder = [[UILabel alloc]init];
        placeHolder.text = @"请输入搜索内容";
        placeHolder.frame = CGRectMake(CGRectGetMaxX(searchImage.frame)+ 6,0, frame.size.width-65, 28);
        placeHolder.textColor = RGBA(210, 210, 210, 1);
        placeHolder.font = [UIFont systemFontOfSize:14];
        [self addSubview:placeHolder];
    }
    return self;
}

- (instancetype)initSearchButtonWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //搜索
        [self setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    }
    return self;
}



+ (UIButton *)sky_buttonWithTarget:(id)target action:(SEL)sel fontSize:(CGFloat)fontSize title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
