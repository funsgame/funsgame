//
//  DataHelper.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger minlengthAccount = 4; // 惠信帐号最少位数
static NSInteger maxlengthAccout = 32; // 惠信帐号最多位数
static NSInteger minlengthPW = 8;      // 密码最少位数
static NSInteger maxlengthPW = 16;     // 密码最多位数

@class HZActivityIndicatorView;
@interface DataHelper : NSObject

//根据最小尺寸转换图片
+ (UIImage *)scaleImage:(UIImage *)image toMinSize:(float)size;
//根据比例转换图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//保存图片到Cache
+ (void)saveImage:(UIImage *)tempImage WithPath:(NSString *)path;
//从文档目录下获取路径
+ (NSString *)cachesFolderPathWithName:(NSString *)imageName;
//指定路径删除文件
+ (void)removeCachesFolderAtPath:(NSString*)filePath;

#pragma mark - 获取聊天文件路径
//获取聊天图片路径
+ (NSString *)getChatImagePathWithName:(NSString *)imageName;
//获取聊天语音路径
+ (NSString *)getChatVoicePathWithName:(NSString *)imageName;

//获取现在时间
+(NSString *)getCurrentTime;
//tableView隐藏多余的线
+ (void)setExtraCellLineHidden:(UITableView *)tableView;
//转化DeviceToken
+(NSString*)conversionDeviceToken:(NSData*)deviceToken;

// 随机获取文件名 例如20131111_051014
+ (NSString*)getRandomFileName;
//获取一个随机整数，范围在[from,to），包括from，不包括to
+(int)getRandomNumber:(int)from to:(int)to;

#pragma mark - gps
//判断gps是否有效
+ (BOOL)gpsIsValidLongitude:(double)longitude latitude:(double)latitude;

//xml
//+(NSXMLElement*)creationPropertyName:(NSString*)name valueType:(NSString*)valueType value:(NSString*)value;

//唯一字符串
+(NSString *)generateUUID;

#pragma mark - UIColor
+ (UIColor *)colorWithHexString:(NSString *)color;

/**
 *  32位 md5加密
 *  @param srcString 需要加密的字符串
 *  @param uppercase 是否需要转大写
 *  @return 加密后的字符串
 */
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase;

/**
 *  16位 md5加密
 *  @param srcString 需要加密的字符串
 *  @param uppercase 是否需要转大写
 *  @return 加密后的字符串
 */
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString uppercase:(BOOL)uppercase;

/**
 *  获取文件MD5
 *  @param path filePath
 *  @return
 */
+(NSString*)fileMD5:(NSString*)path;

/**
 *  计算高度
 *  @param string 需要计算高度的字符串
 *  @param font   字体
 *  @param width  限制宽度
 *  @return 返回计算出来的高度
 */
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  计算宽度
 *  @param string
 *  @param font
 *  @return
 */
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;


/**
 *  设置textfiled左边的空白
 *  @param textField
 *  @param rect
 */
+ (void)setEmptyLeftViewForTextField:(UITextField *)textField withFrame:(CGRect)rect;

//+ (HZActivityIndicatorView*)getActivityIndicatorView;

//给谁谁发信息
+ (NSString *)showPromptMessage:(NSString *)phone;
//判断是否为空字符串
//+(BOOL) isEmptyOrNull:(NSString *) string;

/**
 *  限制textfild 小数位数为2位
 */
+ (BOOL)setRadixPointForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

// begin 金额输入限制位数，可自定义整数位

+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number;

// 金额输入限制（首位不能为0）
+ (BOOL)setlimitForTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string number:(int)number shouldBiggerThanOne:(BOOL)bigger;

// 密码输入长度限制
+ (BOOL)setlimitPwdForTextField:(UITextField *)textField number:(int)number min:(BOOL)min;

// end

// string to number
+ (NSNumber *)stringToNum:(NSString *)string;

// 加密手机号
+ (NSString *)getSecretStylePhone:(NSString *)phoneStr;

//替换frame 的高度
+ (CGRect)changeFrame:(CGRect)frame setHeight:(CGFloat)height;

@end
