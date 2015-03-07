//
//  MaxLenLimit.h
//  FDSDemo
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能描述:限制最大字符数

#ifndef FDSDemo_MaxLenLimit_h
#define FDSDemo_MaxLenLimit_h

//用户相关
#define kMax_IDCardNum           18 // 身份证号
#define kMax_RealName            24 // 真实姓名
#define kMax_Money               12 // 充值金额位数限制

//身份证号码输入限制
#define NUMBERS     @"0123456789"
#define xX          @"xX"
#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define Special_Character  @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'"

#define SpecialCharacterAndNumber @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789"

// 限制输入标点符号，字母，数字等字符
#define AllCharacterAndNumber @"[-/:\\;()$&@.,?!'\"{}#%^*+=_|~<>£¥€•]-：；（）¥@“”。，、？！.【】｛｝#%^*+=_—|～《》$&•…,^_^?!'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

#define kMax_Signature           100 // 个性签名
#define kMax_Address             100 // 地址
#define kMax_Phone               11  // 手机号
#define kMax_Tel                 18  // 电话号

#endif
