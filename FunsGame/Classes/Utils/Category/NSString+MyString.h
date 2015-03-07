//
//  NSString+MyString.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyString)

+ (NSString *)stringBySpaceTrim:(NSString *)string;
//替换@为#
- (NSString *)replacingAtWithOctothorpe;
- (NSString *)replacingOctothorpeWithAt;
- (NSString *)replacingEnterWithNull;

+ (BOOL)containsChinese:(NSString *)string;
+ (NSString*)stringByNull:(NSString*)string;
+ (BOOL)isNull:(NSString *)string;
+ (BOOL)isEmptyAfterSpaceTrim:(NSString *)string;

- (BOOL)isBlank;

+ (BOOL)isPureInt:(NSString*)string;//判断是否纯数字

+ (BOOL)isPureFloat:(NSString*)string;//判断浮点型

//手机号添加空格
+ (NSString *)addBlank:(NSString *)phone;

//浮点型数据不四舍五入
+(NSString *)notRounding:(double)price afterPoint:(int)position;

+ (NSString *)getClearHtmlString:(NSString *)htmlString clearSpace:(BOOL)clear;

+ (NSString *)hexStringFromString:(NSString *)string;

@end
