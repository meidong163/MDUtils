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
    self.title = @"demo";
    [self addSecion:^(MDScaffoldTableViewSection *tableViewSection, NSInteger sectionIndex) {
        tableViewSection.sectionTitle = @"test";
        [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
            cell.textLabel.text = @"MDScaffoldTableViewController 使用";
        } whenSelectedCell:^(NSIndexPath *indexPath) {
            NSLog(@"\n 1. pod 安装 或者 拖MDScaffoldTableView到工程 \n 2. 继承MDScaffoldTableViewController \n 3.使用");
        }];
    }];

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
