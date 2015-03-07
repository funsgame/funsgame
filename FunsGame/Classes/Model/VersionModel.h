//
//  VersionModel.h
//  KinHop
//
//  Created by weibin on 14/11/28.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseModel.h"

/// 强制更新（非1时不进行强制更新）
static NSInteger const ForceUpdate = 1;

@interface VersionModel : BaseModel

// 版本号
@property (nonatomic, copy) NSString *versionNo;
// 版本名
@property (nonatomic, copy) NSString *versionName;
// 下载地址(appstore下载地址)
@property (nonatomic, copy) NSString *downloadURL;
// 文件大小
@property (nonatomic, copy) NSString *fileSize;
// 是否自动更新
@property (nonatomic, copy) NSString *isForceUpdate;
// 更新信息(更新得功能描述)
@property (nonatomic, copy) NSString *updateInfo;
// 更新时间
@property (nonatomic, copy) NSString *uploadDate;

// 版本更新
+ (void)webVersionUpgradeWithTarget:(id)target
                            success:(void (^)(id data))success;
@end
