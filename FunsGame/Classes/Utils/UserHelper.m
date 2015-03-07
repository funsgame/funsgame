//
//  UserHelper.m
//  FunsGame
//
//  Created by weibin on 15/3/5.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper

+ (UserType)autoLoginStatus
{
    NSString *status = [SSKeychain passwordForService:kSSToolkitTestsServiceName account:@"AutoLoginStatus"];
    if (status) {
        return [status integerValue];
    }
    return UserTypeNormal;
}

@end
