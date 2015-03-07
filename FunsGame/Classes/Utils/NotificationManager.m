//
//  NotificationManager.m
//  KinHop
//
//  Created by weibin on 14/12/12.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "NotificationManager.h"

// 常量定义
#define Notification [NSNotificationCenter defaultCenter]

static NSString *const changeMyAccount = @"changeMyAccount";           // 我的帐户
static NSString *const changeHXAccount = @"changeHXAccount";           // 与惠信互转
static NSString *const changeStatus = @"changeStatus";                 // 后台进入前台
static NSString *const changeRefreshInvestment = @"RefreshInvestment"; // 后台进入前台

@implementation NotificationManager

/****************************************************************/

// 发送用户信息有变化时的通知，以便于返回我的帐户视图时进行数据刷新
+ (void)postNotificationRefreshMyAccount
{
    [Notification postNotificationName:changeMyAccount object:nil];
}

// 用户信息改变时，重新刷新数据
+ (void)receiveNotificationMyAccount:(id)delegate sel:(SEL)selector
{
    [self removeNotificationMyAccount:delegate];
    [Notification addObserver:delegate selector:selector name:changeMyAccount object:nil];
}

// 移除通知用户信息刷新通知
+ (void)removeNotificationMyAccount:(id)object
{
    [Notification removeObserver:object name:changeMyAccount object:nil];
}

/****************************************************************/

// 发送与惠信互转有变化时的通知，以便于返回我的帐户视图时进行数据刷新
+ (void)postNotificationRefreshHXAccount
{
    [Notification postNotificationName:changeHXAccount object:nil];
}

// 与惠信互转改变时，重新刷新数据
+ (void)receiveNotificationHXAccount:(id)delegate sel:(SEL)selector
{
    [self removeNotificationHXAccount:delegate];
    [Notification addObserver:delegate selector:selector name:changeHXAccount object:nil];
}

// 移除通知与惠信互转刷新通知
+ (void)removeNotificationHXAccount:(id)object
{
    [Notification removeObserver:object name:changeHXAccount object:nil];
}

/****************************************************************/

// 发送返回前台时的通知，改变公告栏
+ (void)postNotificationShowNotice
{
    [Notification postNotificationName:changeStatus object:nil];
}

// 接收返回前台时的通知，改变公告栏
+ (void)receiveNotificationShowNotice:(id)delegate sel:(SEL)selector
{
    [self removeNotificationShowNotice:delegate];
    [Notification addObserver:delegate selector:selector name:changeStatus object:nil];
}

// 移除发送返回前台时的通知
+ (void)removeNotificationShowNotice:(id)object
{
    [Notification removeObserver:object name:changeStatus object:nil];
}

/****************************************************************/

// 发送返回前台时的通知，刷新投资列表
+ (void)postNotificationRefreshInvestment
{
    [Notification postNotificationName:changeRefreshInvestment object:nil];
}

// 接收返回前台时的通知，刷新投资列表
+ (void)receiveNotificationRefreshInvestment:(id)delegate sel:(SEL)selector
{
    [self removeNotificationRefreshInvestment:delegate];
    [Notification addObserver:delegate selector:selector name:changeRefreshInvestment object:nil];
}

// 移除发送返回前台时的刷新投资列表通知
+ (void)removeNotificationRefreshInvestment:(id)object
{
    [Notification removeObserver:object name:changeRefreshInvestment object:nil];
}

/****************************************************************/
@end
