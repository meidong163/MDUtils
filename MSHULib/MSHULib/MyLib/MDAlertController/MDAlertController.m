//
//  MDAlertController.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/28.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDAlertController.h"
#import "Masonry.h"
#import "YYKitMacro.h"
#import "UIControl+YYAdd.h"

#import "MDAlertView.h"

@interface MDAlertAction ()

@property (nullable, nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) MDAlertActionStyle style;

@property(nonatomic, copy)void (^ _Nullable hander)(MDAlertAction *_Nullable); // privite

@end

@implementation MDAlertAction

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(MDAlertActionStyle)style handler:(void (^ __nullable)(MDAlertAction * _Nullable action))handler{
    MDAlertAction *action = [[self alloc]init];
    action.title = title;
    action.style = style;
    action.hander = handler;
    return action;
}

/**
 实现copy协议

 @param zone 要考的区域
 @return 返回
 */
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    MDAlertAction *alertAction = [[[self class] alloc] init]; // 可能会有子类 子类使用super
    alertAction.title = self.title;
    alertAction.style = self.style;
    alertAction.hander = self.hander;
    return alertAction;
}

@end

@interface MDAlertController ()
@property (nonatomic, readwrite) MDAlertControllerStyle preferredStyle;

@property(nonatomic,strong)NSMutableArray<MDAlertAction *> *actionsArray;

// 暂时不实现，后续根据需要可以扩展
@property (nullable, nonatomic, readwrite) NSArray<UITextField *> *textFields;// 预留

@property(nonatomic,strong)MDAlertView *alertView;

@end

@implementation MDAlertController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(MDAlertControllerStyle)preferredStyle
{
    MDAlertController *alertVC = nil;
    if (preferredStyle == MDAlertControllerStyleAlert) {// 可以随便扩展其他样式
        alertVC = [[self alloc]initWithPreferredStyle:MDAlertControllerStyleAlert];
        alertVC.title = title;
        alertVC.message = message;
        alertVC.preferredStyle = preferredStyle;
    }else
    {
        alertVC = [[self alloc]initWithPreferredStyle:MDAlertControllerStyleActionSheet];
        alertVC.title = title;
        alertVC.message = message;
        alertVC.preferredStyle = preferredStyle;
    }
    alertVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    alertVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    return alertVC;
}


- (NSMutableArray<MDAlertAction *> *)actionsArray
{
    if (!_actionsArray) {
        _actionsArray = [NSMutableArray array];
    }
    return _actionsArray;
}

- (void)addAction:(MDAlertAction *)action
{
    [self.actionsArray addObject:action];
}

- (NSArray<MDAlertAction *> *)actions
{
    return self.actionsArray;
}

- (instancetype)initWithPreferredStyle:(MDAlertControllerStyle)style
{
    self = [super init];
    if (self) {
        if (style == MDAlertControllerStyleAlert) {
        }else // MDAlertControllerStyleActionSheet 写给动画样式 后续扩展
        {
            
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 遮罩 自定义框
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6f];
    self.view.userInteractionEnabled = YES;
    _alertView = [[MDAlertView alloc]init];
    [self.view addSubview:_alertView];
    
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 200));
    }];
    
    _alertView.titleLabel.text = self.title;
    _alertView.messageLabel.text = self.message;
   
    for (MDAlertAction* item in self.actionsArray) {
        if (item.style == MDAlertActionStyleDefault) {
            [_alertView.sureBtn setTitle:item.title forState:UIControlStateNormal];
            @weakify(self);
            [_alertView.sureBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                @strongify(self);
                item.hander(item);
                if (self.navigationController) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        
        if (item.style == MDAlertActionStyleCancel) {
            [_alertView.otherBtn setTitle:item.title forState:UIControlStateNormal];
            @weakify(self);
            [_alertView.otherBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
                @strongify(self);
                item.hander(item);
                if (self.navigationController) {
                    [self.navigationController popViewControllerAnimated:YES];
                }else
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
    }
}

// 预留待实现
- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler{}



@end
