//
//  HeadlineModel.m
//  FunsGame
//
//  Created by weibin on 15/3/6.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "HeadlineModel.h"

@implementation HeadlineModel

+ (NSMutableDictionary*)getMapping
{
    NSMutableDictionary* mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"nId", @"id",
                                    @"title", @"description",
                                    @"commentCount", @"comment_count",
                                    nil];
    return mapping;
}

+ (MKNetworkOperation *)getNewsTitleSuccess:(void (^)(id data,id list))success
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    return [self getDataResponsePath:@"api/category"
                              params:params
                          networkHUD:NetworkHUDBackground
                        onCompletion:^(id data)
            {
                StatusModel *model = [StatusArrModel statusModelFromJSONObject:data];
                id data2 = [data objectForKey:@"result"];
                StatusArrModel *statusArrModel = [self statusArrModelFromJSONObject:data2];
                if (success) success(model,statusArrModel);
            }];
}

+ (MKNetworkOperation *)newsListWithNewsType:(NSString *)newsType
                                        page:(NSInteger)page
                                     success:(void (^)(id data,id list))success
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    NSString *temp = [NSString hexStringFromString:newsType];
    NSString *str = [NSString stringWithFormat:@"api/list?c=%@",temp];
    
    
    return [self getDataResponsePath:str
                              params:params
                          networkHUD:NetworkHUDBackground
                        onCompletion:^(id data)
            {
                StatusModel *model = [StatusArrModel statusModelFromJSONObject:data];
                id data2 = [data objectForKey:@"result"];
                StatusArrModel *statusArrModel = [self statusArrModelFromJSONObject:data2];
                if (success) success(model,statusArrModel);
            }];
}

@end
