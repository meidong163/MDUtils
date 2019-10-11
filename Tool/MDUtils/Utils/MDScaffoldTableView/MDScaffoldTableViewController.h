//
//  MDStaticTableViewController.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDStaticCellDefine.h"
#import "MDScaffoldTableViewSection.h"
#import "MDScaffoldCellConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDScaffoldTableViewController : UIViewController
@property (nonatomic, strong) NSArray *sectionContainer;

@property (nonatomic, strong) NSString *headerTitle;

@property (nonatomic, strong) NSString *footerTitle;

/**
 添加一个分区

 @param sectionBlock 分区
 */
- (void)addSecion:(MDStaticAddSectionBlock)sectionBlock;

/**
 在SectionList中 插入某个SecionItem

 @param sectionItemBlock SecionItem
 @param sectionIndex SecionItem的位置
 */
- (void)insertSection:(MDStaticAddSectionBlock)sectionItemBlock sectionIndex:(NSInteger)sectionIndex;

/**
 在SectionList中 插入某个SecionItem

 @param sectionItemBlock SecionItem
 @param sectionIndex SecionItem的位置
 @param animate 是否有动画
 */
- (void)insertSection:(MDStaticAddSectionBlock)sectionItemBlock sectionIndex:(NSInteger)sectionIndex animate:(BOOL)animate;


/**
 移除所有Section
 */
- (void)removeAllSections;

/**
 移除某个位置的Section

 @param sectionIndex 位置
 */
- (void)removeSectionAtIndex:(NSInteger)sectionIndex;

/**
 移除某个位置的Section

 @param sectionIndex 位置
 @param animate 动画
 */
- (void)removeSectionAtIndex:(NSInteger)sectionIndex animate:(BOOL)animate;

/**
 返回sectionIndex 位置的section item

 @param sectionIndex 位置
 @return section item
 */
- (MDScaffoldTableViewSection *)sectionAtIndex:(NSInteger)sectionIndex;

/**
 当前section 插入cell

 @param configBlock cell的配置
 @param indexPath 位置
 @param aninated 是否有动画
 */
- (void)insertCell:(MDTableViewCellConfigBlock)configBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)aninated;

/**
 当前section 插入cell

 @param configBlock cell 配置
 @param whenSelectedBlock 点击cell 回调事件
 @param indexPath 位置
 @param aninated 是否有动画
 */
- (void)insertCell:(MDTableViewCellConfigBlock)configBlock whenSelected:(MDStaticCellWhenDidSeclectedBlock )whenSelectedBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)aninated;

@end

NS_ASSUME_NONNULL_END
