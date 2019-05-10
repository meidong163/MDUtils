//
//  MDTableViewCell.m
//  MSHULib
//
//  Created by 舒江波 on 2019/5/8.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDTableViewCell.h"
//#import "MDTextField.h"
#import "Masonry.h"

@interface MDTableViewCell()
{
    UITextField *_textFeild;
    UILabel *_nameLabel;
    UIImageView *_imageView;
}
@end

@implementation MDTableViewCell

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
    if (self) {
        UITextField *textFeild = [[UITextField alloc]init];
        textFeild.backgroundColor = [UIColor grayColor];
        _textFeild = textFeild;
        [self addSubview:textFeild];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        _nameLabel = nameLabel;
        [self addSubview: nameLabel];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"avatar_white_load_view_bg"]];
        _imageView = imageView;
        [self addSubview:imageView];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left).offset(15);
            make.bottom.mas_equalTo(self.mas_bottom);
            make.width.mas_equalTo(@(40));
        }];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLabel.mas_top).offset(5);
            make.bottom.mas_equalTo(nameLabel.mas_bottom).offset(-5);
            make.left.mas_equalTo(nameLabel.mas_right).offset(10);
            make.width.equalTo(@(40));
        }];
        
        [textFeild mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.right.mas_equalTo(self.mas_right).offset(-30);
            make.left.mas_equalTo(imageView.mas_right).offset(30);
            make.bottom.mas_equalTo(self.mas_bottom);
        }];
        
    }
    return self;
}

- (void)setCellModel:(MDModel *)cellModel
{
    _cellModel = cellModel;
    _textFeild.placeholder = _cellModel.pleaceHolder;
    _nameLabel.text = _cellModel.name;
}

@end
