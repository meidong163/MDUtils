//
//  MDBarItem.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDItem.h"

typedef struct TabItemLayoutRates
{
    CGFloat widthRate,HeightRate;
}TabItemLayoutRates;

UIKIT_STATIC_INLINE TabItemLayoutRates TabItemLayOutRatesMake(CGFloat widthRate, CGFloat heightRate)
{
    TabItemLayoutRates layoutRates = {widthRate,heightRate};
    return layoutRates;
}

@interface MDBarItem : MDItem
{
    @private
    BOOL _enabled;
    NSString *_title;
    UIImage *_image;
    UIImage *_imageHighlight;
    UIImage *_imageBackground;
    UIImage *_imageBackgroundHighlight;
    UIColor *_titleColor;
    UIColor *_titleColorHightlight;
    UIFont *_titleFont;
    UIEdgeInsets _contentInset;
}
/**
 *  Item 是否可用
 */
@property (nonatomic, assign)BOOL enabled;
/**
 *  Item 标题
 */
@property (nonatomic, copy)NSString *title;
/**
 *  item前景图片
 */
@property (nonatomic, strong)UIImage  *image;
/**
 *  item前景高亮图片
 */
@property (nonatomic, strong)UIImage *imageHighlight;
/**
 *  item背景图片
 */
@property (nonatomic, strong)UIImage *imageBackground;
/**
 *  item背景高亮图片
 */
@property (nonatomic, strong)UIImage *imageBackgroundHighlight;
/**
 *  标题颜色
 */
@property (nonatomic, strong)UIColor *titleColor;
/**
 *  标题高亮颜色
 */
@property (nonatomic, strong)UIColor *titleColorHighlight;
/**
 *  标题字体
 */
@property (nonatomic, strong)UIFont *titleFont;
/**
 *  内填充
 */
@property (nonatomic, assign)UIEdgeInsets contentInset;
/**
 *  barButton 内容配置约束
 */
@property (nonatomic, copy)NSString *barImageVLeadSeace;
/**
 *  图片随设备类型大小配置
 */
@property (nonatomic, assign)TabItemLayoutRates layoutRates;


@end
