//
//  MDViewController.m
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDViewController.h"
#import <WebKit/WebKit.h>

@interface MDViewController ()

@end

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation MDViewController

@synthesize userinfo = _userinfo;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.winShake = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguages:) name:MDChangeLanguageNotification object:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.winShake = YES;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguages:) name:MDChangeLanguageNotification object:nil];
    }
    return self;
}

#pragma clang diagnostic pop
// changeLanguages: 交给子类去实现。
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.winShake = YES;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeLanguages:) name:MDChangeLanguageNotification object:nil];
    }
    return self;
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (self.winShake && motion == UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MDNotificationDeviceShake object:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    WKWebView *wk = [[WKWebView alloc]init];
//    NSURLProtocol
//    UINavigationController
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNeedReceiveLanNotify:(BOOL)needReceiveLanNotify
{
    _needReceiveLanNotify = needReceiveLanNotify;
    if (!_needReceiveLanNotify) {// 不需要多语言则删除注册了
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MDChangeLanguageNotification object:nil];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MDChangeLanguageNotification object:nil];
}

@end
