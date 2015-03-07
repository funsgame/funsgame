//
//  UUIDHelper.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能:唯一UUID

#import "BaseModel.h"

@interface UUIDHelper : BaseModel

+ (UUIDHelper *)sharedInstance;

@property (nonatomic, strong, readonly) NSString *uuid;

@end
