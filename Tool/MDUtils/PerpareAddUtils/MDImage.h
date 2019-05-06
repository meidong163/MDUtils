//
//  MDImage.h
//  MDUtils
//
//  Created by 没懂 on 17/3/17.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MDImage : NSObject
/**
 *  文件路径是否为资源文件(res://)路径
 *
 *  @param URL URL文件路径，可能包含res:// 格式
 *
 *  @return bool
 */
+ (BOOL)pathIsRes:(NSString *)URL;
/**
 *  获取相应格式完整的路径
 *
 *  @param URL 文件路径，可能包含res:// 等格式
 *
 *  @return 完整的路径 mattt问题 从bundle获取资源的详细信息，怎么弄的需要看。
 */
+ (NSString *)pathForRes:(NSString *)URL;
/**
 *  加载图片
 *
 *  @param URL 文件路径，可能包含res:// 等格式
 *
 *  @return UIImage 格式路径下的图片文件
 */
+ (UIImage *)loadImageFromRes:(NSString *)URL;
/**
 *  图片缩放
 *
 *  @param image   源图片
 *  @param newSize 缩放大小
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)imgResize:(UIImage *)image size:(CGSize)newSize;

// 图片拉伸
+ (UIImage *)stretchImage:(UIImage *)img height:(NSInteger)height;
+ (UIImage *)stretchImage:(UIImage *)img width:(NSInteger)width;

@end
