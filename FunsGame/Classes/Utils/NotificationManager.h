//
//  NotificationManager.h
//  KinHop
//
//  Created by weibin on 14/12/12.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationManager : NSObject

/****************************************************************/

/// 发送用户信息有变化时的通知，以便于返回我的帐户视图时进行数据刷新
+ (void)postNotificationRefreshMyAccount;

/// 用户信息改变时，重新刷新数据
+ (void)receiveNotificationMyAccount:(id)delegate sel:(SEL)selector;

/// 移除通知用户信息刷新通知
+ (void)removeNotificationMyAccount:(id)object;

/****************************************************************/

/// 发送与惠信互转有变化时的通知，以便于返回我的帐户视图时进行数据刷新
+ (void)postNotificationRefreshHXAccount;

/// 与惠信互转改变时，重新刷新数据
+ (void)receiveNotificationHXAccount:(id)delegate sel:(SEL)selector;

/// 移除通知与惠信互转刷新通知
+ (void)removeNotificationHXAccount:(id)object;

/****************************************************************/

/// 发送返回前台时的通知，改变公告栏
+ (void)postNotificationShowNotice;

/// 接收返回前台时的通知，改变公告栏
+ (void)receiveNotificationShowNotice:(id)delegate sel:(SEL)selector;

/// 移除发送返回前台时的通知
+ (void)removeNotificationShowNotice:(id)object;

/****************************************************************/

/// 发送返回前台时的通知，刷新投资列表
+ (void)postNotificationRefreshInvestment;

/// 接收返回前台时的通知，刷新投资列表
+ (void)receiveNotificationRefreshInvestment:(id)delegate sel:(SEL)selector;

/// 移除发送返回前台时的刷新投资列表通知
+ (void)removeNotificationRefreshInvestment:(id)object;

/****************************************************************/

@end
