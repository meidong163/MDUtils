//
//  ViewController.m
//  MDUtils
//
//  Created by 没懂 on 17/3/7.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+Meidong.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setButton:@"叫啊叫啊" sel:@selector(click) frame:CGRectMake(100, 100, 100, 30)];
}

- (UIButton *)setButton:(NSString *)buttontitle sel:(SEL)action frame:(CGRect)frame
{
    UIButton *startBtn = [[UIButton alloc]initWithFrame:frame];
    startBtn.autoresizingMask = UIViewContentModeBottom |UIViewContentModeBottomLeft | UIViewContentModeBottomRight;
    startBtn.backgroundColor = [UIColor grayColor];
    [startBtn setTitle:buttontitle forState:UIControlStateNormal];
    [startBtn addTarget:self action:action forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startBtn];
    return startBtn;
}

- (void)click
{
    [MBProgressHUD showInfoMessage:@"好消息"];
}

@end
