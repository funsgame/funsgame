//
//  CommonMethod.m
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod

// 设置view的边框属性
+ (void)setlayerWithView:(UIView *)view radius:(CGFloat)radius borderColor:(UIColor *)bordercolor borderWidth:(CGFloat)borderwidth
{
    if (view)
    {
        if (radius > 0.0)
        {
            view.layer.cornerRadius = radius;
            view.layer.masksToBounds = YES;
        }
        
        if (bordercolor && borderwidth > 0.0)
        {
            view.layer.borderColor = bordercolor.CGColor;
            view.layer.borderWidth = borderwidth;
        }
    }
}

// 设置自适应标签宽高
+ (void)setAutoSize:(UILabel *)label autoType:(AutoSizeType)autotype
{
    if (label)
    {
        [label setNumberOfLines:0];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        CGSize size = CGSizeMake(label.size.width, 9999.9);
        CGSize labelsize = [label.text sizeWithFont:label.font constrainedToSize:size lineBreakMode:label.lineBreakMode];
        if (AutoSizeHorizontal == autotype)
        {
            label.frame = CGRectMake(label.origin.x, label.origin.y, labelsize.width, label.height);
        }
        else if (AutoSizeAll == autotype)
        {
            label.frame = CGRectMake(label.origin.x, label.origin.y, labelsize.width, labelsize.height);
        }
    }
}

// 获取当前app版本
+ (NSString *)getAppCurrentVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *versionString = [NSString stringWithFormat:@"%@", appCurVersion];
    return versionString;
}

// 清除本地缓存文件
+ (void)clearCacheFile
{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
    for (NSString *fileName in files)
    {
        NSError *error;
        NSString *path = [cachPath stringByAppendingPathComponent:fileName];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

// 计算本地缓存文件大小
+ (double)getCacheFileSize
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    double fileSize = 0.0;
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [fileManager subpathsAtPath:cachPath];
    for (NSString *fileName in files)
    {
        NSString *path = [cachPath stringByAppendingPathComponent:fileName];
        if ([fileManager fileExistsAtPath:path])
        {
            NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
            fileSize += (double)([fileAttributes fileSize]);
        }
    }
    
    return fileSize;
}

// 图片拉升
+ (UIImage *)resizableImage:(UIImage *)image
{
    if (image)
    {
        return [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    }
    
    return nil;
}

// 计算时间差（date计算后返回秒）
+ (int)getTimeInterval:(NSDate *)currentDate sinceDate:(NSDate *)sinceDate
{
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:sinceDate];
    
    return (int)timeInterval;
}

// 是否是手机号码的字符串
+ (BOOL)isNumberString:(NSString *)string
{
    NSString *regex = @"^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    if (isMatch)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

// 刷新列表信息
static CGFloat const HeightHeadrView = 70.0;
+ (void)refreshTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message
{
    if (!dataSource || 0 == dataSource.count)
    {
        UILabel *footerlabel = InsertLabel(nil, CGRectMake(0.0, 0.0, tableview.width, HeightHeadrView * 1.5), NSTextAlignmentCenter, message, kFontSize14, kColorLightgrayContent, NO);
        footerlabel.backgroundColor = kColorWhite;
        InsertView(footerlabel, CGRectMake(0.0, footerlabel.height - kSeparatorlineHeight, footerlabel.width, kSeparatorlineHeight), kColorSeparatorline);
        
        tableview.tableFooterView = footerlabel;
    }
    else
    {
        tableview.tableFooterView = nil;
        [DataHelper setExtraCellLineHidden:tableview];
    }
    
    [tableview reloadData];
}

// 网络请求是否异常（如404，500等）
+ (BOOL)webRequestStatus:(NSString *)infoStr
{
    if ([NSString isNull:infoStr])
    {
        return NO;
    }
    
    BOOL resutl = YES;
    NSArray *array = [self getRequestErrors];
    for (NSString *error in array)
    {
        NSRange range = [infoStr rangeOfString:error];
        if (range.location != NSNotFound)
        {
            resutl = NO;
            break;
        }
    }
    
    return resutl;
}

+ (NSArray *)getRequestErrors
{
    NSMutableArray *errorsArray = [NSMutableArray array];
    [errorsArray addObject:@"400错误"]; // 错误请求，如语法错误
    [errorsArray addObject:@"401错误"]; // 请求授权失败
    [errorsArray addObject:@"402错误"]; // 保留有效ChargeTo头响应
    [errorsArray addObject:@"403错误"]; // 请求不允许
    [errorsArray addObject:@"404错误"]; // 没有发现文件、查询或URl
    [errorsArray addObject:@"405错误"]; // 用户在Request-Line字段定义的方法不允许
    [errorsArray addObject:@"406错误"]; // 根据用户发送的Accept拖，请求资源不可访问
    [errorsArray addObject:@"407错误"]; // 类似401，用户必须首先在代理服务器上得到授权
    [errorsArray addObject:@"408错误"]; // 客户端没有在用户指定的饿时间内完成请求
    [errorsArray addObject:@"409错误"]; // 对当前资源状态，请求不能完成
    [errorsArray addObject:@"410错误"]; // 服务器上不再有此资源且无进一步的参考地址
    [errorsArray addObject:@"411错误"]; // 服务器拒绝用户定义的Content-Length属性请求
    [errorsArray addObject:@"412错误"]; // 一个或多个请求头字段在当前请求中错误
    [errorsArray addObject:@"413错误"]; // 请求的资源大于服务器允许的大小
    [errorsArray addObject:@"414错误"]; // 请求的资源URL长于服务器允许的长度
    [errorsArray addObject:@"415错误"]; // 请求资源不支持请求项目格式
    [errorsArray addObject:@"416错误"]; // 请求中包含Range请求头字段，在当前请求资源范围内没有range指示值，请求也不包含If-Range请求头字段
    [errorsArray addObject:@"417错误"]; // 服务器不满足请求Expect头字段指定的期望值，如果是代理服务器，可能是下一级服务器不能满足请求
    [errorsArray addObject:@"500错误"]; // 服务器产生内部错误
    [errorsArray addObject:@"501错误"]; // 服务器不支持请求的函数
    [errorsArray addObject:@"502错误"]; // 服务器暂时不可用，有时是为了防止发生系统过载
    [errorsArray addObject:@"503错误"]; // 服务器过载或暂停维修
    [errorsArray addObject:@"504错误"]; // 关口过载，服务器使用另一个关口或服务来响应用户，等待时间设定值较长
    [errorsArray addObject:@"505错误"]; // 服务器不支持或拒绝支请求头中指定的HTTP版本
    
    return errorsArray;
}

@end
