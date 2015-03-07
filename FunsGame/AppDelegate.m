//
//  AppDelegate.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"

//#import "WeiboApi.h"
//#import "WeiboSDK.h"

//#import "MobClick.h"                                                        // 友盟

//#define UMENG_APPKEY @"54767d55fd98c568d30011a8"                            // 友盟appKey

#define kShareSdkAppKey           @"2d776c440e60"
#define ShareRedirectUrl          @""
#define kSinaWeiboAppKey          @"3170430602"
#define kSinaWeiboAppSecret       @"81a5d977b56fe58dcbb13bce789dc024"
#define kSinaWeiBoreDirectUri     @"https://api.weibo.com/oauth2/default.html"
#define kQQAppId                  @"1104312170"
#define kQQAppkey                 @"M8upIyyGqTlo6ITW"
#define kWXAppID                  @"wx28764f96f4cab766"
#define kWXAppSecret              @"91c365d074efd76fd22e8b43a9ad3692"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 配置友盟
//    [self initMobClick];
    
    // 初始化分享
    [self initShare];
    
    // 检测版本是否需要强制升级
    //    [self checkVersion];
    
    // 信息加载，及自动登录
    //    [self startLoadData];
    //自动登录
    [self autoLogin];
    
    [self loadData];
    
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)initShare
{
    [ShareSDK registerApp:kShareSdkAppKey];
    
    [ShareSDK connectSinaWeiboWithAppKey:kSinaWeiboAppKey
                               appSecret:kSinaWeiboAppSecret
                             redirectUri:kSinaWeiBoreDirectUri];
    
    [ShareSDK connectQZoneWithAppKey:kQQAppId
                           appSecret:kQQAppkey
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885" wechatCls:[WXApi class]];
    
    [WXApi registerApp:kWXAppID];
}

- (void)autoLogin
{
    UserType type = [UserHelper autoLoginStatus];
    ShareType shareType = 0;
    if (type == UserTypeQQ) {
        shareType = ShareTypeQQSpace;
    }else if(type == UserTypeSina) {
        shareType = ShareTypeSinaWeibo;
    }
    if (type == UserTypeNormal) {
//        NSString *mobile = [UserHelper autoLoginUser];
//        NSString *password = [UserHelper getPasswordWithMobile:mobile];
//        //登录操作
//        [UserModel loginWithAccount:mobile
//                       withPassword:password
//                           withType:UserTypeMobile
//                            success:^(StatusModel *data) {
//                                if (data.flag == 1) {
//                                    [[DataManager sharedManager] loginSucceed];
//                                }else{
//                                    [[DataManager sharedManager] logOut];
//                                }
//                            }];
    }else if(shareType != 0){
        if ([ShareSDK hasAuthorizedWithType:shareType]) {
            [ShareSDK getUserInfoWithType:shareType
                              authOptions:nil
                                   result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
                                       if (result) {
                                           [self authSucceed:userInfo];
                                       }else{
                                       }
                                   }];
        }
    }
}

- (void)authSucceed:(id<ISSPlatformUser>)userInfo
{
    UserType userType = [userInfo type] == ShareTypeSinaWeibo?UserTypeSina:UserTypeQQ;
//    [UserModel loginWithAccount:[userInfo uid]
//                   withPassword:nil
//                       withType:userType
//                        success:^(StatusModel *data) {
//                            [SVProgressHUD dismiss];
//                            if (data.flag == 1) {
//                                [[DataManager sharedManager] loginSucceed];
//                            }
//                        }];
}

//#pragma mark - 配置友盟
//- (void)initMobClick
//{
//    //配置友盟
//    [MobClick setAppVersion:currentVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
//    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
//    [MobClick updateOnlineConfig];  //在线参数配置
//    
//    /* 添加测试设备
//     
//     Class cls = NSClassFromString(@"UMANUtil");
//     SEL deviceIDSelector = @selector(openUDIDString);
//     NSString *deviceID = nil;
//     if(cls && [cls respondsToSelector:deviceIDSelector]){
//     deviceID = [cls performSelector:deviceIDSelector];
//     }
//     NSLog(@"{\"oid\": \"%@\"}", deviceID);
//     */
//}

- (void)loadData
{
    // 1.显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    [[self class] setAppearance];
    
    // 2 自动登录
//    [self autoLogin];
    
    // 3 主界面
    [self showMainVCAndLogin];
}

+ (void)setAppearance
{
//    [UIActivityIndicatorView appearance].color = kJHSColorLightBlack;
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:IQKeyboardDistanceFromTextField];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:YES];
    
    [iToastSettings getSharedSettings].gravity = iToastGravityCenter;
    [iToastSettings getSharedSettings].duration = 2000;
}

- (void)showMainVCAndLogin
{
    if (!_mainViewController)
    {
        _mainViewController = [[MainViewController alloc] init];
    }
    
    UINavigationController *navVC = (UINavigationController *)_mainViewController.selectedViewController;
    if ([navVC presentedViewController])
    {
        [navVC dismissViewControllerAnimated:YES completion:nil];
    }
    [navVC popToRootViewControllerAnimated:NO];
    
    _mainViewController.selectedIndex = 0;
    
    //初始化当前页面索引为0
    _mainViewController.currentVCNumber = [NSNumber numberWithInt:0];
    
    self.window.rootViewController = _mainViewController;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [ShareSDK handleOpenURL:url wxDelegate:self];;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

-(void) onReq:(BaseReq*)req
{

}

-(void) onResp:(BaseResp*)resp
{

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
