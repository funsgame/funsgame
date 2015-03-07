//
//  Image.h
//  FDSDemo
//
//  Created by weibin on 14/11/24.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能描述:定义公用图片

#ifndef FDSDemo_Image_h
#define FDSDemo_Image_h

//默认图片背景
#define kdefaultImage @"defaultImage"
#define kcommon_logo @"common_logo"

//  按钮
#define kCommon_bt_normal @"common_bt_normal"
#define kCommon_bt_normal_s @"common_bt_normal_s"

#define kCommon_bt_touchDown @"common_bt_touchDown"
#define kCommon_bt_disable @"common_bt_disable"

//获取验证码
#define verificationcode_image_s  @"verificationcode_image_s"
#define verificationcode_image    @"verificationcode_image"
#define verificationcode_image_e  @"verificationcode_image_e"

#define business_allClass_image   @"business_allClass_image"
#define business_list_background  @"business_list_background"


//  四种情况组合输入框和cell的背景
#define kImage_LTSB [[UIImage imageWithName:@"longTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTLB [[UIImage imageWithName:@"longTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB [[UIImage imageWithName:@"noTopShortBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTLB [[UIImage imageWithName:@"noTopLongBottom"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_LTSB2 [[UIImage imageWithName:@"longTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 70, 2, 0) resizingMode:UIImageResizingModeStretch]
#define kImage_NTSB2 [[UIImage imageWithName:@"noTopShortBottom2"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 70, 2, 0) resizingMode:UIImageResizingModeStretch]

//  通用橙色确认按钮
#define kImg_Common_bt_normal [[UIImage imageWithName:kCommon_bt_normal] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define kImg_Common_bt_normal_s [[UIImage imageWithName:kCommon_bt_normal_s] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

#define kImg_Common_bt_touchDown [[UIImage imageWithName:kCommon_bt_touchDown] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]
#define kImg_Common_bt_disable [[UIImage imageWithName:kCommon_bt_disable] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]

//登陆图片
#define kField_input   @"field_input"
#define kLogin_phone   @"login_phone"
#define kLogin_password @"login_password"
#define kLogin_validate @"login_validate"

#endif
