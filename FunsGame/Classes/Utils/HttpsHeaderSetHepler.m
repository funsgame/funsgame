//
//  HttpsHeaderSetHepler.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "HttpsHeaderSetHepler.h"
#import "UUIDHelper.h"
//#import "RSA.h"
#define kKey @"1C7KETwwwW5gfz8VCCz0Lb9SeYRaBnzENvR7cLu9jczqEvadQZfuMTQKxco6WR56"

@interface HttpsHeaderSetHepler()

@property (nonatomic, strong) NSDictionary *headEncryptInfo;

@end

@implementation HttpsHeaderSetHepler

+ (HttpsHeaderSetHepler *)sharedInstance
{
    static HttpsHeaderSetHepler *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        assert(instance != nil);
    });
    return instance;
}

// 获取头加密信息
- (NSDictionary *)getHeaderEncryptInfoWithAPIPath:(NSString *)APIPath
{
    if (self.headEncryptInfo == nil) {
        self.headEncryptInfo = [self filtrateForHttpHeaderWithPath:APIPath];
    }
    
    return self.headEncryptInfo;
}

// 清除
- (void)clearHeaderEncryptInfo
{
    self.headEncryptInfo = nil;
}

// 不需要设置头部的接口
#define kPathsArray  @[@"login",@"register",@"checkItem",@"checkAuthCode", @"sendSMS",@"resetNewMobilePassword",@"sendMobileCode", @"getLoanDetailData", @"getLoanAppList",@"getLoanAppDetailData",@"loanApply",@"getSysParamAndPic"]
- (NSDictionary *)filtrateForHttpHeaderWithPath:(NSString *)path
{
//    NSMutableSet *pathSet = [[NSMutableSet alloc] initWithArray:kPathsArray];
//    // 如果不需要设置直接返回
//    if ([pathSet containsObject:path])
//    {
//        return nil;
//    }
    
    NSMutableDictionary *headParams = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *timestampStr = [NSString stringWithFormat:@"%ld", (long)([[NSDate date] timeIntervalSince1970])];
    
    NSString *apiKeyStr = [NSString stringWithFormat:@"%@-%@-%@",path,timestampStr,kKey];
    
//    NSString *encryptStr = [[RSA shareInstance] encryptWithString:apiKeyStr];
    NSString *md5 = [DataHelper getMd5_32Bit_String:apiKeyStr uppercase:YES];
    
    [headParams setObject:md5 forKey:@"apiKey"];
    
    return headParams;
}


@end
