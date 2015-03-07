//
//  StatusArrModel.h
//  FunsGame
//
//  Created by weibin on 15/3/6.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "BaseModel.h"

@interface StatusArrModel : BaseModel

@property (nonatomic, assign) int curr_page;

@property (nonatomic, assign) int total;

@property (nonatomic, assign) int total_page;

@property (nonatomic, strong) NSArray *list;

@end
