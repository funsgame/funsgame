//
//  Constants.h
//  FDSDemo
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能描述:定义常用的宏和app环境0

// 用户登录类型
typedef enum : NSUInteger {
    UserTypeNormal = 0,
    UserTypeWeixin,
    UserTypeQQ,
    UserTypeSina
} UserType;

// 新闻类型
typedef enum
{
    RecentlyType = 1,   // 最近
    InformatType,       // 资讯
    FocusType,          // 聚焦
    EvaluatType,        // 评测
    StrategyType,       // 攻略
    ProfessionType,     // 行业
    SpecialType         // 专栏
}NewsType;

#ifndef FDSDemo_Constants_h
#define FDSDemo_Constants_h

/********************** 头文件引入 ****************************/
#import "AppDelegate.h"

///公共类
#import "AppStyleRelated.h"    // 公共字体颜色等
#import "Image.h"              // 图片类
#import "MaxLenLimit.h"        // 字长度
#import "DataHelper.h"
#import "DataManager.h"
#import "SandboxFile.h"
#import "TimeUtil.h"
#import "UIInitMethod.h"
#import "Util.h"
#import "ReachbilityUtil.h"     // 添加网络监测
#import "CommonMethod.h"
#import "MyTextField.h"
#import "CountDownButton.h"
#import "UserHelper.h"

///类别
#import "iToast+myToast.h"
#import "NSString+MyString.h"
#import "NSString+Regex.h"
#import "UIImage+MyImage.h"
#import "NSDate+Category.h"
#import "UIWebView+Category.h"

///第三方库
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "UIViewExt.h"
#import "NotificationManager.h" // 添加通知中心管理类

///pod库
#import "FXNotifications.h"
#import "IQKeyboardManager.h"
#import "UIImageView+WebCache.h"
#import "MKNetworkOperation.h"
#import "SSKeychain.h"
#import "iOSBlocks.h"
#import "iToast.h"

///公共model
#import "UserModel.h"
#import "StatusModel.h"
#import "StatusArrModel.h"

///公共views
#import "SuperVC.h"
#import "BaseTableView.h"
#import "WithoutDataView.h"


//#import "CoreTextManager.h"
//#import "SuperTableVC.h"
//#import "UIKitHelper.h"

//#import "RoundCornerView.h"
//#import "BaseTableViewCell.h"
//#import "UIView+Addition.h"
//#import "MarkMessage.h"
//#import "MyLabel.h"
//#import "MicTextLimit.h"
//#import "IdentifierSingle.h"

// 新增宏定义判断无网络情况
#define GetNetworkStatusNotReachable ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable)

#define currentVersion ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])

//#ifndef BASE_Constans_h
//#define BASE_Constans_h

/********************** app环境 ****************************/
#define isTrueEnvironment 0

#if isTrueEnvironment

#pragma mark- 真实环境
/*
 资源访问路径：http://hkdmobile.365sji.com/restservice/服务器返回相对路径
 API访问路径：https://hkdmobile.365sji.com/restservice/rest/api/接口
 */
#define kServerHost     @"123.56.107.198"
#define kServerResourceHost @"http://hkdmobile.365sji.com/restservice"
#define kServerHtml @"http://hkdmobile.365sji.com/restservice/noticeDetail.jsp?noticeId=%@"
#define kServerHtmlWithWidth @"http://hkdmobile.365sji.com/restservice/noticeDetail.jsp?noticeId=%@&width=%f"

#else

#pragma mark- 测试环境
/*
 资源访问路径：http://域名或IP:端口/restservice/服务器返回相对路径
 API访问路径：http://域名或IP:端口/restservice/rest/api/接口
 */
//#define kServerHost     @"qichedai.365sji.com/restservice/rest/api"
//#define kServerResourceHost @"http://qichedai.365sji.com:8027/restservice"

#define kServerHost     @"123.56.107.198"
//#define kServerResourceHost @"http://qichedai.365sji.com:8027/restservice"
//#define kServerHtml @"http://qichedai.365sji.com:8027/restservice/noticeDetail.jsp?noticeId=%@"
//#define kServerHtmlWithWidth @"http://qichedai.365sji.com:8027/restservice/noticeDetail.jsp?noticeId=%@&width=%f"

#endif

/********************** 常用宏 ****************************/

#define GetAPPDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/// Color
#define UIColorRGB(R,G,B)   [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define UIColorHex(hex)     [DataHelper colorWithHexString:hex]
#define kBackgroundColor    UIColorRGB(247, 247, 247)
#define kFunsColorBlack     UIColorHex(@"#121212")

#define kJHSColorRed        UIColorHex(@"#e60012")  //投资进度条，立即投资按钮，充值提现文字信息等
#define kJHSColorBlack      UIColorHex(@"#333333")  //导航名称，大板块标题，类目名称等
#define kJHSColorDarkBlack  UIColorHex(@"#666666")  //列表中标的名称，倒计时，数字类别等
#define kJHSColorMidBlack   UIColorHex(@"#999999")  //回款计划期数，已认证未认证等辅助信息
#define kJHSColorLightBlack UIColorHex(@"#dcdcdc")  //分割线，输入框默认字段等
#define kJHSColorDarkWhite  UIColorHex(@"#efefef")  //内容区域底色等
#define kJHSColorLightWhite UIColorHex(@"#f8f8f8")  //导航栏底色


#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

#define kPageSize 10
#define kIntToString(i)     [NSString stringWithFormat:@"%d",i]
#define kLocalizedString(key) NSLocalizedString(key, nil)

/// Date
#define kDateFormatDefault  @"yyyy-MM-dd HH:mm:ss"
#define kDateFormat_yyMdHm  @"yy-MM-dd HH:mm"
#define kDateFormat_yyyyMdHm  @"yyyy-MM-dd HH:mm"
#define kDateFormat_yMd     @"yyyy-MM-dd"
#define kDateFormat_MdHms   @"MM-dd HH:mm:ss"
#define kDateFormat_MdHm    @"MM-dd HH:mm"
#define kDateFormatTime     @"HH:mm:ss"
#define kDateFormat_Hm      @"HH:mm"
#define kDateFormat_Md      @"MM-dd"
#define kDateFormat_yyMd    @"yy-MM-dd"
#define kDateFormat_YYMMdd  @"yyyyMMdd"
#define kDateFormat_yyyyMdHms  @"yyyyMMddHHmmss"

/// Height/Width
#define kScreenWidth        [UIScreen mainScreen].applicationFrame.size.width
#define kScreenHeight       [UIScreen mainScreen].applicationFrame.size.height
#define kAllHeight          ([UIScreen mainScreen].applicationFrame.size.height + 20.0)
#define kBodyHeight         ([UIScreen mainScreen].applicationFrame.size.height - 44.0)
#define kTabbarHeight       49
#define kSearchBarHeight    45
#define kStatusBarHeight    20

/// Sys
#define ISiPhone    [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISiPad      [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define iPhone5   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define ISIOS7      ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define UIInterfaceOrientationIsPortrait(orientation)  ((orientation) == UIInterfaceOrientationPortrait || (orientation) == UIInterfaceOrientationPortraitUpsideDown)
#define UIInterfaceOrientationIsLandscape(orientation) ((orientation) == UIInterfaceOrientationLandscapeLeft || (orientation) == UIInterfaceOrientationLandscapeRight)

#define INTERFACEPortrait self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
#define INTERFACELandscape self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight

/// Dlog
#ifdef DEBUG
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#   define ELog(err) {if(err) DLog(@"%@", err)}
#else
#   define DLog(...)
#   define ELog(err)
#endif

/// DataManager
#define GetDataManager [DataManager sharedManager]

/// NSMutableDictionary
#define GetMutableDic NSMutableDictionary *dic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) [dic setObject:obj forKey:key]
#define DicValueSet(value,key) [dic setValue:value forKey:key]

/// int to str
#define NSIntegerToNSString(intValue) [NSString stringWithFormat:@"%d", intValue]

/// Path
#define kChatImageDirectory @"ChatImage"
#define kChatVoiceDirectory @"ChatVoice"

/**************************************************/
#define kSSToolkitTestsServiceName @"HKDUser"

/// 通知
// 登录成功
#define kLoginNotification @"LoginOK"
// 退出登录
#define kLogoutNotification @"LogoutOK"
// 手势设置成功
#define kGesSetOkNotification @"GesSetOkNotification"
// 手势页面正在显示并且变为激活状态
#define kGesIsShowAndBecomeActiveNotification @"GesIsShowAndBecomeActiveNotification"

/// 网络断开
#define kloadfailedNotNetwork @"网络异常,请检查网络!"

#endif
