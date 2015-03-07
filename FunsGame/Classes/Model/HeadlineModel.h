//
//  HeadlineModel.h
//  FunsGame
//
//  Created by weibin on 15/3/6.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "BaseModel.h"

/*
 list":[{"comment_count":0,"content_path":"Ly9kaXZbQGlkPSd0ZXh0J10=","description":"1955年，美国对中国的邻国越南发动了战争。近日一款以此为题材的游戏《越战1965（Vietnam...'65）》在苹果商店中上架。","id":52111,"img":"http://i1.shouyou.itc.cn/2015/news/2015/03/06/20150306155646.jpg","publishTime":1425571200000,"publishUser":"shouyou","saveTime":1425631747000,"site":"手游网","taskCategory":"资讯","taskName":"全球新闻-手游网","taskid":"3","title":"好事多磨 新作《越战1965》终于登陆苹果商店","up_count":0,"url":"http://news.shouyou.com/news/03062015/155329666.shtml","view_count":0}
 
 */

@interface HeadlineModel : BaseModel

@property (nonatomic, copy) NSString *name;             // 新闻列表标题
@property (nonatomic, copy) NSString *title;            // 新闻标题
@property (nonatomic, copy) NSString *nId;              // 新闻id
@property (nonatomic, copy) NSString *img;              // 新闻图片
@property (nonatomic, copy) NSString *site;             // 新闻来源
@property (nonatomic, copy) NSNumber *commentCount;     // 新闻评论数

///  新闻标题
+ (MKNetworkOperation *)getNewsTitleSuccess:(void (^)(id data,id list))success;

///  新闻列表
+ (MKNetworkOperation *)newsListWithNewsType:(NSString *)newsType
                                        page:(NSInteger)page
                                     success:(void (^)(id data,id list))success;


@end
