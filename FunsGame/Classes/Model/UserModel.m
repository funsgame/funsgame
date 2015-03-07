//
//  UserModel.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "UserModel.h"
#import "UUIDHelper.h"

@implementation UserModel

+ (NSString *)getPrimaryKey
{
    return @"userId";
}
#if 0
+(void)dbDidInserted:(NSObject *)entity result:(BOOL)result
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUserModelUpdatedNotification object:nil];
}
#endif

//static inline bool compare(NSString *str1, NSString *str2)
//{
//    str1 = [NSString stringByNull:str1];
//    str2 = [NSString stringByNull:str2];
//    return [str1 isEqualToString:str2];
//}

/*
 + (BOOL)isLatestUserModel:(UserModel *)model
 {
 NSString *where = [NSString stringWithFormat:@"%@=%d", [self getPrimaryKey], model.accountId];
 UserModel *searchModel = [[self class] searchSingleWithWhere:where orderBy:nil];
 
 if (!compare(model.phone, searchModel.phone) ||
 !compare(model.imageUrl, searchModel.imageUrl) ||
 !compare(model.nickName, searchModel.nickName) ||
 !compare(model.recieverName, searchModel.recieverName) ||
 !compare(model.recieverAddress, searchModel.recieverAddress) ||
 !compare(model.recieverPhone, searchModel.recieverPhone) ||
 model.level != searchModel.level ||
 model.goldCoins != searchModel.goldCoins ||
 model.sex != searchModel.sex ||
 model.logInDays != searchModel.logInDays ||
 model.inviteFriendCount != searchModel.inviteFriendCount ||
 model.lastChampionGoldCount != searchModel.lastChampionGoldCount
 ) {
 return NO;
 } else {
 return YES;
 }
 }
 */

//- (void)update
//{
//    if (![[self class] isLatestUserModel:self]) {
//        [self saveToDB];
//    }
//}

//************************************下面是网络请求接口********************************
#pragma mark- 注册
+ (void)registerWithnickName:(NSString *)nickName
                    password:(NSString *)password
                       Phone:(NSString *)phone
                validateCode:(NSString *)validateCode
                       email:(NSString *)email
                      target:(id)target
                     success:(void (^)(id data))success;
{
    GetMutableDic;
    DicObjectSet(nickName, @"nickName");
    DicObjectSet([DataHelper getMd5_32Bit_String:password uppercase:NO], @"password");
    DicObjectSet(email, @"email");
    DicObjectSet(phone, @"mobile");
    DicObjectSet(validateCode, @"mobileCode");
    
//    [self postDataResponsePath:@"register" params:dic networkHUD:0 target:target onCompletion:^(id data) {
//        StatusModel *model = [self statusModelFromJSONObject:data];
//        if (success) {
//            success(model);
//        }
//    }];
}


#pragma mark- 登录
+ (void)loginWithNickName:(NSString *)nickName password:(NSString *)password target:(id)target success:(void (^)(id data))success
{
    NSString *uuid = [UUIDHelper sharedInstance].uuid;
    GetMutableDic;
    DicObjectSet(nickName, @"nickName");
    DicObjectSet([DataHelper getMd5_32Bit_String:password uppercase:NO], @"password");
    DicObjectSet(uuid, @"mac");
    
    
//    [self postDataResponsePath:@"login" params:dic networkHUD:NetworkHUDLockScreenAndMsg target:target onCompletion:^(id data) {
//        StatusModel *statusModel = [self statusModelFromJSONObject:data];
//        if (statusModel.resultStatus == 1) {
////            [DataManager sharedManager].userModel = statusModel.list;
//            
//        }
//        if (success) {
//            success(statusModel);
//        }
//    }];
}

/**
 *  退出登录
 *
 *  @param userId  用户id
 *  @param success
 */
+ (void)outLoginUserId:(NSString *)userId
                target:(id)target
               success:(void (^)(id data))success
{
    
    GetMutableDic;
    DicObjectSet(userId, @"userId");
    
//    [self postDataResponsePath:@"outLogin" params:dic networkHUD:0 target:target onCompletion:^(id data) {
//        StatusModel *model = [self statusModelFromJSONObject:data];
//        if (success) {
//            success(model);
//        }
//    }];
    
}


#pragma mark - 检查【邮箱、身份证、手机、用户名】唯一
/**
 *  检查
 *
 *  @param value
 *  @param type    type：1：邮箱是否唯一 2：手机是否唯一 3：验证账号是否唯一 5：验证身份证号码唯一性
 *  @param success
 */
+ (void)determineUniquenessValue:(NSString *)value
                            type:(NSString *)type
                          target:(id)target
                         success:(void (^)(id data))success
{
    GetMutableDic;
    DicObjectSet(value, @"value");
    DicObjectSet(type, @"type");
//    [self postDataResponsePath:@"checkItem" params:dic networkHUD:0 target:target onCompletion:^(id data) {
//        StatusModel *model = [self statusModelFromJSONObject:data];
//        if (success) {
//            success(model);
//        }
//    }];
}

#if 0
#pragma mark - 发送短信接口
/**
 *  发送短信接
 *
 *  @param userId  用户ID
 *  @param mobile  手机号
 *  @param target
 *  @param codeType 2：修改绑定手机号申请（发送给当前手机号，验证码）3：修改银行信息 5：找回支付密码 7：绑定手机号（发送给新号码，验证码）
 *  @param success
 */
+ (void)sendMessageUserId:(NSString *)userId
                   mobile:(NSString *)mobile
                 codeType:(NSString *)codeType
                   target:(id)target
                  success:(void (^)(id data))success
{
    GetMutableDic;
    DicObjectSet(userId, @"userId");
    DicObjectSet(mobile, @"mobile");
    DicObjectSet(codeType, @"codeType");
    
    [self postDataResponsePath:@"sendVerifiSMS" params:dic networkHUD:0 target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

/**
 *  发送短信验证接口【不需要登录】
 *
 *  @param userId   用户ID
 *  @param mobile   手机号
 *  @param codeType 6：注册绑定手机号码短信验证码 8: 借款申请验证码（登录状态userId=当前用户ID，否则忽略userId）
 *  @param target
 *  @param success
 */
+ (void)sendMobileCodeUserId:(NSString *)userId
                      mobile:(NSString *)mobile
                    codeType:(NSString *)codeType
                      target:(id)target
                     success:(void (^)(id data))success{
    GetMutableDic;
    DicObjectSet(userId, @"userId");
    DicObjectSet(mobile, @"mobile");
    DicObjectSet(codeType, @"codeType");
    
//    [self postDataResponsePath:@"sendMobileCode" params:dic networkHUD:0 target:target onCompletion:^(id data) {
//        StatusModel *model = [self statusModelFromJSONObject:data];
//        if (success) {
//            success(model);
//        }
//    }];
    
    
    
}
#pragma mark- 获取个人信息
+ (void)getMyInfoWithUserId:(NSString *)userId
                     target:(id)target
                    success:(void (^)(id data))success;{
    GetMutableDic;
    DicObjectSet(userId, @"userId");
    
    [self postDataResponsePath:@"findByUserInfo" params:dic networkHUD:0 target:self onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#pragma mark- 找回密码
/**
 *  找回密码 验证账号存在  发送短信
 *
 *  @param nickName 用户名
 *  @param success
 */
+ (void)sendSMSnickName:(NSString *)nickName
                success:(void(^)(id data))success
{
    GetMutableDic;
    DicObjectSet(nickName, @"nickName");
    
    [self postDataResponsePath:@"sendSMS" params:dic networkHUD:NetworkHUDLockScreenAndMsg target:self onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#pragma mark - 验证,短信验证码,通过则修改密码
+ (void)resetNewMobilePasswordNickName:(NSString *)nickName
                           newPassword:(NSString *)newPassword
                            mobileCode:(NSString *)mobileCode
                               success:(void(^)(id data))success
{
    
    GetMutableDic;
    DicObjectSet(nickName, @"nickName");
    DicObjectSet([DataHelper getMd5_32Bit_String:newPassword uppercase:NO], @"newPassword");
    DicObjectSet(mobileCode, @"mobileCode");
    
    [self postDataResponsePath:@"resetNewMobilePassword" params:dic networkHUD:NetworkHUDLockScreenAndMsg target:self onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
    
}

#pragma mark - 验证】,验证码是否正确
/**
 *   1:修改手机号码,验证原手机收到的验证码是否正确 userKey =需要用户 ID
 *   2:找回登录密码,验证输入的验证码与发送的是否一致  userKey =nickname(用户账号)
 *   找回支付密码,同上 userKey =需要用户 ID
 *  @param userKey   ID
 *  @param code    验证码
 *  @param type
 *  @param success
 */

+ (void)checkAuthCodeUserKey:(NSString *)userKey
                        code:(NSString *)code
                        type:(NSString *)type
                     success:(void(^)(id data))success
{
    GetMutableDic;
    DicObjectSet(userKey, @"userKey");
    DicObjectSet(code, @"code");
    DicObjectSet(type, @"type");
    
    [self postDataResponsePath:@"checkAuthCode" params:dic networkHUD:NetworkHUDLockScreenAndError target:self onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
    
    
    
}


#pragma mark- 申请借款
+ (void)loanApplyWithUserId:(NSString *)userId
                   userName:(NSString *)userName
                     mobile:(NSString *)mobile
                         qq:(NSString *)qq
                 monthlyPay:(NSString *)monthlyPay
                  loanMoney:(NSString *)loanMoney
                   mortgage:(NSString *)mortgage
                  guarantee:(NSString *)guarantee
                    address:(NSString *)address
                     target:(id)target
                    success:(void(^)(id data))success
{
    GetMutableDic;
    if (![NSString isEmptyAfterSpaceTrim:userId])
    {
        DicObjectSet(userId, @"userId");
    }
    DicObjectSet(userName, @"userName");
    DicObjectSet(mobile, @"mobile");
    DicObjectSet(qq, @"qq");
    DicObjectSet(monthlyPay, @"monthlyPay");
    DicObjectSet(loanMoney, @"loanMoney");
    DicObjectSet(mortgage, @"mortgage");
    DicObjectSet(guarantee, @"guarantee");
    DicObjectSet(address, @"address");
    
    [self postDataResponsePath:@"loanApply" params:dic networkHUD:0 target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#pragma mark- 设置/重置支付密码

+ (void)setPayPsswordWithUserId:(NSString *)userId
                    payPassword:(NSString *)payPassword
                     mobileCode:(NSString *)mobileCode
                         target:(id)target
                        success:(void (^)(id data))success
{
    GetMutableDic;
    DicValueSet(userId, @"userId");
    DicValueSet([DataHelper getMd5_32Bit_String:payPassword uppercase:NO], @"payPassword");
    DicValueSet(mobileCode, @"mobileCode");
    
    [self postDataResponsePath:@"setPayPassword" params:dic networkHUD:NetworkHUDLockScreenAndMsg target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#pragma mark- 修改支付密码

+ (void)updatePaypwdWithUserId:(NSString *)userId
                     oldPayPwd:(NSString *)oldPayPwd
                     newPaypwd:(NSString *)newPaypwd
                        target:(id)target
                       success:(void(^)(id data))success
{
    GetMutableDic;
    DicValueSet(userId, @"userId");;
    
    DicValueSet([DataHelper getMd5_32Bit_String:oldPayPwd uppercase:NO], @"oldPayPwd");
    DicValueSet([DataHelper getMd5_32Bit_String:newPaypwd uppercase:NO], @"newPayPwd");
    
    [self postDataResponsePath:@"updatePayPwd" params:dic networkHUD:NetworkHUDLockScreenAndMsg target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#pragma mark- 绑定／重绑手机号码

+ (void)updateMobileWithUserId:(NSString *)userId
                     newMobile:(NSString *)newMobile
                    mobileCode:(NSString *)mobileCode
                        target:(id)target
                       success:(void(^)(id data))success
{
    GetMutableDic;
    DicObjectSet(userId, @"userId");
    DicObjectSet(newMobile, @"newMobile");
    DicObjectSet(mobileCode, @"mobileCode");
    
    
    [self postDataResponsePath:@"updateMobile" params:dic networkHUD:NetworkHUDLockScreenAndMsg target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#pragma mark- 实名认证
+ (void)addCardNoAuthWithUserId:(NSString *)userId
                       realName:(NSString *)realName
                         cardNo:(NSString *)cardNo
                         target:(id)target
                        success:(void(^)(id data))success
{
    GetMutableDic;
    DicObjectSet(userId, @"userId");
    DicObjectSet(realName, @"realName");
    DicObjectSet(cardNo, @"cardNo");
    
    
    [self postDataResponsePath:@"addCardNoAuth" params:dic networkHUD:0 target:target onCompletion:^(id data) {
        StatusModel *model = [self statusModelFromJSONObject:data];
        if (success) {
            success(model);
        }
    }];
}

#endif

@end
