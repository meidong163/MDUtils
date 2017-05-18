//
//  NSObject+Property.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)
/**
 *  获取当前类的属性列表，那个对象调用此方法获取那个对象的属性列表
 *
 *  @return 当前类的属性
 */
- (NSArray *)getPropertyList;
/**
 *  获取clazz的属性列表
 *
 *  @param clazz 类名
 *
 *  @return clazz的所有属性
 */
- (NSArray *)getPropertyList: (Class)clazz;
/**
 *  对象存到数据库，准备sql。 ＊＊＊没有处理属性中有数组的情况＊＊＊
 *
 *  @param tablename sql表名
 *
 *  @return sql
 */
- (NSString *)tableSql:(NSString *)tablename;
/**
 *  对象存到数据库，准备sql,表名当做类名 ＊＊＊没有处理属性中有数组的情况＊＊＊
 *
 *  @return sql
 */
- (NSString *)tableSql;
/**
 *  对象转字典，对象中字典，数组，处理不了。
 *
 *  @return 对象字典。属性名为key，属性值为value
 */
- (NSDictionary *)object2Dictionary;
/**
 *  使用字典创建对象，使用了递归，需要测试
 *
 *  @param dict 创建对象的字典
 *
 *  @return 创建的对象
 */
- (id)initWithDictionary:(NSDictionary *)dict;
/**
 *  获取类名
 *
 *  @return 类名
 */
- (NSString *)className;
@end
