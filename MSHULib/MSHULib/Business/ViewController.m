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
#import "MDTableViewCell.h"
#import "TableViewCell/MDModel.h"
#import "TableViewCell/MDSubCell.h"

// ios获取定位
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *lcManager;
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
        tableViewSection.sectionTitle = @"父类Cell";
        [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
            //配置样式
            cellConfig.cellStyle = UITableViewCellStyleDefault;
            cellConfig.cellHeight = 50;
            cellConfig.editenble = YES;
            cellConfig.tableViewSuperClass = [MDTableViewCell class];
            // 设置数据
            MDTableViewCell *thisCell = (MDTableViewCell *)cell;
            MDModel *model = [[MDModel alloc]init];
            model.name = @"小昭";
            model.pleaceHolder = @"输入年龄";
            thisCell.cellModel = model;
            
        } whenSelectedCell:^(NSIndexPath *indexPath) {
            // cell点击事件
        }];
    }];
    
    [self addSecion:^(MDScaffoldTableViewSection *tableViewSection, NSInteger sectionIndex) {
        
        tableViewSection.sectionTitle = @"子类Cell";
        [tableViewSection addCell:^(MDScaffoldCellConfig *cellConfig, UITableViewCell *cell, NSIndexPath *indexPath) {
            //配置样式
            cellConfig.cellStyle = UITableViewCellStyleDefault;
            cellConfig.cellHeight = 50;
            cellConfig.editenble = YES;
            cellConfig.tableViewSuperClass = [MDSubCell class];
            // 设置数据
            MDSubCell *thisCell = (MDSubCell *)cell;
            MDModel *model = [[MDModel alloc]init];
            model.name = @"小刁";
            model.pleaceHolder = @"输入性别";
            thisCell.cellModel = model;
            
        } whenSelectedCell:^(NSIndexPath *indexPath) {
            // cell点击事件
            @strongify(self);
            NSDebugLog(@"点击了小调");
            [self getIphoneLocation];
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


//获取地图定位
-(void)getIphoneLocation
{
    
    self.lcManager = [[CLLocationManager alloc] init];
    self.lcManager.delegate = self; // 设置代理
    self.lcManager.distanceFilter = 1000;
    self.lcManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        [self.lcManager requestAlwaysAuthorization];
        [self.lcManager requestWhenInUseAuthorization];
        [self.lcManager startUpdatingLocation];
    }
    
}

/** 获取到新的位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSString *code = [NSString stringWithFormat:@"%f/%f",location.coordinate.longitude,location.coordinate.latitude];
    NSDebugLog(@"经纬度%@",code);
    [self.lcManager stopUpdatingLocation];
}

/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.lcManager stopUpdatingLocation];
}


@end
