//
//  UUIDHelper.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "UUIDHelper.h"
#import "SSKeyChain.h"

static  NSString *const UUIDService = @"UUIDService";
static  NSString *const UUIDAccount = @"UUIDAccount";

@implementation UUIDHelper

+ (UUIDHelper *)sharedInstance
{
    static UUIDHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSString *)uuid
{
    NSString *str = [SSKeychain passwordForService:UUIDService account:UUIDAccount];
    
    if (str == nil || str.length == 0) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        NSString *uuid = (__bridge NSString *)CFUUIDCreateString (kCFAllocatorDefault,uuidRef);
        BOOL rs = [SSKeychain setPassword:uuid forService:UUIDService account:UUIDAccount];
        assert(rs != NO);
        return uuid;
    } else {
        return str;
    }
}

@end
