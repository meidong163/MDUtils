//
//  MDCache.h
//  MDUtils
//
//  Created by 没懂 on 17/3/16.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <Foundation/Foundation.h>
//mattt 模仿pclibary
// 设计一个清理缓存的方法。
@interface MDCache : NSObject
{
    NSMutableDictionary *_imageChache;// 缓存在内存中，被单利类持有，不会被释方
}

+ (MDCache *)shareInstance;
/**
 *  从缓存中获取文件，如果缓存文件不存在，则获取响应格式目录下文件并添加到缓存
 *  res:// 资源文件路径
 *
 *  @param url 文件路径，可以是res:// 格式
 *
 *  @return UIImage,NSData等文件。
 */
- (id)chacheImage:(NSString *)url;
/**
 *  清除缓存
 */
- (void)clearCache;
@end
