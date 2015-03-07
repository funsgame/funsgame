//
//  CLTimerLabel.h
//  kinhop
//
//  Created by weibin on 14/12/31.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

/*
 参考代码
 ===================================================================================
 CLTimerLabel *timerLb = [[CLTimerLabel alloc] initWithFrame:CGRectMake(50, 100, 200, 20)];
 
 timerLb.textColor = [UIColor redColor];
 //设置截止时间
 [timerLb setCutOffTime:[NSDate dateWithTimeInterval:600 sinceDate:[NSDate date]]];
 //设置服务器时间
 [timerLb setServerTime:  ];
 //开始倒计时
 [timerLb start];
 timerLb.countFinishedBlock = ^{
 NSLog(@"计时完成");
 };
 
 
 注意:在合适的地方释放定时器,使用方法 - (void)releaseTimer;
 ===================================================================================
 */

typedef void(^timerCountFinished) (void);

#import <UIKit/UIKit.h>

@interface CLTimerLabel : UILabel
{
    NSTimer *_timer;
    NSDate *_cutOffTime;      //截止时间
    NSDate *_serverTime;      //服务器时间
    NSDate *_temporaryTime;   //计算时间的时候的临时时间
}
@property (nonatomic, strong) NSTimer *timer;

//设置截止日期
@property (nonatomic, strong) NSDate *cutOffTime;

//设置服务器时间
@property (nonatomic, strong) NSDate *serverTime;

//倒计时结束后执行block, 可以不设置
@property (nonatomic, copy) timerCountFinished countFinishedBlock;

//开始倒计时
- (void)start;

//释放定时器
- (void)releaseTimer;

@end
