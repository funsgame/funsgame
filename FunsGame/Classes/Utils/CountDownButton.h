//
//  CountDownButton.h
//  KinHop
//
//  Created by weibin on 14/12/18.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownButton : UIButton

@property (nonatomic, copy) NSString *normalTitle;  // default is @“验证”
@property (nonatomic, assign) NSInteger time;       // 倒计时时间 default is 60s

@property (nonatomic, copy) void (^buttonClickedBlock)(void);  //点击按钮回调

// 倒计时一般过程 showActivity(网络请求)->start(请求完成)->stop(停止计时)
- (void)start;
- (void)stop;
- (void)showActivity;


/************** 用法 *************************
 
 // 获取短信验证码
 - (void)getValidateCode
 {
 _reSentButton.time = 10;
 
 // 1 网络请求将要开始，设置网络请求状态
 [_reSentButton showActivity];
 
 // 2 请求网络
 //模拟网络请求 3秒
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 #if 1
 // 2.1 请求成功
 [_reSentButton start];
 #else
 // 2.2 请求失败
 [_reSentButton stop];
 #endif
 });
 }
 **************************************/

@end
