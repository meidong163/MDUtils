//
//  MDAlertController.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/28.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MDAlertActionStyle) {
    MDAlertActionStyleDefault = 0,
    MDAlertActionStyleCancel,
    MDAlertActionStyleDestructive
} NS_ENUM_AVAILABLE_IOS(8_0);

typedef NS_ENUM(NSInteger, MDAlertControllerStyle) {
    MDAlertControllerStyleActionSheet = 0,
    MDAlertControllerStyleAlert
} NS_ENUM_AVAILABLE_IOS(8_0);

NS_CLASS_AVAILABLE_IOS(8_0) @interface MDAlertAction : NSObject <NSCopying>

+ (instancetype _Nullable )actionWithTitle:(nullable NSString *)title style:(MDAlertActionStyle)style handler:(void (^ __nullable)(MDAlertAction * _Nullable action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) MDAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;


@end

NS_ASSUME_NONNULL_BEGIN

NS_CLASS_AVAILABLE_IOS(8_0) @interface MDAlertController : UIViewController
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(MDAlertControllerStyle)preferredStyle;

- (void)addAction:(MDAlertAction *)action;
@property (nonatomic, readonly) NSArray<MDAlertAction *> *actions;

@property (nonatomic, strong, nullable) MDAlertAction *preferredAction NS_AVAILABLE_IOS(9_0);

- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;
@property (nullable, nonatomic, readonly) NSArray<UITextField *> *textFields;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *message;

@property (nonatomic, readonly) MDAlertControllerStyle preferredStyle;
@end

NS_ASSUME_NONNULL_END
