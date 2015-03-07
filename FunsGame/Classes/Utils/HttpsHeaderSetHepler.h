//
//  HttpsHeaderSetHepler.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseModel.h"

@interface HttpsHeaderSetHepler : BaseModel

+ (HttpsHeaderSetHepler *)sharedInstance;

// 获取头加密信息
- (NSDictionary *)getHeaderEncryptInfoWithAPIPath:(NSString *)APIPath;

// 清除
- (void)clearHeaderEncryptInfo;

@end
