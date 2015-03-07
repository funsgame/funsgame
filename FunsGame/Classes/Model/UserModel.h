//
//  UserModel.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

@property (nonatomic ,copy) NSString *activate;//用户是否激活，即邮箱是否激活
@property (nonatomic, copy) NSString *cash;//用户现金余额
@property (nonatomic, copy) NSString *email;//邮箱号
@property (nonatomic, copy) NSString *cardNo;//身份证号
@property (nonatomic, copy) NSString *frozenInvestCash;//已冻结的投标中现金
@property (nonatomic, copy) NSString *frozenUnInvestCash;//已冻结的充值未投资金
@property (nonatomic, copy) NSString *frozenWithDrawCash;//已冻结的提现中现金
@property (nonatomic, copy) NSString *loginFailCount;//用户登陆时密码累积错误次数
@property (nonatomic, copy) NSString *mobile;//绑定的手机号
@property (nonatomic, copy) NSString *nickName;///昵称、及账号
@property (nonatomic, copy) NSString *realName;///真实姓名
@property (nonatomic, copy) NSString *payPwdFailCount;//用户修改支付密码输入累计错误次数
@property (nonatomic, copy) NSString *status;//用户状态,0:正常，10：被锁定
@property (nonatomic, copy) NSString *unInvestAmount;//充值未投资金额
@property (nonatomic, copy) NSString *userId;//用户ID
@property (nonatomic, copy) NSString *publicKey;//公钥

//惠卡宝业务需要用到 chenli
@property (nonatomic, strong) NSNumber *havePayPwd;     //是否有交易密码 0没有 1有
@property (nonatomic, strong) NSNumber *havePhone;      //是否有手机验证 0没有 1有
@property (nonatomic, strong) NSNumber *haveNameAuth;   //是否有实名认证 0没有 1有
@property (nonatomic, assign) double cardBalance; //惠卡宝余额,惠卡宝业务中需要用到,添加by chenli
//end

//账号验证存在参数
@property (nonatomic, assign) NSInteger isExists;

@property (nonatomic, assign) NSInteger isAuth;

//+ (BOOL)isLatestUserModel:(UserModel *)model;

/*
 //  每日剩余可捡金币次数
 @property (nonatomic, assign) NSInteger restPickCoinTimes;
 */

#pragma mark- 注册
/**
 *  会员注册
 *  @param phone        手机
 *  @param nickName      账号
 *  @param validateCode 验证码
 *  @param password     密码
 *  @param key          验证码key
 *  @param email        邮箱
 *  @param success
 */
+ (void)registerWithnickName:(NSString *)nickName
                    password:(NSString *)password
                       Phone:(NSString *)phone
                validateCode:(NSString *)validateCode
                       email:(NSString *)email
                      target:(id)target
                     success:(void (^)(id data))success;



#pragma mark- 登录
/**
 *  登录
 *  @param nickName  账号
 *  @param password 密码
 *  @param success
 */
+ (void)loginWithNickName:(NSString *)nickName
                 password:(NSString *)password
                   target:(id)target
                  success:(void (^)(id data))success;

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
                         success:(void (^)(id data))success;

#if 0  // 移动到SMSModel
#pragma mark - 发送短信接口
/**
 *  发送短信接
 *
 *  @param userId  用户ID
 *  @param mobile  手机号
 *  @param targete123
 
 *  @param codeType 1：提交绑定手机号申请 2：提交修改绑定手机号申请 3：修改银行信息 5：找回支付密码 6：注册短信验证码
 *  @param success
 */
+ (void)sendMessageUserId:(NSString *)userId
                   mobile:(NSString *)mobile
                 codeType:(NSString *)codeType
                   target:(id)target
                  success:(void (^)(id data))success;
#endif


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
                     success:(void (^)(id data))success;
#pragma mark - 退出登录
/**
 *  退出登录
 *
 *  @param userId  用户id
 *  @param success
 */

+ (void)outLoginUserId:(NSString *)userId
                target:(id)target
               success:(void (^)(id data))success;


#pragma mark- 获取个人信息
+ (void)getMyInfoWithUserId:(NSString *)userId
                     target:(id)target
                    success:(void (^)(id data))success;

#pragma mark- 找回密码

/**
 *  找回密码 验证账号存在  发送短信
 *
 *  @param nickName 用户名
 *  @param success
 */
+ (void)sendSMSnickName:(NSString *)nickName
                success:(void(^)(id data))success;



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
                     success:(void(^)(id data))success;

#pragma mark - 验证,短信验证码,通过则修改密码
+ (void)resetNewMobilePasswordNickName:(NSString *)nickName
                           newPassword:(NSString *)newPassword
                            mobileCode:(NSString *)mobileCode
                               success:(void(^)(id data))success;



#pragma mark- 申请借款
/**
 *  申请借款
 *  @param userId     用户id (没登录时不传)
 *  @param userName   用户名
 *  @param mobile     手机号
 *  @param qq         qq
 *  @param monthlyPay 月收入
 *  @param loanMoney  借款金额
 *  @param mortgage   是否有抵押 0 是 1 否
 *  @param guarantee  是否有担保机构 0 是 1 否
 *  @param address    所在地
 *  @param target
 *  @param success
 */
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
                    success:(void(^)(id data))success;

#pragma mark- 设置/重置支付密码
/**
 *  设置/重置支付密码
 *  @param userId      用户id (重置支付密码传"")
 *  @param payPassword 新支付密码
 *  @param mobileCode  验证码(设置支付密码，该参数=””,重置支付密码，该参数=”短信验证码”)
 *  @param target
 *  @param success
 */
+ (void)setPayPsswordWithUserId:(NSString *)userId
                    payPassword:(NSString *)payPassword
                     mobileCode:(NSString *)mobileCode
                         target:(id)target
                        success:(void (^)(id data))success;

#pragma mark- 修改支付密码
/**
 *  修改支付密码
 *  @param userId    用户id
 *  @param oldPayPwd 旧密码
 *  @param newPaypwd 新密码
 *  @param target
 *  @param success
 */
+ (void)updatePaypwdWithUserId:(NSString *)userId
                     oldPayPwd:(NSString *)oldPayPwd
                     newPaypwd:(NSString *)newPaypwd
                        target:(id)target
                       success:(void(^)(id data))success;

#pragma mark- 绑定／重绑手机号码

+ (void)updateMobileWithUserId:(NSString *)userId
                     newMobile:(NSString *)newMobile
                    mobileCode:(NSString *)mobileCode
                        target:(id)target
                       success:(void(^)(id data))success;

#pragma mark- 实名认证
+ (void)addCardNoAuthWithUserId:(NSString *)userId
                       realName:(NSString *)realName
                         cardNo:(NSString *)cardNo
                         target:(id)target
                        success:(void(^)(id data))success;


#pragma mark- 更新资料
/**
 *  更新资料，可以更新其中几项
 *  @param accountId       账号ID
 *  @param nickName        昵称
 *  @param recieverAddress 收货地址
 *  @param recieverPhone   收货联系电话
 *  @param reciever        收货人
 *  @param sex             性别
 *  @param target
 *  @param success
 */
/*
 
 + (void)modifyUserInfoWithAccountId:(NSString *)accountId
 nickName:(NSString *)nickName
 recieverAddress:(NSString *)recieverAddress
 recieverPhone:(NSString *)recieverPhone
 reciever:(NSString *)reciever
 sex:(NSInteger)sex
 target:(id)target
 success:(void (^)(id data))success;
 */

@end
