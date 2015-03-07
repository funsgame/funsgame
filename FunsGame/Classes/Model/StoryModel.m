//
//  StoryModel.m
//  FunsGame
//
//  Created by weibin on 15/3/6.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "StoryModel.h"

@implementation StoryModel

/*
 http://123.56.107.198/api/story
 部分返回结果字段说明：
 */

+ (NSMutableDictionary*)getMapping
{
    NSMutableDictionary* mapping = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"authorId", @"author_id",
                                    @"storyId", @"id",
                                    @"authorImage", @"author_avatar",
                                    @"bgImage", @"cover_img",
                                    @"descrip", @"description",
                                    @"viewCount", @"view_count",
                                    @"commentCount", @"comment_count",
                                    @"upCount", @"up_count",
                                    [NSDate mappingWithKey:@"pulishTime" divisorForSeconds:1000],@"save_time",
                                    [NSDate mappingWithKey:@"updateTime" divisorForSeconds:1000],@"update_time",
                                    nil];
    return mapping;
}

/// 获得故事清单
+ (MKNetworkOperation *)getStoryListWithPage:(NSInteger)page success:(void (^)(id data,id list))success
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *str = [NSString stringWithFormat:@"api/story?p=%ld&ps=10",(long)page];
    
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
