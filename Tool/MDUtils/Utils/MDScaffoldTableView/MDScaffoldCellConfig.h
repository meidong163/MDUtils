//
//  MDStaticCellConfig.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDStaticCellDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDScaffoldCellConfig : NSObject

/**
 cell 高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 复用标识
 */
@property (nonatomic, strong) NSString *reuseIdentifer;

/**
 cell 样式
 */
@property (nonatomic) UITableViewCellStyle cellStyle;

/**
 创建cell 的那个类
 */
@property (nonatomic, strong)Class tableViewSuperClass;

/**
 是否能编辑
 */
@property (nonatomic, assign)BOOL editenble;

/**
 是否能移动
 */
@property (nonatomic, assign)BOOL moveble;

/**
 编辑的样式
 */
@property (nonatomic) UITableViewCellEditingStyle editingStyle;

/**
 cell 配置
 */
@property (nonatomic, copy)MDTableViewCellConfigBlock configBlock;

/**
 table view cell select 点击事件回调
 */
@property (nonatomic, copy)MDStaticCellWhenDidSeclectedBlock whenSelectBlock;

@end

NS_ASSUME_NONNULL_END
