//
//  MDTabBar.h
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDView.h"
#import "MDTabBarItem.h"
@protocol MDTabBarDelegate;

@interface MDTabBar : MDView
{
    @private
    UIImage *_bgImage;
    NSArray *_items;
    MDTabBarItem *_selectItem;
    BOOL _contentClips;

    @protected
    MDView *_mainView;
    MDView* _contentView;
    UIImageView *_bgView;
    MDView *_itemsView;
    NSInteger _lastSelected;

}
/**
 *  tab背景图片
 */
@property (nonatomic, strong)UIImage *bgImg;
/**
 *  tab数据列表数据项
 */
@property (nonatomic, strong)NSArray *items;
/**
 *  Tab选中的数据项
 */
@property (nonatomic, strong)MDTabBarItem *selectedItem;
/**
 *  tab代理
 */
@property (nonatomic, assign)id<MDTabBarDelegate> delegate;
/**
 *  子视图超出的部分将被裁减隐藏 默认NO
 */
@property (nonatomic, assign)BOOL contentClips;
/**
 *  根据索引显示红点
 *
 *  @param barIndex
 */
- (void)showBadgeWithTabBarItemIndex:(NSInteger)barIndex;
/**
 *  根据索引隐藏红点
 *
 *  @param barIndex  tabbarItem 索引
 */
- (void)hideBadgeWithTabBarItemIndex:(NSInteger)barIndex;

@end

@protocol MDTabBarDelegate <NSObject>

@optional
/**
 *  tabBar选中的项事件
 *
 *  @param tabbar Tabbar实例
 *  @param item   TabBar实例选中项
 */
- (void)mdTabBar:(MDTabBar *)tabbar didSelectItem:(MDTabBarItem *)item;
@end