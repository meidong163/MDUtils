//
//  MDView.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDView : UIView
{
    @private
    id _userinfo;
    UIEdgeInsets _inset;
}
/**
 *  自定义数据
 */
@property (nonatomic, strong)id userinfo;
/**
 *  内填充 more UIEndgeInsetsZero
 */
@property (nonatomic, assign)UIEdgeInsets inset;

/**
 *  显示黑色边框的颜色
 */
- (void)borderShow;

/**
 *  显示边框 边框大小默认1.f
 *
 *  @param borderColor 边框颜色
 */
- (void)borderShow:(UIColor *)borderColor;
/**
 *  显示边框
 *
 *  @param borderColor 边框颜色
 *  @param BorderWidth 边框宽度
 */
- (void)borderShow:(UIColor *)borderColor width:(CGFloat)BorderWidth;

@end
