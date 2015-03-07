//
//  TimeUtil.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "TimeUtil.h"

@implementation TimeUtil

+ (NSString*)getTimeStr:(long) createdAt
{
    // Calculate distance time string
    //
    NSString *timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, createdAt);
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "second ago" : "seconds ago"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "minute ago" : "minutes ago"];
    }
    else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "hour ago" : "hours ago"];
    }
    else if (distance < 60 * 60 * 24 * 7) {
        distance = distance / 60 / 60 / 24;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "day ago" : "days ago"];
    }
    else if (distance < 60 * 60 * 24 * 7 * 4) {
        distance = distance / 60 / 60 / 24 / 7;
        timestamp = [NSString stringWithFormat:@"%d %s", distance, (distance == 1) ? "week ago" : "weeks ago"];
    }
    else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createdAt];
        timestamp = [dateFormatter stringFromDate:date];
    }
    return timestamp;
}

+ (NSString*)getFullTimeStr:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld",(long)[component year],(long)[component month],(long)[component day],(long)[component hour],(long)[component minute]];
    return string;
}

+ (NSString*)getMDStr:(long long)time
{
    
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    NSString * string=[NSString stringWithFormat:@"%ld月%ld日",(long)[component month],(long)[component day]];
    return string;
}

+(NSDateComponents*) getComponent:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    return component;
}


+(NSString*) getTimeStrStyle1:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
    
    NSString*string=nil;
    
    long long now=[today timeIntervalSince1970];
    
    long distance=(long)(now-time);
    if(distance<60)
        string=@"刚刚";
    else if(distance<60*60)
        string=[NSString stringWithFormat:@"%ld 分钟前",distance/60];
    else if(distance<60*60*24)
        string=[NSString stringWithFormat:@"%ld 小时前",distance/60/60];
    else if(distance<60*60*24*7)
        string=[NSString stringWithFormat:@"%ld 天前",distance/60/60/24];
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d月%d日",month,day];
    else
        string=[NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    
    return string;
    
}
+(NSString*) getTimeStrStyle2:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    int week=(int)[component week];
    int weekday=(int)[component weekday];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    int t_week=(int)[component week];
    
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        if(hour<6&&hour>=0)
            string=[NSString stringWithFormat:@"凌晨 %d:%02d",hour,minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %d:%02d",hour,minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %d:%02d",hour-12,minute];
        else
            string=[NSString stringWithFormat:@"晚上 %d:%02d",hour-12,minute];
    }
    else if(year==t_year&&week==t_week)
    {
        NSString * daystr=nil;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"周%@ %d:%02d",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d月%d日",month,day];
    else
        string=[NSString stringWithFormat:@"%d年%d月%d日",year,month,day];
    
    return string;
}

+(NSString*) getTimeStrStyle3:(long long)time
{
    NSDate * date=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    
    NSString*string=nil;
    if(year==t_year&&month==t_month&&day==t_day)
    {
        if(hour<6&&hour>=0)
            string=[NSString stringWithFormat:@"凌晨 %d:%02d",hour,minute];
        else if(hour>=6&&hour<12)
            string=[NSString stringWithFormat:@"上午 %d:%02d",hour,minute];
        else if(hour>=12&&hour<18)
            string=[NSString stringWithFormat:@"下午 %d:%02d",hour-12,minute];
        else
            string=[NSString stringWithFormat:@"晚上 %d:%02d",hour-12,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d-%d %d:%02d",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%02d-%d-%d %d:%02d",year%100,month,day,hour,minute];
    
    return string;
}

#pragma mark - dataFormat
+ (NSString*)getDate:(NSDate*)date withFormat:(NSString*)dataFormat{
    if (date == nil) {
        date = [[NSDate alloc] init];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dataFormat];
    NSString *theDate = [formatter stringFromDate:date];
    return theDate;
}

+ (NSDate*)getDateWithDateString:(NSString*)date dateFormat:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat dateFromString:date];
}

+ (NSString*)getDefaultDateFormat:(NSDate*)date{
    NSDate * today = [NSDate date];
    NSDate * refDate = date;
    
    NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
    NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
    
    if ([refDateString isEqualToString:todayString])
    {
        return [self getDate:date withFormat:kDateFormatTime];
    }else if([yearString isEqualToString:refYearString]){
        return [self getDate:date withFormat:kDateFormat_MdHms];
    }else{
        return [self getDate:date withFormat:kDateFormatDefault];
    }
}

+ (NSString*)getMessageDateFormat:(NSDate*)date{
    NSDate * today = [NSDate date];
    NSDate * refDate = date;
    
    NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
    NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
    
    if ([refDateString isEqualToString:todayString])
    {
        return [self getDate:date withFormat:kDateFormat_Hm];
    }else if([yearString isEqualToString:refYearString]){
        return [self getDate:date withFormat:kDateFormat_Md];
    }else{
        return [self getDate:date withFormat:kDateFormat_yyMd];
    }
}

+ (NSString*)getChatDateFormat:(NSDate*)date{
    //获取系统是24小时制或者12小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    //hasAMPM==TURE为12小时制，否则为24小时制
    if (hasAMPM) {
        return [self getTimeStrStyle3:date.timeIntervalSince1970];
    }else{
        NSDate * today = [NSDate date];
        NSDate * refDate = date;
        
        NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
        NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
        
        NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
        NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
        
        if ([refDateString isEqualToString:todayString])
        {
            return [self getDate:date withFormat:kDateFormat_Hm];
        }else if([yearString isEqualToString:refYearString]){
            return [self getDate:date withFormat:kDateFormat_MdHm];
        }else{
            return [self getDate:date withFormat:kDateFormat_yyMdHm];
        }
    }
    
}

+ (NSString*)getFriendsCircleDateFormat:(NSDate*)date{
    NSDate * today = [NSDate date];
    NSDate * refDate = date;
    
    NSString * todayString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString * yearString = [[self getDate:today withFormat:kDateFormatDefault] substringToIndex:4];
    NSString * refYearString = [[self getDate:refDate withFormat:kDateFormatDefault] substringToIndex:4];
    
    if ([refDateString isEqualToString:todayString])
    {
        return @"今天";
    }else if([yearString isEqualToString:refYearString]){
        return [self getDate:date withFormat:kDateFormat_Md];
    }else{
        return [self getDate:date withFormat:kDateFormat_yyMd];
    }
}

+ (NSString*)getTimeStrStyle4:(NSDate *)date
{
    NSCalendar * calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents * component=[calendar components:unitFlags fromDate:date];
    
    int year=(int)[component year];
    int month=(int)[component month];
    int day=(int)[component day];
    int hour=(int)[component hour];
    int minute=(int)[component minute];
    int weekday=(int)[component weekday];
    
    NSDate * today=[NSDate date];
    component=[calendar components:unitFlags fromDate:today];
    int t_year=(int)[component year];
    int t_month=(int)[component month];
    int t_day=(int)[component day];
    
    
    NSDate * yesterday = [NSDate dateWithTimeIntervalSinceNow:-86400];
    
    NSString * todayString = [[self getDate:date withFormat:kDateFormatDefault] substringToIndex:10];
    NSString * refDateString = [[self getDate:yesterday withFormat:kDateFormatDefault] substringToIndex:10];
    
    NSString *noTimeStr = [self getDate:date withFormat:kDateFormat_yMd];
    NSDate *noTime = [self getDateWithDateString:noTimeStr dateFormat:kDateFormat_yMd];
    
    long long now=[today timeIntervalSince1970];
    long distance=(long)(now-[noTime timeIntervalSince1970]);
    
    
    NSString*string=[NSString stringWithFormat:@"%d:%02d",hour,minute];
    if(year==t_year&&month==t_month&&day==t_day){}
    else if([todayString isEqualToString:refDateString])
        string=[NSString stringWithFormat:@"昨天 %d:%02d",hour,minute];
    else if(distance<60*60*24*7)
    {
        NSString *daystr;
        switch (weekday) {
            case 1:
                daystr=@"日";
                break;
            case 2:
                daystr=@"一";
                break;
            case 3:
                daystr=@"二";
                break;
            case 4:
                daystr=@"三";
                break;
            case 5:
                daystr=@"四";
                break;
            case 6:
                daystr=@"五";
                break;
            case 7:
                daystr=@"六";
                break;
            default:
                break;
        }
        string=[NSString stringWithFormat:@"星期%@ %d:%02d",daystr,hour,minute];
    }
    else if(year==t_year)
        string=[NSString stringWithFormat:@"%d-%d %d:%02d",month,day,hour,minute];
    else
        string=[NSString stringWithFormat:@"%02d-%d-%d %d:%02d",year%100,month,day,hour,minute];
    
    return string;
}

+(NSString *)getYearAndMonthStyle:(NSDate *)date count:(int)count
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents * component = [calendar components:unitFlags fromDate:date];
    
    int year;
    if((int)([component month] + count) > 12)
        year = (int)([component year] + 1);
    else
        year=(int)[component year];
    
    int month=(int)([component month] + count) % 12;
//    int day=(int)[component day];
    NSString *temp =[NSString stringWithFormat:@"%d-%d",year,month];
    
    return temp;
}

+(NSString *)getYearAndMonthAndDayStyle:(NSDate *)date
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents * component = [calendar components:unitFlags fromDate:date];
    
    int year = (int)[component year];
    int month = (int)[component month];
    int day = (int)[component day];

    NSString *temp =[NSString stringWithFormat:@"%d-%d-%d",year,month,day];
    
    return temp;
}

@end
