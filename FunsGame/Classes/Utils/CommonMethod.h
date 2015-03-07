//
//  CommonMethod.h
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 自适应大小类型（宽高，或宽）
typedef enum
{
    /// 自适应宽
    AutoSizeHorizontal,
    /// 自适应宽高
    AutoSizeAll
}AutoSizeType;

@interface CommonMethod : NSObject

/// 设置view的边框属性
+ (void)setlayerWithView:(UIView *)view radius:(CGFloat)radius borderColor:(UIColor *)bordercolor borderWidth:(CGFloat)borderwidth;

/// 设置自适应标签宽高
+ (void)setAutoSize:(UILabel *)label autoType:(AutoSizeType)type;

/// 获取当前app版本
+ (NSString *)getAppCurrentVersion;

/// 清除本地缓存文件
+ (void)clearCacheFile;

/// 计算本地缓存文件大小
+ (double)getCacheFileSize;

/// 图片拉升
+ (UIImage *)resizableImage:(UIImage *)image;

/// 计算时间差（date计算后返回秒）
+ (int)getTimeInterval:(NSDate *)currentDate sinceDate:(NSDate *)sinceDate;

/// 是否是手机号码的字符串
+ (BOOL)isNumberString:(NSString *)string;

/// 刷新列表信息
+ (void)refreshTableView:(NSArray *)dataSource tabelview:(UITableView *)tableview message:(NSString *)message;

/// 网络请求是否异常（如404，500等）
+ (BOOL)webRequestStatus:(NSString *)infoStr;

@end
