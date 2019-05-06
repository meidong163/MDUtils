//
//  MDBarButtonItem.m
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDBarButtonItem.h"



@implementation MDBarButtonItem
@synthesize action = _action;
@synthesize target = _target;
@synthesize style = _style;
@synthesize customView = _customView;


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = MDBarButtonItemStyleBordered;
        self.customView = nil;
    }
    return self;
}
// 用［self borderImages］配置 前景 背景图片
- (instancetype)initWithTitle:(NSString *)nTitle target:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.title = nTitle;
        self.target = target;
        self.action = action;
        self.style = MDBarButtonItemStyleBordered;
        @try {
            NSArray * imgs = [self borderImages];
            if (imgs && imgs.count==2)
            {
                if ([[imgs objectAtIndex:0] isKindOfClass:[UIImage class]])
                {
                    // 设置前景图片
                    self.image = [imgs objectAtIndex:0];
                }
                if ([[imgs objectAtIndex:1] isKindOfClass:[UIImage class]]) {
                    self.imageHighlight = [imgs objectAtIndex:1];
                }
            }
        } @catch (NSException *exception)
        {
            self.image = nil;
            self.imageHighlight = nil;
        }
    }
    return  self;
}
// 初始化back按钮
- (id)initBackWithTarget:(id)target action:(SEL)action
{
    if (self = [super init])
    {
        self.target = target;
        self.action = action;
        self.style = MDBarButtonItemStyleBack;
        @try {
            NSArray * imgs = [self backImages];
            if (imgs && imgs.count==2)
            {
                if ([[imgs objectAtIndex:0] isKindOfClass:[UIImage class]])
                {
                    // 设置前景图片
                    self.imageBackground = [imgs objectAtIndex:0];
                }
                if ([[imgs objectAtIndex:1] isKindOfClass:[UIImage class]]) {
                    self.imageBackgroundHighlight = [imgs objectAtIndex:1];
                }
            }
        } @catch (NSException *exception)
        {
            self.imageBackground = nil;
            self.imageBackgroundHighlight = nil;
        }
    }
    return  self;
}

- (id)initWithCustomView:(UIView *)customView
{
    if (self = [super init]) {
        self.style = MDBarButtonItemStyleCustom;
        self.customView = customView;
    }
    return self;
}

- (NSArray *)borderImages
{
    return nil;
}

- (NSArray *)backImages
{
    return nil;
}
/**
 *  mattt问题 1.back按钮为什么单独拿出来
 *           2. 设计的action target没有用到，子类用什么样的方式去做呢？
 *           3. 后续改进是一键创建，用 block做。
 */


@end
