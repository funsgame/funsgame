//
//  CountdownManager.m
//  FDSDemo
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "CountdownManager.h"

@interface CountdownManager ()
{
    NSInteger countDownNum;
    NSString *countDownString;
}

@property (nonatomic, assign) ShowMode showmode;
@property (nonatomic, copy) void (^runBlocklocal)(NSString *time);
@property (nonatomic, copy) void (^runBlocklocalInt)(NSInteger time);
@property (nonatomic, copy) void (^finishBlocklocal)(void);

@end

@implementation CountdownManager

@synthesize showmode;
@synthesize runBlocklocal;
@synthesize runBlocklocalInt;
@synthesize finishBlocklocal;

// 倒计时开始
- (void)startCountDown:(NSInteger)second
              showMode:(ShowMode)showMode
                runing:(void (^)(NSString *time))countDownBlockString
                runing:(void (^)(NSInteger time))countDownBlockInt
                finish:(void (^)(void))finishBlock;
{
    countDownNum = second;
    [self startcountDown];
    self.showmode = showMode;
    self.runBlocklocal = [countDownBlockString copy];
    self.runBlocklocalInt = [countDownBlockInt copy];
    self.finishBlocklocal = [finishBlock copy];
}

- (void)startcountDown
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)timeAction:(NSTimer *)timer
{
    --countDownNum;
    if (self.runBlocklocalInt)
    {
        self.runBlocklocalInt(countDownNum);
    }
    
    countDownString = [self setTimeString:countDownNum];
    
    if (self.runBlocklocal)
    {
        self.runBlocklocal(countDownString);
    }
    
    if (countDownNum < 0)
    {
        if (self.finishBlocklocal)
        {
            self.finishBlocklocal();
        }
        
        [self stopCountDown:timer];
    }
}

- (void)stopCountDown:(NSTimer *)timer
{
    if (timer)
    {
        [timer invalidate];
        countDownNum = 0;
        timer = nil;
    }
}

/// 倒计时显示字符样式
- (NSString *)setTimeString:(NSInteger)timeNum type:(ShowMode)mode
{
    self.showmode = mode;
    
    NSString *time = [self setTimeString:timeNum];
    
    return time;
}

// 倒计时显示字符
- (NSString *)setTimeString:(NSInteger)timeNum
{
    NSString *timeString = nil;
    if (ModeDayHourMinSec == self.showmode)
    {
        NSInteger dayNum = timeNum / (24 * 60 * 60);                 // 天
        NSInteger hourNum = timeNum % (24 * 60 * 60) / 3600;         // 时
        NSInteger minuteNum = timeNum % (24 * 60 * 60) % 3600 / 60;  // 分
        NSInteger sectionNum = timeNum % (24 * 60 * 60) % 3600 % 60; // 钞
        
        NSString *dayFormat = @"%d天";                               // 显示样式，天
        NSString *hourFormat = (hourNum >= 10 ? @"%d" : @"0%d");     // 显示样式，时
        NSString *minFormat = (minuteNum >= 10 ? @"%d" : @"0%d");    // 显示样式，分
        NSString *secFormat = (sectionNum >= 10 ? @"%d" : @"0%d");   // 显示样式，秒
        NSString *formatString = [NSString stringWithFormat:@"%@ %@:%@:%@", dayFormat, hourFormat, minFormat, secFormat]; // 显示样式
        timeString = [NSString stringWithFormat:formatString, dayNum, hourNum, minuteNum, sectionNum];
    }
    else if (ModeHourMinSec == self.showmode)
    {
        NSInteger hourNum = timeNum / 3600;         // 时
        NSInteger minuteNum = timeNum % 3600 / 60;  // 分
        NSInteger sectionNum = timeNum % 3600 % 60; // 钞
        
        NSString *hourFormat = (hourNum >= 10 ? @"%d" : @"0%d");     // 显示样式，时
        NSString *minFormat = (minuteNum >= 10 ? @"%d" : @"0%d");    // 显示样式，分
        NSString *secFormat = (sectionNum >= 10 ? @"%d" : @"0%d");   // 显示样式，秒
        NSString *formatString = [NSString stringWithFormat:@"%@:%@:%@", hourFormat, minFormat, secFormat]; // 显示样式
        timeString = [NSString stringWithFormat:formatString, hourNum, minuteNum, sectionNum];
    }
    else if (ModeMinSec == self.showmode)
    {
        NSInteger minuteNum = timeNum / 60;  // 分
        NSInteger sectionNum = timeNum % 60; // 钞
        
        NSString *minFormat = (minuteNum >= 10 ? @"%d" : @"0%d");  // 显示样式，分
        NSString *secFormat = (sectionNum >= 10 ? @"%d" : @"0%d"); // 显示样式，秒
        NSString *formatString = [NSString stringWithFormat:@"%@:%@", minFormat, secFormat]; // 显示样式
        timeString = [NSString stringWithFormat:formatString, minuteNum, sectionNum];
    }
    else if (ModeSec == self.showmode)
    {
        NSInteger sectionNum = timeNum % 60; // 钞
        
        NSString *secFormat = (sectionNum >= 10 ? @"%d" : @"0%d"); // 显示样式，秒
        NSString *formatString = [NSString stringWithFormat:@"%@", secFormat]; // 显示样式
        timeString = [NSString stringWithFormat:formatString, sectionNum];
    }
    
    return timeString;
}

/// 倒计时停止
- (void)clearCountDown
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
