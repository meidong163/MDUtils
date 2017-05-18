//
//  MDBarButtonItem.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDBarItem.h"

typedef NS_ENUM(NSInteger, MDBarButtonItemStyle)
{
    MDBarButtonItemStyleBordered = 1,// 普通样式
    MDBarButtonItemStyleBack, // 返回按钮样式
    MDBarButtonItemStyleCustom, // 自定义按钮样式
};

// bar 按钮数据项
@interface MDBarButtonItem : MDBarItem
/**
 *  动作
 */
@property (nonatomic, assign)SEL action;
/**
 *  动作源对象
 */
@property  (nonatomic , weak)id target;
/**
 *  按钮样式
 */
@property (nonatomic, assign)MDBarButtonItemStyle style;
/**
 *  自定义试图
 */
@property (nonatomic, strong)UIView *customView;
/**
 *  bar按钮的数据项
 *
 *  @param nTitle 标题
 *  @param target 动作源对象
 *  @param action 按钮动作
 */
- (instancetype)initWithTitle:(NSString *)nTitle target:(nullable id)target action:(nullable SEL)action;
/**
 *  Bar按钮数据项
 *
 *  @param target 动作源对象
 *  @param action 动作
 *
 *  @return back动作
 */
- (_Nonnull id)initBackWithTarget:(nullable id)target action:(nullable  SEL)action;
/**
 *  bar按钮数据项
 *
 *  @param customView 自定义按钮视图
 *
 *  @return custom按钮
 */
- (_Nonnull id)initWithCustomView:(nullable UIView *)customView;
/**
 *  默认border 图片
 *
 *  @return image数组
 */
- ( NSArray * _Nonnull )borderImages;
/**
 *  默认back 按钮图片
 *
 *  @return Image数组
 */
- (NSArray * _Nonnull)backImages;
@end
