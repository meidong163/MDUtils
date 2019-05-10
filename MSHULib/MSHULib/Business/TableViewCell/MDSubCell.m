//
//  MDSubCell.m
//  MSHULib
//
//  Created by 舒江波 on 2019/5/10.
//  Copyright © 2019 com.pactera. All rights reserved.
//
//
/*
 * cell继承问题
 * 1. 能访问view
 * 2. 能设置数据
 */

#import "MDSubCell.h"
#import "MDTextField.h"
#import "Masonry.h"

@interface MDSubCell()
@property(nonatomic,strong)MDTextField *textField;

@end

@implementation MDSubCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {// 移除父类的textFiled
        UITextField *supersTextField = [self valueForKey:@"_textFeild"];// 若设计为公有属性，就可以直接访问到父类的变量，子类重写父类变量。
        if (supersTextField) {
            [supersTextField removeFromSuperview];
        }
        // 子类新添加
        self.textField = [[MDTextField alloc]init];
//        self.textField.backgroundColor = [UIColor grayColor];
        self.textField.borderStyle = UITextBorderStyleBezel;
        [self addSubview:self.textField];
        // 重新布局 其他的也一并重新布局
        
        UILabel *nameLabel = [self valueForKey:@"_nameLabel"];
        UIImageView *imageView = [self valueForKey:@"_imageView"];
        
        [nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(15);
        }];
        
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.right.mas_equalTo(self.mas_right).offset(-15);
            make.left.mas_equalTo(self.mas_left).offset(130);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

@end
