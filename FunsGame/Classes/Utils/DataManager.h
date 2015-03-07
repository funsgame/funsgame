//
//  DataManager.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseModel.h"

@class UserModel;

@interface DataManager : BaseModel

@property (nonatomic, copy,) NSString *nickName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *mkip;//IP地址
@property (nonatomic, strong) UserModel *userModel;
@property (nonatomic, copy) NSString *loanId;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL isCheckAuth;
@property (nonatomic, assign) double balance; //余额
@property (nonatomic, assign) BOOL isRefreshNews;//是否刷新新闻

+ (DataManager *)sharedManager;

/// 登录成功保存相关信息
- (void)loginSucceed;

/// 退出登录
- (void)logOut;

+ (void)createInvestListTable;

@end
