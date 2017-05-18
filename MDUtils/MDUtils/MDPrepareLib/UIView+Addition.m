//
//  UIView+Addition.m
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "UIView+Addition.h"
@interface UIView (PNCLibraryPrivate)
- (void)dumpView:(UIView *)aView atIndent:(int)indent into:(NSMutableString *)outstring;
@end
@implementation UIView (Addition)
#pragma mark - Property

- (CGFloat)left{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)screenX{
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    return x;
}

- (CGFloat)screenY{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

#pragma mark - Method

- (void)removeAllSubviews{
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (NSArray *)allSubviews:(UIView *)aView{
    NSArray *result = [aView subviews];
    for (UIView *eachView in [aView subviews]) {
        NSArray *riz = [self allSubviews:eachView];
        if (riz) {
            result = [result arrayByAddingObjectsFromArray:riz];
        }
    }
    return result;
}

- (NSArray *)viewPath{
    NSMutableArray *array = [NSMutableArray arrayWithObject:self];
    UIView *view = self;
    UIWindow *window = self.window;
    while (view != window)
    {
        view = [view superview];
        [array insertObject:view atIndex:0];
    }
    return array;
}

- (NSString *)displayViews:(UIView *)aView{
    NSMutableString *outString = [[NSMutableString alloc] init];
    [self dumpView:aView.window atIndent:0 into:outString];
    return outString;
}

#pragma mark - Private
- (void)dumpView:(UIView *)aView atIndent:(int)indent into:(NSMutableString *)outstring{
    for (int i = 0; i < indent; i++){
        [outstring appendString:@"--"];
    }
    [outstring appendFormat:@"[%2d] %@\n", indent, [[aView class] description]];
    for (UIView *view in [aView subviews]){
        [self dumpView:view atIndent:indent + 1 into:outstring];
    }
}

#pragma mark - 田飞 20140929
#pragma mark - 水平垂直布局方法
-(void)layoutOfHVisualFormat:(NSString *)HStr VVisualFormat:(NSString *)VStr withDic:(NSDictionary *)dic
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:HStr options:0 metrics:nil views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:VStr options:0 metrics:nil views:dic]];
}

@end
