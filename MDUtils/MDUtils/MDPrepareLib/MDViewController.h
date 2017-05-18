//
//  MDViewController.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDViewController : UIViewController
{
    @private
    id _userinfo;
    BOOL _winShake;
}
/**
 *  自定义数据
 */
@property (nonatomic, strong)id userinfo;
/**
 *  监测是否有晃动
 */
@property (nonatomic, assign)BOOL winShake;
/**
 *  是否需要监听多语言通知
 */
@property (nonatomic, assign)BOOL needReceiveLanNotify;
/**
 *  多语言通知
 *
 *  @param notification 通知对象
 */
- (void)changeLanguages:(NSNotification *)notification;

@end
