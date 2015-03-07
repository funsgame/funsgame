//
//  CountDownButton.m
//  KinHop
//
//  Created by weibin on 14/12/18.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "CountDownButton.h"

#define kDefaultTime 60
#define kDefaultNoramlTitle @"验证"

@interface CountDownButton()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

@end

@implementation CountDownButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.titleLabel.font = kFontSize13;
    
    [self setTitleColor:kJHSColorBlack forState:UIControlStateNormal];
    [self setTitleColor:UIColorHex(@"#bababa") forState:UIControlStateDisabled];
    [self setTitle:kDefaultNoramlTitle forState:UIControlStateNormal];
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self setBackgroundColor:kJHSColorDarkWhite];
//    [self setBackgroundImage:[[UIImage imageWithName:verificationcode_image]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
//    [self setBackgroundImage:[[UIImage imageWithName:verificationcode_image_s]resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateDisabled];
    
    self.layer.borderWidth = 0;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = kColorBlack.CGColor;
    self.clipsToBounds = YES;
    
    self.time = kDefaultTime;
}

- (void)setNormalTitle:(NSString *)normalTitle
{
    _normalTitle = normalTitle;
    [self setTitle:_normalTitle forState:UIControlStateNormal];
}

- (void)setTime:(NSInteger)time
{
    if (time > 0) {
        _time = time;
    }
}

- (void)buttonClick:(id)button
{
    if (_buttonClickedBlock) {
        _buttonClickedBlock();
    }
}

- (void)start
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if ([_activity isAnimating]) {
        [_activity stopAnimating];
        [self setTitle:_normalTitle ? _normalTitle : kDefaultNoramlTitle forState:UIControlStateNormal];
    }
    _time = kDefaultTime;
    [self setTitle:[NSString stringWithFormat:@"%ld秒", (long)_time] forState:UIControlStateDisabled];
    
    kSelfWeak;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        assert(weakSelf != nil);
        weakSelf.enabled = NO;
        weakSelf.timer =[NSTimer scheduledTimerWithTimeInterval:1.0
                                                         target:weakSelf
                                                       selector:@selector(timeAction:)
                                                       userInfo:nil
                                                        repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    });
}

- (void)timeAction:(NSTimer *)timer
{
    --_time ;
    
    [self setTitle:[NSString stringWithFormat:@"%ld秒", (long)_time] forState:UIControlStateDisabled];
    
    if (_time == 0) {
        [self stop];
    }
}

- (void)stop
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    self.enabled = YES;
    
    if ([_activity isAnimating]) {
        [_activity stopAnimating];
        
        [self setTitle:_normalTitle ? _normalTitle : kDefaultNoramlTitle forState:UIControlStateNormal];
    }
}

- (void)showActivity
{
    CGFloat h = 15;
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((self.width - h)/ 2, (self.height - h)/2, h, h)];
        _activity.color = [UIColor grayColor];
        [self addSubview:_activity];
    }
    [self setTitle:nil forState:UIControlStateNormal];
    [self setTitle:nil forState:UIControlStateDisabled];
    self.enabled = NO;
    [_activity startAnimating];
}

@end
