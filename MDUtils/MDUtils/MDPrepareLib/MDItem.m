//
//  MDItem.m
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDItem.h"

@implementation MDItem
@synthesize tag = _tag;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tag = 0;
    }
    return self;
}
@end
