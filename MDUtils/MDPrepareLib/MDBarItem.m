//
//  MDBarItem.m
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDBarItem.h"

@implementation MDBarItem
@synthesize enabled = _enabled;
@synthesize title = _title;
@synthesize image = _image;
@synthesize imageHighlight = _imageHighlight;
@synthesize imageBackground = _imageBackground;
@synthesize imageBackgroundHighlight = _imageBackgroundHighlight;
@synthesize titleColor = _titleColor;
@synthesize titleColorHighlight = _titleColorHightlight;
@synthesize titleFont =_titleFont;
@synthesize contentInset = _contentInset;
@synthesize layoutRates = _layoutRates;
@synthesize barImageVLeadSeace = _barImageVLeadSeace;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化属性。
        self.enabled = YES;
        self.title = @"没懂标题";
        self.image = nil;
        self.imageHighlight = nil;
        self.imageBackground = nil;
        self.imageBackgroundHighlight = nil;
        self.titleColor = [UIColor grayColor];
        self.titleColorHighlight = [UIColor redColor];
        self.titleFont = [UIFont systemFontOfSize:12.f];
        self.contentInset = UIEdgeInsetsZero;
        self.layoutRates = TabItemLayOutRatesMake(0.324,0.493);
        self.barImageVLeadSeace = @"V:|-2-[_barImageView]-3-[_barTitleView]-0-|";// image和title在竖直方向上的约束
    }
    return self;
}
@end
