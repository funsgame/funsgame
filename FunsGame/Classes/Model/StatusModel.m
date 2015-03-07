//
//  StatusModel.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "StatusModel.h"
#import "StatusArrModel.h"

@implementation StatusModel

+ (NSMutableDictionary*)getMapping
{
    NSMutableDictionary *maping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [StatusArrModel mappingWithKey:@"result" mapping:nil], @"result",
                                   nil];
    return maping;
}

@end
