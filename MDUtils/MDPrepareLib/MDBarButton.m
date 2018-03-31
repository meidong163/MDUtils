//
//  MDBarButton.m
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDBarButton.h"
#import "MDBarButtonItem.h"
@implementation MDBarButton
@synthesize item = _item;
@synthesize textInset = _textInset;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _barButton.frame = MDFrameAllInset(frame);
        [_barButton setBackgroundColor:[UIColor clearColor]];
        [_barButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_barButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_barButton addTarget:self action:@selector(barClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_barButton];
    }
    return self;
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)barClick:(id)sender
{
    if (self.item.target) {
        if (self.item.target) {
            if ([self.item.target respondsToSelector:self.item.action]) {
                [self.item.target performSelector:self.item.action];
            }
        }
    }
}
#pragma clang diagnostic pop

- (instancetype)initWithItem:(MDBarButtonItem *)item
{
    if (self = [self initWithFrame:CGRectZero]) {
        _item = item;
    }
    return self;
}

-(void)layoutSubviews
{
    CGRect frame = self.frame;
    if (self.item) {// 使用边框填充视图
        _barButton.frame = MDFrameInset(frame,self.inset);
        if (self.item.style == MDBarButtonItemStyleCustom) {
            // 是否是子视图
            if (![self.item.customView isDescendantOfView:self]) {
                [self addSubview:self.item.customView];
            }
            /*填充矩形框*/
            [self.item.customView setFrame:MDFrameInset(frame, self.inset)];
        }
    }else if (self.item.style == MDBarButtonItemStyleBordered)
    {
        if (self.item.customView) {
            if ([self.item.customView isDescendantOfView:self]) {
                [self.item.customView removeFromSuperview];// 自定义的view从父视图上移除
            }
        }

        // 设置button 按钮填充参数
        [_barButton setContentEdgeInsets:self.inset];
        if (!MDisiOS7Later) {
            [_barButton setBackgroundImage:self.item.image forState:UIControlStateNormal];
            [_barButton setBackgroundImage:self.item.imageHighlight forState:UIControlStateHighlighted];
        }else{
            [_barButton setImage:self.item.image forState:UIControlStateNormal];
            [_barButton setImage:self.item.imageHighlight forState:UIControlStateHighlighted];
            [_barButton setImageEdgeInsets:UIEdgeInsetsZero];
        }

        // 设置标题
        [_barButton setTitle:self.item.title forState:UIControlStateNormal];
        [_barButton setTitle:self.item.title forState:UIControlStateHighlighted];
        [_barButton setTitleColor:self.item.titleColor forState:UIControlStateNormal];
        [_barButton setTitleColor:self.item.titleColorHighlight forState:UIControlStateHighlighted];
        [_barButton.titleLabel setFont:self.item.titleFont];
    }// 返回按钮
    else if (self.item.style == MDBarButtonItemStyleBack)
    {
        if (self.item.customView) {
            if ([self.item.customView isDescendantOfView:self]) {
                [self.item.customView removeFromSuperview];
            }
        }
        [_barButton setContentEdgeInsets:self.inset];
        if (MDisiOS7Later) {
            [_barButton setImage:self.item.image forState:UIControlStateNormal];
            [_barButton setImage:self.item.imageHighlight forState:UIControlStateHighlighted];
            //
            [_barButton setImageEdgeInsets:UIEdgeInsetsMake(3, 9, 3, 40)];
        }else
        {
            [_barButton setBackgroundImage:self.item.imageBackground forState:UIControlStateNormal];
            [_barButton setBackgroundImage:self.item.imageBackgroundHighlight forState:UIControlStateHighlighted];
            [_barButton setTitle:self.item.title forState:UIControlStateNormal];
            [_barButton setTitle:self.item.title forState:UIControlStateHighlighted];
        }
        // 设置两种颜色下标题的颜色
        [_barButton setTitleColor:self.item.titleColor forState:UIControlStateNormal];
        [_barButton setTitleColor:self.item.titleColorHighlight forState:UIControlStateHighlighted];
        [_barButton.titleLabel setFont:self.item.titleFont];
    }
    [super layoutSubviews];
}

@end
