//
//  MDGlobalDefine.h
//  MSHULib
//
//  Created by 舒江波 on 2019/4/28.
//  Copyright © 2019 com.pactera. All rights reserved.
//

#ifndef MDGlobalDefine_h
#define MDGlobalDefine_h

#define Screen_W [[UIScreen mainScreen]bounds].size.width
#define Screen_H [[UIScreen mainScreen]bounds].size.height

#define WindowCenter [UIApplication sharedApplication].keyWindow.center

# define NSDebugLog(format, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

#endif /* MDGlobalDefine_h */
