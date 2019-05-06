//
//  MDTabBarButton.m
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDTabBarButton.h"

@interface MDTabBarButton()
@property (nonatomic, strong)NSLayoutConstraint *constriant;
@end

@implementation MDTabBarButton
@synthesize highlight = _highlight;
@synthesize barItem = _barItem;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化视图的层级关系
        [self setBackgroundColor:[UIColor clearColor]];
        _highlight = NO;
        _barBgImageView = [[UIImageView alloc]init];
        [_barBgImageView setBackgroundColor:[UIColor clearColor]];
        [_barBgImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_barBgImageView];

        _contentView = [MDView new];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
        UITapGestureRecognizer *mainViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(barButtonPressed:)];
        [_contentView addGestureRecognizer:mainViewTap];
        [self addSubview:_contentView];

        _barImageView = [UIImageView new];
        [_barImageView setBackgroundColor:[UIColor clearColor]];
        _barImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_contentView addSubview:_barImageView];

        _barTitleView = [UILabel new];
        _barTitleView.translatesAutoresizingMaskIntoConstraints = NO;
        [_barTitleView setBackgroundColor:[UIColor clearColor]];
        [_barTitleView setFont:[UIFont systemFontOfSize:18.f]];
        [_barTitleView setTextColor:[UIColor whiteColor]];

        _badge = [MDCustomBadge customBadgeWithString:@"" withStringColor:[UIColor whiteColor] withInsetColor:[UIColor redColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor clearColor] withScale:1.0 withShining:NO];
        _badge.translatesAutoresizingMaskIntoConstraints = NO;
        _badge.hidden = YES;
        [_barImageView addSubview: _badge];

#ifdef UITextAligmentCenter
        [_barTitleView setTextAlignment:UITextAlignmentCenter];
#else
        [_barTitleView setTextAlignment:NSTextAlignmentCenter];
#endif
        [_contentView addSubview:_barTitleView];
    }
    return self;
}
// tabBar中的view 排版。这排版有点没有看懂
- (void)layoutSubviews
{
    CGSize titleSize = CGSizeMake(_contentView.width, 21.f);
    CGSize barImgSize = CGSizeZero;
    if (self.barItem) {
        if (self.barItem.titleFont) {
            [_barTitleView setFont:self.barItem.titleFont];
        }
        if (self.barItem.title) {
#ifdef UILineBreakByTruncatingTail
            titleSize = [self.barItem.title sizeWithFont:self.barItem.titleFont forWidth:_contentView.width lineBreakMode:UILineBreakByTruncatingTail];
#else
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            titleSize = [self.barItem.title sizeWithFont:self.barItem.titleFont forWidth:_contentView.width lineBreakMode:NSLineBreakByTruncatingTail];
#endif
#pragma clang diagnostic pop
        }
        else{
            titleSize = CGSizeZero;
        }
        if (self.barItem.image) {
            barImgSize = self.barItem.image.size;
        }
        else{
            barImgSize = CGSizeZero;
        }
    }

    // state
    if (self.highlight) {
        [_barTitleView setTextColor:self.barItem.titleColorHighlight];
        [_barImageView setImage:self.barItem.imageHighlight];
        [_barBgImageView setImage:self.barItem.imageHighlight];
    }
    else{
        [_barTitleView setTextColor:self.barItem.titleColor];
        [_barImageView setImage:self.barItem.image];
        [_barBgImageView setImage:self.barItem.imageBackground];
    }
    // text
    [_barTitleView setText:self.barItem.title];

    if (self.constraints.count > 0) {
        [self removeConstraints:self.constraints];
    }

    NSDictionary *barDic = NSDictionaryOfVariableBindings(_barImageView,_barTitleView,_contentView, _badge);

    NSString *HStr = @"H:|-0-[_contentView]-0-|";
    NSString *VStr = @"V:|-0-[_contentView]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:HStr options:0 metrics:nil views:barDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:VStr options:0 metrics:nil views:barDic]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:self.barItem.barImageVLeadSeace options:0 metrics:nil views:barDic]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_barTitleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_barImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeHeight multiplier:self.barItem.layoutRates.HeightRate constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_barImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeWidth multiplier:self.barItem.layoutRates.widthRate constant:0]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:_barImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_barTitleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];

    HStr = @"H:[_badge(15)]";
    VStr = @"V:[_badge(15)]";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:HStr options:0 metrics:nil views:barDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:VStr options:0 metrics:nil views:barDic]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_badge attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_barImageView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_badge attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_barImageView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];

    [super layoutSubviews];
}

- (void)barButtonPressed:(id)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(mdTabBarButton:clickWithItem:)]) {
            [self.delegate mdTabBarButton:self clickWithItem:self.barItem];
        }
    }
}

- (void)showBadge
{
    _badge.hidden = NO;
}

- (void)hideBadge
{
    _badge.hidden = YES;
}
/*写到目前这个地方，目标就是写一个自定义的tabbar的控制器了，或许连window都需要自定义了*/

@end
