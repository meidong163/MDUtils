//
//  MDTabBarItem.m
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDTabBarItem.h"

@implementation MDTabBarItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selected = NO;
    }
    return self;
}
// 构造函数：初始化参数
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image imageHighlight:(UIImage *)imageHighlight tag:(NSInteger )tag
{
    if (self = [super init]) {
        self.titleColor = [UIColor grayColor];
        self.titleColorHighlight = [UIColor redColor];
        self.selected = NO;
        self.title = title;
        self.image = image;
        self.imageHighlight = imageHighlight;
        self.tag = tag;
    }
    return self ;
}

@end
