//
//  CountdownManager.h
//  FDSDemo
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能描述：倒计时功能

#import <Foundation/Foundation.h>

/// 显示模式
typedef enum
{
    /// *天 00:00:00 显示四位，天时分秒
    ModeDayHourMinSec,
    /// 00:00:00 显示三位，时分秒
    ModeHourMinSec,
    /// 00:00 显示两位，分秒
    ModeMinSec,
    /// 0 只显示一位，秒
    ModeSec
}ShowMode;

@interface CountdownManager : NSObject

/// 倒计时开始
- (void)startCountDown:(NSInteger)second
              showMode:(ShowMode)showMode
                runing:(void (^)(NSString *time))countDownBlockString
                runing:(void (^)(NSInteger time))countDownBlockInt
                finish:(void (^)(void))finishBlock;

/// 倒计时停止
- (void)clearCountDown;

/// 倒计时
@property (nonatomic, readonly) NSTimer *timer;

/// 倒计时显示字符样式
- (NSString *)setTimeString:(NSInteger)timeNum type:(ShowMode)mode;

@end
