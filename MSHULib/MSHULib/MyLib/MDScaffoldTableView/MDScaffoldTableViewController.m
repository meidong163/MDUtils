//
//  MDStaticTableViewController.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDScaffoldTableViewController.h"
#import "Masonry.h"
@interface MDScaffoldTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *strongTableView;
@end

@implementation MDScaffoldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.strongTableView = [[UITableView alloc]init];
    self.strongTableView.delegate = self;
    self.strongTableView.dataSource = self;
    [self.view addSubview:self.strongTableView];
    
    [self.strongTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

#pragma -mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"secionContainer count = %lu",(unsigned long)self.sectionContainer.count);
    return self.sectionContainer.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MDScaffoldTableViewSection *sections = [self.sectionContainer objectAtIndex:section];
    NSLog(@"sections.cellContainer count = %lu",(unsigned long)sections.cellContainer.count);
    return sections.cellContainer.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MDScaffoldTableViewSection *setcionItem = [self.sectionContainer objectAtIndex:indexPath.section];
    MDScaffoldCellConfig *configitem = [setcionItem.cellContainer objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:configitem.reuseIdentifer];
    if (!cell) {
        cell = [[configitem.tableViewSuperClass alloc]initWithStyle:configitem.cellStyle reuseIdentifier:configitem.reuseIdentifer];
    }
    configitem.configBlock(nil,cell,indexPath);
    
    return cell;
}

#pragma -mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDScaffoldTableViewSection *setcionItem = [self.sectionContainer objectAtIndex:indexPath.section];
    MDScaffoldCellConfig *configitem = [setcionItem.cellContainer objectAtIndex:indexPath.row];
    return configitem.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!tableView.editing && !tableView.allowsMultipleSelection) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    if (tableView.editing && !tableView.allowsMultipleSelectionDuringEditing) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    MDScaffoldTableViewSection *section = [self.sectionContainer objectAtIndex:indexPath.section];
    MDScaffoldCellConfig *contentCell = [section.cellContainer objectAtIndex:indexPath.row];
    if (contentCell.whenSelectBlock) {
        contentCell.whenSelectBlock(indexPath);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    MDScaffoldTableViewSection *sectionItem = [self.sectionContainer objectAtIndex:section];
    return sectionItem.sectionTitle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDScaffoldTableViewSection *sectionItem = [self.sectionContainer objectAtIndex:indexPath.section];
    MDScaffoldCellConfig *cellConfig = [sectionItem.cellContainer objectAtIndex:indexPath.row];
    return cellConfig.editenble;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    MDScaffoldTableViewSection *sectionItem = [self.sectionContainer objectAtIndex:indexPath.section];
    MDScaffoldCellConfig *cellConfig = [sectionItem.cellContainer objectAtIndex:indexPath.row];
    return cellConfig.moveble;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     * 删除数据，刷新页面
     */
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MDScaffoldTableViewSection *sectionItem = [self.sectionContainer objectAtIndex:indexPath.section];
        MDScaffoldCellConfig *cellConfig = [sectionItem.cellContainer objectAtIndex:indexPath.row];
        NSMutableArray *sectionMutableArray = [self.sectionContainer mutableCopy];
        NSMutableArray *mutableArray = [sectionItem.cellContainer mutableCopy];
        if (mutableArray.count == 1) {
            [sectionMutableArray removeObject:sectionItem];
            self.sectionContainer = sectionMutableArray;
            [mutableArray removeObject:cellConfig];
            sectionItem.cellContainer = mutableArray;
        }else
        {
            [mutableArray removeObject:cellConfig];
            sectionItem.cellContainer = mutableArray;
        }
        [self.strongTableView reloadData];
    }else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // 暂留
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED
{
    return @"删除";
}

-(void)addSecion:(MDStaticAddSectionBlock)sectionBlock
{
    if (!self.sectionContainer) {
        self.sectionContainer = [NSArray array];
    }
    MDScaffoldTableViewSection *sectionItem = [[MDScaffoldTableViewSection alloc]init];
    if (!sectionItem.tableView) {
        sectionItem.tableView = self.strongTableView;
    }
    
    sectionBlock(sectionItem,self.sectionContainer.count + 1);
    self.sectionContainer = [self.sectionContainer arrayByAddingObject:sectionItem];
}

- (void)insertSection:(MDStaticAddSectionBlock)sectionItemBlock sectionIndex:(NSInteger)sectionIndex animate:(BOOL)animate
{
    if (!self.sectionContainer) {
        self.sectionContainer = [NSArray array];
    }
    NSMutableArray *mutableSections = [self.sectionContainer mutableCopy];
    MDScaffoldTableViewSection *sectionItem = [[MDScaffoldTableViewSection alloc]init];
    // 如果没有调用addSecion: 直接调用 insertSection:sectionIndex: 就需要添加item
    if (!sectionItem.tableView) {
        sectionItem.tableView = self.strongTableView;
    }
    sectionItemBlock(sectionItem,sectionIndex);
    [mutableSections insertObject:sectionItem atIndex:sectionIndex];
    self.sectionContainer = [NSArray arrayWithArray:mutableSections];
    if (animate) {
        [self.strongTableView beginUpdates];
        [self.strongTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];;
        [self.strongTableView endUpdates];
    }else
    {
        [self.strongTableView reloadData];
    }
}
// 测试
- (void)insertCell:(MDTableViewCellConfigBlock)configBlock whenSelected:(MDStaticCellWhenDidSeclectedBlock )whenSelectedBlock atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)aninated
{
    MDScaffoldTableViewSection *sectionItem = [self sectionAtIndex:indexPath.section];
    [sectionItem insertCell:configBlock whenSelectCell:whenSelectedBlock indexPath:indexPath animated:aninated];
}

- (void)insertSection:(MDStaticAddSectionBlock)sectionItemBlock sectionIndex:(NSInteger)sectionIndex
{
    [self insertSection:sectionItemBlock sectionIndex:sectionIndex animate:YES];
}

- (void)removeAllSections
{
    if (self.sectionContainer) {
        self.sectionContainer = [NSArray array];
        [self.strongTableView reloadData];
    }
}

- (void)removeSectionAtIndex:(NSInteger)sectionIndex
{
    [self removeSectionAtIndex:sectionIndex animate:YES];
}

- (void)removeSectionAtIndex:(NSInteger)sectionIndex animate:(BOOL)animate
{
    NSMutableArray *mutableSection = [self.sectionContainer mutableCopy];
    [mutableSection removeObjectAtIndex:sectionIndex];
    self.sectionContainer = [NSArray arrayWithArray:mutableSection];
    if (animate) {
        [self.strongTableView beginUpdates];
        [self.strongTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.strongTableView endUpdates];
    }else
    {
        [self.strongTableView beginUpdates];
        [self.strongTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationNone];
        [self.strongTableView endUpdates];
    }
    
}

@end
