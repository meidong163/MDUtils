//
//  MDStaticTableViewSection.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDStaticCellDefine.h"
NS_ASSUME_NONNULL_BEGIN

@interface MDScaffoldTableViewSection : NSObject

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *cellContainer;

@property (nonatomic, strong) NSString *sectionTitle;

/**
 添加一个Cell配置

 @param config cell配置
 */
- (void)addCellWithConfig:(MDTableViewCellConfigBlock)config;

/**
 添加一个cell配置及事件

 @param cellConfigBlock 配置
 @param selectCellBlock 点击事件
 */
- (void)addCell:(MDTableViewCellConfigBlock)cellConfigBlock whenSelectedCell:(MDStaticCellWhenDidSeclectedBlock)selectCellBlock;

/**
  添加一个cell配置及事件

 @param cellConfigBlock cell配置
 @param selectCellBlock cell点击事件
 @param indexPath indexPath
 @param animated 是否有动画
 */
- (void)insertCell:(MDTableViewCellConfigBlock)cellConfigBlock whenSelectCell:(MDStaticCellWhenDidSeclectedBlock )selectCellBlock indexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

/**
 从一个section移除所有的cell
 */
- (void)removeAllCellsFromSection;

/**
 移除index位置上的cell

 @param rowIndex index
 */
- (void)removeCellAtIndex:(NSInteger)rowIndex;

/**
 移除index位置上的cell

 @param rowIndex rowi index
 @param annited 是否有动画
 */
- (void)removeCellAtIndex:(NSInteger)rowIndex annimated:(BOOL)annited;
@end

NS_ASSUME_NONNULL_END
