//
//  MDWindow.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const MDNotificationDeviceShake;

@interface MDWindow : UIWindow
{
@private BOOL _winShake;
}
/**
 *  是否检测到窗口的晃动，默认YES
 */
@property (nonatomic, assign)BOOL winShake;

@end
