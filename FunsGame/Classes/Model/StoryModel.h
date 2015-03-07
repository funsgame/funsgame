//
//  StoryModel.h
//  FunsGame
//
//  Created by weibin on 15/3/6.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

/*
 {"code":"0","msg":"","result":{"curr_page":"1","list":[{"author":"把酒临风无菱夏","author_avatar":"","author_id":1,"comment_count":5,"content":"","cover_img":"http://123.56.107.198/resource/img/default.png","description":" 上篇：蜀山之道  　　 回首仙剑，不觉竟已去十多年，小时懵懂无知，还明白不得其中味道，如今重玩，把对话都细细看遍，觉得甚有意味，不似现在速食游戏的浅白，仙剑里的小细节皆是匠心独运，感...","id":2,"save_time":1421381140000,"title":"不识情愁枉少年","up_count":1,"update_time":1421974156000,"view_count":166},{"author":"把酒临风无菱夏","author_avatar":"","author_id":1,"comment_count":0,"content":"","cover_img":"http://123.56.107.198/resource/img/default.png","description":"测试内容...","id":1,"save_time":1421203308000,"title":"测试","up_count":2,"update_time":1421974293000,"view_count":49}],"total":"2","total_page":"1"}}
 */

#import "BaseModel.h"

@interface StoryModel : BaseModel

@property (nonatomic, copy) NSString *authorId;          // 故事作者id

@property (nonatomic, copy) NSString *storyId;           // 故事id

@property (nonatomic, copy) NSString *author;            // 故事作者

@property (nonatomic, copy) NSString *authorImage;       // 故事作者头像

@property (nonatomic, copy) NSString *title;             // 故事标题

@property (nonatomic, copy) NSString *bgImage;           // 故事背景

@property (nonatomic, copy) NSString *descrip;           // 故事内容

@property (nonatomic, copy) NSString *viewCount;         // 故事浏览数

@property (nonatomic, copy) NSString *commentCount;      // 故事评论数

@property (nonatomic, copy) NSString *upCount;           

@property (nonatomic, strong) NSDate *pulishTime;

@property (nonatomic, strong) NSDate *updateTime;

/// 获得故事清单
+ (MKNetworkOperation *)getStoryListWithPage:(NSInteger)page success:(void (^)(id data,id list))success;

@end
