//
//  MDTabBar.m
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDTabBar.h"
#import "MDBarButton.h"
@interface MDTabBar(MDLibraryPrivate)
- (void)resetItemView:(NSArray *)items;
@end

@implementation MDTabBar
@synthesize bgImg = _bgImage;
@synthesize items = _items;
@synthesize selectedItem = _selectItem;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        _mainView = [[MDView alloc]initWithFrame:MDFrameAllInset(frame)];
        [_mainView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_mainView];

        _bgView = [[UIImageView alloc]initWithFrame:MDFrameAllInset(_mainView.frame)];
        [_bgView setContentMode:UIViewContentModeScaleToFill];
        [_bgView setBackgroundColor:[UIColor clearColor]];
        [_mainView addSubview:_bgView];

        _contentView = [[MDView alloc]initWithFrame:MDFrameInset(_mainView.frame, self.inset)];
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_contentView];

        _itemsView = [[MDView alloc]initWithFrame:MDFrameAllInset(_contentView.frame)];
        [_itemsView setBackgroundColor:[UIColor clearColor]];
        [_itemsView setContentMode:UIViewContentModeScaleToFill];
        [_contentView addSubview:_itemsView];

        _lastSelected = -1;
        _items = [NSArray array];
        _contentClips = NO;

    }
    return self;
}

// 视图刷新时，系统调。
- (void)layoutSubviews
{   // layout
    CGRect frame = self.frame;
    [_mainView setFrame:MDFrameAllInset(frame)];
    [_bgView setFrame:MDFrameAllInset(_mainView.frame)];
    [_contentView setFrame:MDFrameInset(_mainView.frame, self.inset)];
    [_itemsView setFrame:MDFrameAllInset(_contentView.frame)];

    // Views
    [_bgView setImage:self.bgImg];
    [self resetItemView:self.items];
    [_contentView setClipsToBounds:self.contentClips];
    [super layoutSubviews];
}

- (void)setSelectedItem:(MDTabBarItem *)selectedItem
{
    if (_selectItem != selectedItem) {
        _selectItem = selectedItem;
        // 选择的item
        NSInteger index = [_items indexOfObject:_selectItem];
        if (index == NSIntegerMax) {
            index = -1;
        }
        //  取消旧选项
//        MDBarButton *
    }
}
@end
