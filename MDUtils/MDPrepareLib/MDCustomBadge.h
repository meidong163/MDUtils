//
//  MDCustomBadge.h
//  MDUtils
//
//  Created by 没懂 on 17/3/21.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import "MDView.h"


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface MDCustomBadge : MDView {

    NSString *badgeText;
    UIColor *badgeTextColor;
    UIColor *badgeInsetColor;
    UIColor *badgeFrameColor;
    BOOL badgeFrame;
    BOOL badgeShining;
    CGFloat badgeCornerRoundness;
    CGFloat badgeScaleFactor;
}

@property(nonatomic,strong) NSString *badgeText;
@property(nonatomic,strong) UIColor *badgeTextColor;
@property(nonatomic,strong) UIColor *badgeInsetColor;
@property(nonatomic,strong) UIColor *badgeFrameColor;

@property(nonatomic,readwrite) BOOL badgeFrame;
@property(nonatomic,readwrite) BOOL badgeShining;

@property(nonatomic,readwrite) CGFloat badgeCornerRoundness;
@property(nonatomic,readwrite) CGFloat badgeScaleFactor;

+ (MDCustomBadge*) customBadgeWithString:(NSString *)badgeString;
+ (MDCustomBadge*) customBadgeWithString:(NSString *)badgeString withStringColor:(UIColor*)stringColor withInsetColor:(UIColor*)insetColor withBadgeFrame:(BOOL)badgeFrameYesNo withBadgeFrameColor:(UIColor*)frameColor withScale:(CGFloat)scale withShining:(BOOL)shining;
- (void) autoBadgeSizeWithString:(NSString *)badgeString;
-(void)setNewBadgeText:(NSString *)_badgeText;
@end
