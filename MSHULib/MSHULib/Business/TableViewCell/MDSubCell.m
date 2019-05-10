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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {// 移除父类的textFiled，一定要移除掉父类的 TextField，只是子类赋值给父类对象，不会去重新渲染
        UITextField *supersTextField = [self valueForKey:@"_textFeild"];// 若设计为公有属性，就可以直接访问到父类的属性，子类重写父类属性。但需要手动@synthesize 不然访问默认父类对象
        if (supersTextField) {
            [supersTextField removeFromSuperview];
        }
        // 子类新添加 MDTextField 为带有按钮的Textfield
        self.textField = [[MDTextField alloc]init];
        self.textField.borderStyle = UITextBorderStyleBezel;
        [self addSubview:self.textField];
        
        // 重新布局 其他的也可一并重新布局
        UILabel *nameLabel = [self valueForKey:@"_nameLabel"];
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
