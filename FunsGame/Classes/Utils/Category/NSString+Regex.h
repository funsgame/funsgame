//
//  NSString+Regex.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)

//判断手机号
- (BOOL)isMobile;

//邮编
- (BOOL)isPostcode;

//mail
- (BOOL)isMail;

//空格
- (BOOL)isContainSpace;

//电话
- (BOOL)isTel;

//用户名格式：数字，字母下划线组成(4～32位)
- (BOOL)isJHSUserName;

//惠信密码：8～16位数字字母组成
- (BOOL)isJHSPassword;

//银卡号 8~25位数字
-(BOOL)isJHSBankCardNumber;

//提现金额非负数
-(BOOL)isJHSMoney;

//匹配身份证号码
-(BOOL)isJHSIdentityCard;

//特殊字符
- (BOOL)isSpacialCharacter;

//是否是合法的密码组成字符
- (BOOL)isLegalJHSPasswordCharacter;

//是否是合法的支付密码组成字符
- (BOOL)isLegalJHSPayPasswordCharacter;

//是否是合法的帐号组成字符
- (BOOL)isLegalJHSAccountCharacter;
// begin 

/// 变更账户注册格式规则（数字+字母（大写自动转小写））
- (BOOL)isLegalJHSAccountCharacterRegister;

// 合法身份证账号组成字符
- (BOOL)isLegalIDCardCharacter;

/// 只输入数字 +字母 + _@.
- (BOOL)isLegalJHSDemailCharacterRegister;

@end
