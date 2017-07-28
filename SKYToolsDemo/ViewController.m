//
//  ViewController.m
//  SKYToolsDemo
//
//  Created by SKY on 17/5/26.
//  Copyright © 2017年 SKY. All rights reserved.
//

#import "ViewController.h"
#import "SKYTools.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *label = [UILabel sky_labelWithText:@"jadhjkhkj" fontSize:13 textColor:SKYHexColor(@"dfdfdf", 1)];
    label.frame = CGRectMake(30, 80, 150, 20);
    [self.view addSubview:label];
    //一个github对应一个ssh key
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
