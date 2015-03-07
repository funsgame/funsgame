//
//  CLTimerLabel.m
//  kinhop
//
//  Created by weibin on 14/12/31.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "CLTimerLabel.h"

@implementation CLTimerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)releaseTimer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)setCutOffTime:(NSDate *)cutOffTime{
    
    _cutOffTime = cutOffTime;
    [self updateLabel:nil];
}

-(void)setServerTime:(NSDate *)serverTime{
    _serverTime = serverTime;
    _temporaryTime = serverTime;
    [self updateLabel:nil];
}

- (void)start
{
    if (!_timer) {
        //    DLog(@"=========================异步创建定时器");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(updateLabel:)
                                                    userInfo:nil
                                                     repeats:YES] ;
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        });
    }
    
}

- (void)updateLabel:(NSTimer *)timer{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //此处暂时做调试用
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:2014];
    [components setMonth:10];
    [components setDay:9];
    [components setHour:16];
    [components setMinute:34];
    [components setSecond:0];
    //end
    
    NSDate *fireDate = _cutOffTime;//目标时间
    
    //当前时间
    _temporaryTime = _temporaryTime ? _temporaryTime : [NSDate date];
    
    //    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    unsigned int unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [calendar components:unitFlags fromDate:_temporaryTime toDate:fireDate options:0];//计算时间差
    //  DLog(@"=================================timer");
    
    self.text = [NSString stringWithFormat:@"%ld天%ld小时%ld分%ld秒",(long)[d day], (long)[d hour], (long)[d minute], (long)[d second]];//倒计时显示
    
    _temporaryTime = [_temporaryTime dateByAddingTimeInterval:1.0f];
    
    
    //检查如果，当前倒计时label被父视图remove掉，则释放timer
    if (!self.superview) {
        [timer invalidate];
        timer = nil;
    }
    
    if (![d day] && ![d hour] && ![d minute] && ![d second]) {
        [timer invalidate];
        //结束后执行block
        if (self.countFinishedBlock) {
            self.countFinishedBlock();
        }
    }
}

//- (void)dealloc
//{
//    _timer = nil;
//    DLog(@"cell timer %@", _timer);
//}


@end
