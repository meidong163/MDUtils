//
//  Pepole.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
@interface Pepole : MDObject

@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)NSInteger age;
@property (nonatomic, strong)Book *book;

@end
