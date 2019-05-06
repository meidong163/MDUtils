//
//  ViewController.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/28.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MDAlertController.h"
#import "AddressBook/MDAddressBookViewController.h"

#import "AddressBook/MDCommon.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"demo";
    
    @weakify(self);
    [self addSecion:^(MDScaffoldTableViewSection *tableViewSection, NSInteger sectionIndex) {
        @strongify(self);
        tableViewSection.sectionTitle = @"T";// 还没有实现
        [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
            cellConfig.cellStyle = UITableViewCellStyleDefault;
            cellConfig.cellHeight = 40;
            cellConfig.editenble = YES;
            cell.textLabel.text = @"通讯录";
        } whenSelectedCell:^(NSIndexPath *indexPath) {
            MDAddressBookViewController *adVC = [[MDAddressBookViewController alloc]init];
            [self.navigationController pushViewController:adVC animated:YES];
        }];
        [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
            cellConfig.cellStyle = UITableViewCellStyleDefault;
            cellConfig.cellHeight = 50;
            cellConfig.editenble = NO;
            cell.textLabel.text = @"美女照片";
        } whenSelectedCell:^(NSIndexPath *indexPath) {
            
        }];
    }];
    
    [self addSecion:^(MDScaffoldTableViewSection *tableViewSection, NSInteger sectionIndex) {
        tableViewSection.sectionTitle = @"O";// 还没有实现
        [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
            cellConfig.cellStyle = UITableViewCellStyleDefault;
            cellConfig.cellHeight = 40;
            cellConfig.editenble = YES;
            cell.textLabel.text = @"其他";
        } whenSelectedCell:^(NSIndexPath *indexPath) {
            // cell点击事件
        }];
    }];
    
}

- (void)click:(id)sender
{
    MDAlertController *alertVC = [MDAlertController alertControllerWithTitle:@"提示" message:@"消息" preferredStyle:MDAlertControllerStyleAlert];
    MDAlertAction *sureAction = [MDAlertAction actionWithTitle:@"确定" style: MDAlertActionStyleDefault handler:^(MDAlertAction * _Nullable action) {
        NSLog(@"确定");
    }];
    MDAlertAction *cancle = [MDAlertAction actionWithTitle:@"取消" style: MDAlertActionStyleCancel handler:^(MDAlertAction * _Nullable action) {
        NSLog(@"好");
    }];
    [alertVC addAction:sureAction];
    [alertVC addAction:cancle];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)writePhoneToContacts
{
    for (int i = 0; i<20; i++) {
        [[MDCommon new]saveYdCallAnswerPhoneToAdrBook];
    }
}


@end
