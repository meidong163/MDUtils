//
//  MDStaticCellConfig.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MDScaffoldCellConfig, MDScaffoldTableViewSection;

typedef void (^MDTableViewCellConfigBlock)(MDScaffoldCellConfig* cellConfig,UITableViewCell *cell, NSIndexPath *indexPath);

typedef void (^MDStaticCellWhenDidSeclectedBlock)(NSIndexPath *indexPath);

typedef void (^MDStaticAddSectionBlock)(MDScaffoldTableViewSection *tableViewSection, NSInteger sectionIndex);
