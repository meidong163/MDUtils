//
//  MDWindow.m
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDWindow.h"

NSString *const MDNotificationDeviceShake = @"com.yitong.device.shake";

@implementation MDWindow
@synthesize winShake = _winShake;// 设计一个初始的默认值为yes的初始值，一般初始值为NO

// 设计初始值
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _winShake = YES;
    }
    return self;
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (_winShake && motion== UIEventSubtypeMotionShake) {
        [[NSNotificationCenter defaultCenter]postNotificationName:MDNotificationDeviceShake object:self];
        // 用win来监听晃动
    }
}

@end
