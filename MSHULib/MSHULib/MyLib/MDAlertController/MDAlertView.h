//
//  MDAlertView.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDAlertView : UIView
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UIButton *otherBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *messageLabel;
@end

NS_ASSUME_NONNULL_END
