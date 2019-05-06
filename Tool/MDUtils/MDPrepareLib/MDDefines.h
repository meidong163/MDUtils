//
//  MDdefines.h
//  MDUtils
//
//  Created by 没懂 on 17/3/20.
//  Copyright © 2017年 com.infomacro. All rights reserved.
//

#ifndef MDdefines_h
#define MDdefines_h

#define MDChangeLanguageNotification @"MDChangeLanguage"
/**
 *  矩形框
 */
#define MDFrameAll(x,y,w,h) CGRectMake((x),(y),(w),(h))
/**
 *  坐标为（0,0）的矩形框
 */
#define MDFrame(w,h) MDFrameAll(0,0,w,h)
/**
 *  完整填充矩形框
 */
#define MDFrameAllInset(frame) MDFrame(frame.size.width,frame.size.height)
/**
 *  以inset填充矩形框
 */
#define MDFrameInset(frame,inset) CGRectMake(inset.left, inset.top, frame.size.width - inset.left - inset.right, frame.size.height - inset.top -inset.bottom)

// log
#ifdef DEBUG
#define MDLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define MDLog(FORMAT, ...) nil
#endif

#endif /* MDdefines_h */
