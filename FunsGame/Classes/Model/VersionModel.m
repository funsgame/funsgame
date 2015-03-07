//
//  VersionModel.m
//  KinHop
//
//  Created by weibin on 14/11/28.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "VersionModel.h"

@implementation VersionModel

// 版本更新
+ (void)webVersionUpgradeWithTarget:(id)target
                            success:(void (^)(id data))success
{
    GetMutableDic;
    DicObjectSet(@"1", @"appType");
    
//    [self postDataResponsePath:@"webVersionUpgrade" params:dic networkHUD:NetworkHUDBackground target:target onCompletion:^(id data) {
//        StatusModel *model = [self statusModelFromJSONObject:data];
//        if (success)
//        {
//            success(model);
//        }
//    }];
}

@end
