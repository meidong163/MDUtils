//
//  MDTextField.m
//  MSHULib
//
//  Created by 舒江波 on 2019/5/8.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import "MDTextField.h"
#import "Masonry.h"
@interface MDTextField ()
@property(nonatomic,strong)UIButton *rightButton;
@end

@implementation MDTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        _rightButton = [[UIButton alloc]init];
        [_rightButton setImage:[UIImage imageNamed:@"openPhoto"] forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
//        _imageview.image = [UIImage imageNamed:@"openPhoto"];
//        _imageview.contentMode = UIViewContentModeScaleAspectFit;
//        [self.rightView addSubview:_imageview];
        self.rightView = _rightButton;
        self.rightViewMode = UITextFieldViewModeAlways;
        
//        [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.mas_top).offset(5);
//            make.right.mas_equalTo(self.mas_right).offset(-5);
//            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
//            make.width.equalTo(@(40));
//        }];//  这里不能使用 Masonry
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _rightButton.frame = CGRectMake(self.frame.size.width - 50, 5, 40, 40);

}

- (void)clickRight
{
    [self resignFirstResponder];
    NSLog(@"jjj");
}
@end
