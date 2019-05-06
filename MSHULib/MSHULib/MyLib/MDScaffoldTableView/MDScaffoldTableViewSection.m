//
//  MDStaticTableViewSection.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDScaffoldTableViewSection.h"
#import "MDScaffoldCellConfig.h"

@implementation MDScaffoldTableViewSection

- (void)addCellWithConfig:(MDTableViewCellConfigBlock)config
{
    [self addCell:config whenSelectedCell:nil];
}

- (void)addCell:(MDTableViewCellConfigBlock)cellConfigBlock whenSelectedCell:(MDStaticCellWhenDidSeclectedBlock )selectCellBlock
{
    if (!self.cellContainer) {
        self.cellContainer = [NSArray array];
    }
    MDScaffoldCellConfig *config = [[MDScaffoldCellConfig alloc]init];
    config.configBlock = [cellConfigBlock copy];
    config.whenSelectBlock = [selectCellBlock copy];
    cellConfigBlock(config,nil,nil);
    self.cellContainer = [self.cellContainer arrayByAddingObject:config];
}

- (void)insertCell:(MDTableViewCellConfigBlock)cellConfigBlock whenSelectCell:(MDStaticCellWhenDidSeclectedBlock )selectCellBlock indexPath:(NSIndexPath *)indexPath animated:(BOOL)animated
{
    
    if (!self.cellContainer) {
        self.cellContainer = [NSArray array];
    }
    NSMutableArray *mutableCells = [self.cellContainer mutableCopy];
    MDScaffoldCellConfig *config = [[MDScaffoldCellConfig alloc]init];
    config.configBlock = [cellConfigBlock copy];
    config.whenSelectBlock = [selectCellBlock copy];
    cellConfigBlock(config,nil,nil);
    [mutableCells insertObject:self.cellContainer atIndex:indexPath.row];
    self.cellContainer = [NSArray arrayWithArray:mutableCells];
    
    if (animated)
    {
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }else
    {
        [self.tableView reloadData];
    }
}


- (void)removeAllCellsFromSection
{
    self.cellContainer = [NSArray array];
    [self.tableView reloadData];
}

- (void)removeCellAtIndex:(NSInteger)rowIndex
{
    [self removeCellAtIndex:rowIndex annimated:YES];
}

- (void)removeCellAtIndex:(NSInteger)rowIndex annimated:(BOOL)annited
{
    NSMutableArray *cells = [self.cellContainer copy];
    [cells removeObjectAtIndex:rowIndex];
    if (annited) {
        [self.tableView beginUpdates];
        // 默认只有一个Section
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowIndex inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }else
    {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
    }
}
@end
