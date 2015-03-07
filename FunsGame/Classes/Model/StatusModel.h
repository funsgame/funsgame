//
//  StatusModel.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseModel.h"

@interface StatusModel : BaseModel

@property (nonatomic, assign) int code;            // 状态码
@property (nonatomic, strong) NSString *msg;       // 信息
@property (nonatomic, strong) id result;           //结果  对应的Model
@property (nonatomic, assign) int total;

@end
