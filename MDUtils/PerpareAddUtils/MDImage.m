//
//  MDImage.m
//  MDUtils
//
//  Created by 没懂 on 17/3/17.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDImage.h"
#define MDPathRes @"res://"
@implementation MDImage
+ (BOOL)pathIsRes:(NSString *)URL
{
    NSAssert(URL==nil, @"url is nil");
    return [URL hasPrefix:MDPathRes];
}

+ (NSString *)pathForRes:(NSString *)URL
{
    NSInteger index = MDPathRes.length;
    NSString *relativePath = [URL substringFromIndex:index];
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}
// mattt问题： 从自定义的包中获取文件，［[UIImage imageNamed:@"MBHUD_Error"];和这种方式获取文件有什么区别呢？ios是怎么对文件进行管理的？
+ (UIImage *)loadImageFromRes:(NSString *)URL
{
    NSString *path = [MDImage pathForRes:URL];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)imgResize:(UIImage *)image size:(CGSize)newSize
{   // 根据新的尺寸对图片重绘。
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width
                                 , newSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndPDFContext();
    return scaledImage;
}

+ (UIImage *)stretchImage:(UIImage *)img width:(NSInteger)width
{
    return [img stretchableImageWithLeftCapWidth:width topCapHeight:0];
}

+ (UIImage *)stretchImage:(UIImage *)img height:(NSInteger)height
{
    return [img stretchableImageWithLeftCapWidth:0 topCapHeight: height];
}
@end
