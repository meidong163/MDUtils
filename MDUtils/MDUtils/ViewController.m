//
//  ViewController.m
//  MDUtils
//
//  Created by 没懂 on 17/3/7.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+Meidong.h"
#import "Pepole.h"
#import "Book.h"
@interface ViewController ()

@property (nonatomic, assign)BOOL flag;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setButton:@"叫啊叫啊" sel:@selector(click) frame:CGRectMake(100, 100, 100, 30)];
//    [self checknil:@"haha"];

    NSLog(@"%@",self.flag ? @"Yes":@"No");
    MDLog(@"%@",@"哈哈哈");


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

- (void )checknil:(NSString *)nilString
{
    NSAssert(nilString==nil, @"nil is nil");
    NSLog(@"%@",nilString);
    return;
}

- (void)click
{
    [MBProgressHUD showInfoMessage:@"好消息"];
}


-(void)didReceiveMemoryWarning
{

}

- (void)obj2DictTest
{   // 多对象使用。
    Book *book = [[Book alloc]initWithDictionary:@{
                                                   @"name":@"鬼谷子",
                                                   @"price":@59,
                                                   }];
    NSDictionary *dict = @{
                           @"name":@"meidong",
                           @"age":@20,
                           @"book":book
                           };
    Pepole *p = [[Pepole alloc]initWithDictionary:dict];
    MDLog(@"%@",[p object2Dictionary]);
}
@end
