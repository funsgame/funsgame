//
//  MeSettingVC.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "MeSettingVC.h"
#import "SettingHeadCell.h"
#import "SettingOtherCell.h"
#import "SettingVC.h"
#import <ShareSDK/ShareSDK.h>

@interface MeSettingVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingTable;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation MeSettingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"设置";
        _imageArr = [NSArray array];
        _titleArr = [NSArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    
    [self loadImage];
    
}

- (void)initView
{
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:nil imageName:@"add" target:self action:@selector(addClick:)];

    _settingTable = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), self, self, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _settingTable.showsVerticalScrollIndicator = NO;
    _settingTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _settingTable.backgroundColor = kBackgroundColor;
    _settingTable.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    
    [DataHelper setExtraCellLineHidden:_settingTable];
}

- (void)addClick:(id)sender
{

}

- (void)loadImage
{
    _imageArr = @[@[@""],
                    @[@"chat",@"notisfication",@"followed",@"following"],
                    @[@"fav_personal"],
                    @[@"setting"]];
    
    _titleArr = @[@[@""],
                  @[@"对话",@"通知",@"关注",@"粉丝"],
                  @[@"收藏"],
                  @[@"设置"]];

}

- (void)sinaLogin
{
    [self loginOpenIdWithShareType:ShareTypeSinaWeibo];
}

- (void)qzoneLogin
{
    [self loginOpenIdWithShareType:ShareTypeQQSpace];
}

- (void)loginOpenIdWithShareType:(ShareType)type
{
    [ShareSDK cancelAuthWithType:type];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    nil]];
    
    [ShareSDK getUserInfoWithType:type
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error){
                               if (result)
                               {
                                   [self loginOpenId:userInfo];
                               }
                               
                               NSLog(@"%d:%@",[error errorCode], [error errorDescription]);
                           }];
}

- (void)loginOpenId:(id<ISSPlatformUser>)userInfo{
    UserType userType = [userInfo type] == ShareTypeSinaWeibo?UserTypeSina:UserTypeQQ;
    [SVProgressHUD showWithStatus:@"登录中..."];
//    kSelf;
//    [UserModel loginWithAccount:[userInfo uid]
//                   withPassword:nil
//                       withType:userType
//                        success:^(StatusModel *data) {
//                            kSelfStrong;
//                            [SVProgressHUD dismiss];
//                            if (data.flag == 1) {
//                                [iToast alertWithTitle:@"登录成功"];
//                                [[DataManager sharedManager] loginSucceed];
//                                [self reloadData];
//                            }else if(data.flag == -1) {
//                                [self registOpenId:userInfo];
//                            }else{
//                                [iToast alertWithTitle:data.msg];
//                            }
//                        }];
}

- (void)registOpenId:(id<ISSPlatformUser>)userInfo
{
    UserType userType = [userInfo type] == ShareTypeSinaWeibo?UserTypeSina:UserTypeQQ;
//    kSelf;
//    [UserModel registOpenIdWithOpenid:[userInfo uid]
//                          withFaceUrl:[userInfo profileImage]
//                             nickName:[userInfo nickname]
//                             withType:userType success:^(StatusModel *data) {
//                                 kSelfStrong;
//                                 if (data.flag == 1) {
//                                     [self loginOpenId:userInfo];
//                                 }
//                             }];
}

//-(void)getWeiboUserInfo:(NSString *)accesToken userID:(NSString *)userID {
//    
//    [WBHttpRequest requestForUserProfile:userID
//                         withAccessToken:accesToken
//                      andOtherProperties:nil
//                                   queue:nil
//                   withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//                       
//                       if  (error) {
//                           [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_SNS_WBAUTHOR_FAIL object:nil];
//                           
//                       }
//                       else {
//                           /*
//                            WeiboUser:
//                            userID=2116825552,
//                            userClass=1,
//                            screenName=爱娱乐爱美图,
//                            name=爱娱乐爱美图,
//                            province=11,
//                            city=8,
//                            location=北京 海淀区,
//                            userDescription=,
//                            url=,
//                            profileImageUrl=http://tp1.sinaimg.cn/2116825552/50/5598852039/1,
//                            coverImageUrl=(null) ,coverImageForPhoneUrl=(null),
//                            profileUrl=100beauty,
//                            userDomain=100beauty,
//                            weihao=,
//                            gender=m,
//                            followersCount=76,
//                            friendsCount=238,
//                            pageFriendsCount=0,
//                            statusesCount=142,
//                            favouritesCount=1,
//                            createdTime=Wed Apr 27 13:59:45 +0800 2011,
//                            verifiedType=-1,
//                            remark=,
//                            statusID=(null),
//                            ptype=0,
//                            avatarLargeUrl=http://tp1.sinaimg.cn/2116825552/180/5598852039/1,
//                            avatarHDUrl=http://tp1.sinaimg.cn/2116825552/180/5598852039/1,
//                            verifiedReason=,
//                            verifiedTrade=,
//                            verifiedReasonUrl=,
//                            verifiedSource=,
//                            verifiedSourceUrl=,
//                            verifiedState=(null),
//                            verifiedLevel=(null),
//                            onlineStatus=0,
//                            biFollowersCount=29,
//                            language=zh-cn,
//                            mbtype=0,
//                            mbrank=0,
//                            block[_word=0,
//                            block_app=0,
//                            credit_score=80,
//                            isFollowingMe=0,
//                            isFollowingByMe=0,
//                            isAllowAllActMsg=0,
//                            isAllowAllComment=1,
//                            isGeoEnabled=1,
//                            isVerified=0
//                            
//                            */
//                           WeiboUser *user = (WeiboUser *)result;
//                           self.wbUserInfo = [[SNSUserInfo alloc] init];
//                           self.wbUserInfo.uid = user.userID;
//                           self.wbUserInfo.unickName = user.screenName;
//                           self.wbUserInfo.uiconUrl = user.profileImageUrl;
//                           self.wbUserInfo.uCity = user.location;
//                           //Gender, m--male, f-- female, n-- unknown
//                           if ([user.gender isEqualToString:@"m"]) {
//                               self.wbUserInfo.uSex = SNSUser_Gender_Male;
//                           }
//                           else if ([user.gender isEqualToString:@"f"]) {
//                               self.wbUserInfo.uSex = SNSUser_Gender_Female;
//                           }
//                           else {
//                               self.wbUserInfo.uSex = SNSUser_Gender_Unkown;
//                           }
//                           self.wbUserInfo.uDesc = user.userDescription;
//                           
//                           [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_SNS_WBAUTHOR_OK object:nil];
//                           
//                       }
//                   }];
//}
//#pragma mark - Weibo Delegate
//
//- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
//{
//    
//}
//
//- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
//{
//    if ([response isKindOfClass:WBAuthorizeResponse.class])
//    {
//        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,
//                             [(WBAuthorizeResponse *)response userID],
//                             [(WBAuthorizeResponse *)response accessToken],
//                             NSLocalizedString(@"响应UserInfo数据", nil),
//                             response.userInfo,
//                             NSLocalizedString(@"原请求UserInfo数据", nil),
//                             response.requestUserInfo];
//        
//        DLog(@"weibo response:%@",message);
//        /*
//         响应UserInfo数据: {
//         "access_token" = "2.00cBzP_CxPt3kC68e96bf5e088OJhC";
//         "expires_in" = 105333;
//         "remind_in" = 105333;
//         scope = "follow_app_official_microblog";
//         uid = 2116825552;
//         }
//         */
//        
//        
//        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
//            WBAuthorizeResponse *res = (WBAuthorizeResponse *)response;
//            self.wbAccesToken = [res accessToken];
//            self.wbRefreshToken = [res refreshToken];
//            self.wbExpiresAt = [[res expirationDate] timeIntervalSince1970];
//            NSString *uid = [res userID];
//            [self getWeiboUserInfo:self.wbAccesToken userID:uid];
//            
//        }
//        else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_SNS_WBAUTHOR_FAIL object:nil];
//        }
//    }
//    
//    /*
//     if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
//     {
//     NSString *title = NSLocalizedString(@"发送结果", nil);
//     NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
//     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//     message:message
//     delegate:nil
//     cancelButtonTitle:NSLocalizedString(@"确定", nil)
//     otherButtonTitles:nil];
//     WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
//     NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
//     if (accessToken)
//     {
//     self.wbtoken = accessToken;
//     }
//     NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
//     if (userID) {
//     self.wbCurrentUserID = userID;
//     }
//     [alert show];
//     [alert release];
//     }
//     
//     else if ([response isKindOfClass:WBPaymentResponse.class])
//     {
//     NSString *title = NSLocalizedString(@"支付结果", nil);
//     NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
//     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
//     message:message
//     delegate:nil
//     cancelButtonTitle:NSLocalizedString(@"确定", nil)
//     otherButtonTitles:nil];
//     [alert show];
//     [alert release];
//     }
//     */
//}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(1 == section)
        return 4;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.section)
    {
        static NSString *reuserCell = @"setting_head_cell";
        
        SettingHeadCell *cell = (SettingHeadCell *)[tableView dequeueReusableCellWithIdentifier:reuserCell];
        if (!cell)
        {
            cell = [[SettingHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell.sinaBtn addTarget:self action:@selector(sinaLogin) forControlEvents:UIControlEventTouchUpInside];
        [cell.qzoneBtn addTarget:self action:@selector(qzoneLogin) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else
    {
        static NSString *reuserCell = @"setting_other_cell";
        
        SettingOtherCell *cell = (SettingOtherCell *)[tableView dequeueReusableCellWithIdentifier:reuserCell];
        if (!cell)
        {
            cell = [[SettingOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserCell];
        }
        
        cell.headImage.image = [UIImage imageNamed:_imageArr[indexPath.section][indexPath.row]];
        cell.titleLabel.text = _titleArr[indexPath.section][indexPath.row];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(3 == indexPath.section)
    {
        SettingVC *vc = [[SettingVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(0 == indexPath.section)
        return 70;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
