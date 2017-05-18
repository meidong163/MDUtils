//
//  MDObject.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDObject : NSObject
{
    @private
    id _userinfo;
}
@property (nonatomic, strong)id userinfo;
/**
 *  实例属性字典
 *
 *  @return 属性及属性值的数据字典
 */
- (NSDictionary *)toDict;
@end

@interface MDObject (Property)
- (void)okkk;
@end
