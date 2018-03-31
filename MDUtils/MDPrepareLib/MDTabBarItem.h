//
//  MDTabBarItem.h
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDBarItem.h"

@interface MDTabBarItem : MDBarItem
{
    @private
    BOOL _selected;
}
/**
 *  是否已选中，默认NO
 */
@property (nonatomic, assign)BOOL selected;
/**
 *  初始化标签数据
 *
 *  @param title          标题
 *  @param image          icon
 *  @param imageHighlight 高亮icon
 *  @param tag            标记
 *
 *  @return 标签数据实例
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image imageHighlight:(UIImage *)imageHighlight tag:(NSInteger)tag;

@end
