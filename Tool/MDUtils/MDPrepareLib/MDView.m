//
//  MDView.m
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDView.h"

@interface MDView(private)
// 暂时没有用
//- (void)initView;
@end

@implementation MDView
@synthesize userinfo = _userinfo;
@synthesize inset = _inset;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _userinfo = nil;
        _inset = UIEdgeInsetsZero;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)borderShow
{
    [self borderShow:[UIColor blackColor]];
}

- (void)borderShow:(UIColor *)borderColor
{
    [self borderShow:borderColor width:1.f];
}

- (void)borderShow:(UIColor *)borderColor width:(CGFloat)BorderWidth
{
    [self.layer setBorderColor:borderColor.CGColor];
    [self.layer setBorderWidth:BorderWidth];
}
@end
