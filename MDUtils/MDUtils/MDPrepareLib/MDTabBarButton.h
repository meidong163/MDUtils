//
//  MDTabBarButton.h
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDView.h"
#import "MDTabBarItem.h"
#import "MDCustomBadge.h"
@protocol MDTabBarButtonDelegate;
@interface MDTabBarButton : MDView
{
    BOOL _highlight;
    MDTabBarItem *_barItem;

    UIButton *_mainView;
    MDView *_contentView;
    UILabel *_barTitleView;
    UIImageView *_barImageView;
    UIImageView *_barBgImageView;
    MDCustomBadge *_badge; // 自定义的badge
}
/**
 *  tab的代理
 */
@property  (nonatomic , weak)id<MDTabBarButtonDelegate> delegate;
/**
 *  selected bar
 */
@property (nonatomic, assign)BOOL highlight;
/**
 *  tab中的数据项
 */
@property (nonatomic, strong)MDTabBarItem *barItem;
/**
 *  显示badge
 */
- (void)showBadge;
/**
 *  隐藏badge
 */
- (void)hideBadge;
@end

@protocol MDTabBarButtonDelegate <NSObject>

@optional
/**
 *  TabBarButton
 *
 *  @param tabbarButton MDTabBarButton实例
 *  @param item MDTabBarButton实例数据项MDTabBarItem
 */
-(void)mdTabBarButton:(MDTabBarButton *)tabbarButton clickWithItem:(MDTabBarItem * )item;

@end