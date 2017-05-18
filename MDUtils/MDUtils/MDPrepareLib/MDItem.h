//
//  MDItem.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDObject.h"

@interface MDItem : MDObject
{
    @private
    NSInteger _tag;
}

@property (nonatomic, assign)NSInteger tag;

@end
