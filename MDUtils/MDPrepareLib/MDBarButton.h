//
//  MDBarButton.h
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDView.h"

@class MDBarButtonItem;

@interface MDBarButton : MDView
{
    @private
    MDBarButtonItem *_item;
    UIEdgeInsets _textInset;
    @protected
    UIButton *_barButton;
}
/**
 *  导航栏按钮数据项
 */
@property (nonatomic, strong)MDBarButtonItem *item;
/**
 *  标题内填充
 */
@property (nonatomic, assign)UIEdgeInsets textInset;
/**
 *  MDBarButton初始化
 *
 *  @param item 数据项实例
 *
 *  @return MDBarButton实例
 */
- (instancetype)initWithItem:(MDBarButtonItem *)item;

@end
