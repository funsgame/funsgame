//
//  DataManager.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "DataManager.h"
#import "UserModel.h"
#import "HttpsHeaderSetHepler.h"

@implementation DataManager

+ (DataManager *)sharedManager
{
    static DataManager *sharedManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[DataManager alloc] init];
        assert(sharedManager != nil);
    });
    
    return sharedManager;
}

/*
 - (void)setUserModel:(UserModel *)userModel
 {
 _userModel = userModel;
 #if 0
 if (userModel) {
 [[NSUserDefaults standardUserDefaults] setObject:userModel.imageUrl forKey:[NSString stringWithFormat:@"icon_%@",userModel.phone]];
 [[NSUserDefaults standardUserDefaults] synchronize];
 }
 #endif
 }
 */
/*
 - (NSString *)accountId
 {
 return NSIntegerToNSString(GetDataManager.userModel.accountId);
 }
 */

/*
 - (void)loginSucceedWithModel:(UserModel *)userModel;
 {
 // 测试数据
 userModel.accountId = @"1111";
 userModel.phone = @"18565601262";
 userModel.imageUrl = @"http://c.hiphotos.baidu.com/image/pic/item/b64543a98226cffcec858659bb014a90f703eaaa.jpg";
 userModel.goldCoins = 1000;
 userModel.level = 1;
 userModel.inviteFriendCount = 2;
 userModel.nickName = @"就疯狂的路上";
 userModel.sex = 1;
 userModel.recieverAddress = @"减肥克赖斯基疯狂螺丝钉疯狂了三大开发了速度加快立法世界卡德罗夫教科书里的福建克里斯蒂";
 
 // 1
 GetDataManager.userModel = userModel;
 GetDataManager.isLogin = YES;
 
 // 2 保存登录密码账号
 NSString *account = GetDataManager.account;
 NSString *pwd = GetDataManager.password;
 if ([SSKeychain setPassword:pwd forService:kSSToolkitTestsServiceName account:account]) {
 [[NSUserDefaults standardUserDefaults] setObject:account forKey:kSSToolkitTestsServiceName];
 [[NSUserDefaults standardUserDefaults] synchronize];
 }
 
 // 3 创建表 保存账号信息
 [[self class] createTableInLogin];
 
 // 4  存入数据库
 [self.userModel saveToDB];
 
 //    [UserModel isLatestUserModel:self.userModel];
 }
 */

//登录成功保存密码
- (void)loginSucceed
{
    //    UserModel *model = GetDataManager.userModel;
    //1.改变状态
    GetDataManager.isLogin = YES;
    
    //2. 保存登陆密码账号
    NSString *nickName = GetDataManager.nickName;
    NSString *pwd = GetDataManager.password;
    NSString *userId = GetDataManager.userModel.userId;
    GetDataManager.userId = userId;
    if ([SSKeychain setPassword:pwd forService:kSSToolkitTestsServiceName account:nickName]) {
        [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:kSSToolkitTestsServiceName];
        //        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 3.创建表 保存账号信息
    [[self class]createTableInLogin];
    
    // 4 存入数据库
    [self.userModel saveToDB];
    
    // 清理加密头信息
    [[HttpsHeaderSetHepler sharedInstance] clearHeaderEncryptInfo];
    // 登陆返回的公钥 XML解析生成 写入pem
//    [[RSAHelper sharedInstance] generatePemWithMoAndExXML:GetDataManager.userModel.publicKey];
    
    // 5 设置手势
//    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) gestureSetForLogin];
    
    // 6 发送登录成功通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil];
    
    // 下线重新登录时，发出通知刷新我的帐户信息，避免显示异常。 
//    [NotificationManager postNotificationRefreshMyAccount];
}
#if 0
- (void)gestureSet
{
    // 每次登录成功重新设置手势密码
    MicGesVC *vc = [[MicGesVC alloc] init];
    vc.gesScene = GesSceneSet;
    __block UIViewController *controller = vc;
    vc.onCompletion = ^(BOOL success){
        if (success) {
            [controller.view removeFromSuperview];
        }
    };
    
//    [[UIApplication sharedApplication].keyWindow addSubview:vc.view];
}
#endif

// 退出帐号
- (void)logOut
{
    // 1 清除相关信息
    GetDataManager.isLogin = NO;
    GetDataManager.userModel = nil;
    GetDataManager.userId = nil;
    GetDataManager.password = nil;
    
    // 2 删除密码
#if 1 // 退出登录不用这样删除密码，否则无法自动登录
    NSString *accout = [[NSUserDefaults standardUserDefaults] objectForKey:kSSToolkitTestsServiceName];
    [SSKeychain deletePasswordForService:kSSToolkitTestsServiceName account:accout];
#endif
    
    // 4 发送退出登录通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil];
    
    // 5 清除秒标投资密码
//    [UserDefaultManager deleteInvestmentPassword];
    
//    [ShareSDK cancelAuthWithType:ShareTypeQQ];
//    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
//    [ShareSDK cancelAuthWithType:ShareTypeWeixiSession];
//    [ShareSDK cancelAuthWithType:ShareTypeWeixiTimeline];
//    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
//    [ShareSDK cancelAuthWithType:ShareTypeTencentWeibo];
    //     end
    
}


+ (void)createTableInLogin
{
    //数据库建表
    //  账户
    [[UserModel getUsingLKDBHelper] createTableWithModelClass:[UserModel class]];
    
    /*
     //测试
     TestModel *test = [[TestModel alloc]init];
     test.userId = @"123";
     [[TestModel getUsingLKDBHelper] createTableWithModelClass:[TestModel class]];
     
     [test saveToDB];
     */
    
    
}

+ (void)createInvestListTable
{
    //投资清单表
    
}

@end
