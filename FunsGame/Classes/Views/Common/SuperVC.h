//
//  SuperVC.h
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKNetworkOperation;

@interface SuperVC : UIViewController

@property (nonatomic, strong) NSMutableArray *networkOperations;

/// 设置登录视图的视图来源属性（判断是否从忘记手势密码重新登录进入）
@property (nonatomic, assign) BOOL isGexUnlockView;

/// 设置导航栏样式
+ (void)setNavigationStyle:(UINavigationController*)nav;

/// 设置导航栏左按钮;
- (UIBarButtonItem *)barBackButton;

/// present形式控制器的返回按钮
- (UIBarButtonItem *)barBackButtonForPrensentedVC;

/// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action;

/// 返回上层视图方法
- (void)backToSuperView;

#pragma mark - 网络

- (void)refreshClick;

/// 开始加载
-(void)loadingDataStart;

/// 加载成功
-(void)loadingDataSuccess;

/// 加载失败
-(void)loadingDataFail;

/// 没有内容
-(void)loadingDataBlank;

/// 添加网络操作，便于释放
- (void)addNet:(MKNetworkOperation *)net;

/// 释放网络
- (void)releaseNet;

/// 判断登录
- (void)loginVerifySuccess:(void (^)())success;

//创建键盘通知并添加手势（功能：点击空白处键盘收回）
- (void)textFieldReturn;

//销毁键盘弹出通知
- (void)deallocTextFieldNSNotification;

@end
