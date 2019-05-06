//
//  MDAlertView.m
//  MSHULib
//
//  Created by 舒江波 on 2019/4/29.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDAlertView.h"
#import "Masonry.h"

@implementation MDAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.titleLabel];
        
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:self.messageLabel];
        
        self.sureBtn = [[UIButton alloc]init];
        [self.sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:self.sureBtn];
        
        self.otherBtn = [[UIButton alloc]init];
        [self.otherBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self addSubview:self.otherBtn];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).offset(30);
            
        }];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
        }];
        
        // 动态创建最好了
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(30);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.otherBtn.mas_left);
            make.width.mas_equalTo(self.otherBtn.mas_width);
        }];
        
        [self.otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(30);
            make.left.mas_equalTo(self.sureBtn.mas_right);
            make.right.mas_equalTo(self.mas_right);
            make.width.mas_equalTo(self.sureBtn.mas_width);
        }];
    }
    return self;
}
@end
