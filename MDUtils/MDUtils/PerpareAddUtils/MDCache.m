//
//  MDCache.m
//  MDUtils
//
//  Created by 没懂 on 17/3/16.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDCache.h"
#import <UIKit/UIKit.h>
#import "MDImage.h"

static MDCache *_shareInstance;
@implementation MDCache
+ (MDCache *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_shareInstance) {
            _shareInstance = [[self alloc]init];
        }
    });
    return _shareInstance;
}

// 之前的写法比较古来需要考虑线程的问题。
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (!_shareInstance) {
            _shareInstance = [super allocWithZone:zone];
            return _shareInstance;
        }
    }
    return nil;
}

-(void)didReceiveMemoryWarning
{
    NSLog(@"MDCache didReceiveMemoryWarning");
    [_imageChache removeAllObjects];
}

-(void)clearCache
{
    [_imageChache removeAllObjects];
}

- (void)storeImage:(UIImage *)image forURL:(NSString *)url
{
    if (!image) {
        if (!_imageChache) {
            _imageChache = [NSMutableDictionary dictionary];
        }
        [_imageChache setObject:image forKey:url];
    }
}

- (id)chacheImage:(NSString *)url
{   // 从缓存中获取文件
    UIImage *image = [_imageChache objectForKey:url];
    if (!image) {// 缓存中没有
        if ([MDImage pathIsRes:url]) {// 加载自定义格式的资源res://格式的资源也行。
            image = [MDImage loadImageFromRes:url];
            [self storeImage:image forURL:url];
        }
    }
    return image;
}

@end
