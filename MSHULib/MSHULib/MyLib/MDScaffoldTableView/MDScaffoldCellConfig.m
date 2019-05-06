//
//  MDStaticCellConfig.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDScaffoldCellConfig.h"

@implementation MDScaffoldCellConfig
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.reuseIdentifer = @"defaultIdentifer";
        self.moveble = YES;
        self.editenble = NO;
        self.cellStyle = UITableViewCellStyleDefault;
        self.cellHeight = UITableViewAutomaticDimension;
        self.tableViewSuperClass = [UITableViewCell class];// 默认系统自带样式
        self.editingStyle = UITableViewCellEditingStyleNone;
    }
    return self;
}
@end
