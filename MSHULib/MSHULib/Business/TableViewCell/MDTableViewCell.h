//
//  MDTableViewCell.h
//  MSHULib
//
//  Created by 舒江波 on 2019/5/8.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDTableViewCell : UITableViewCell

@property(nonatomic,strong)MDModel *cellModel;



@end

NS_ASSUME_NONNULL_END
