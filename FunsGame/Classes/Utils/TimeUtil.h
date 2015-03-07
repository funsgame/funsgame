//
//  TimeUtil.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

+ (NSString*)getTimeStr:(long) createdAt;

+ (NSString*)getFullTimeStr:(long long)time;

+ (NSString*)getMDStr:(long long)time;

+(NSDateComponents*) getComponent:(long long)time;

+(NSString*) getTimeStrStyle1:(long long)time;

+(NSString*) getTimeStrStyle2:(long long)time;

+(NSString*) getTimeStrStyle3:(long long)time;

//dataFormat
+ (NSString*)getDate:(NSDate*)date withFormat:(NSString*)dataFormat;
+ (NSDate*)getDateWithDateString:(NSString*)date dateFormat:(NSString*)format;
//默认格式时间，聊天用
+ (NSString*)getDefaultDateFormat:(NSDate*)date;
//获取消息列表时间格式
+ (NSString*)getMessageDateFormat:(NSDate*)date;
//聊天时间格式
+ (NSString*)getChatDateFormat:(NSDate*)date;
//获取朋友圈时间格式
+ (NSString*)getFriendsCircleDateFormat:(NSDate*)date;
//
+ (NSString*)getTimeStrStyle4:(NSDate *)date;

+(NSString *)getYearAndMonthStyle:(NSDate *)date count:(int)count;

+(NSString *)getYearAndMonthAndDayStyle:(NSDate *)date;

@end
