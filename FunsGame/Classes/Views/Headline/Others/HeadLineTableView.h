//
//  HeadLineTableView.h
//  FunsGame
//
//  Created by weibin on 15/3/5.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadLineTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *data;

/// 总数
@property (nonatomic, assign) NSInteger totalCount;

/// 是否已经加载过
@property (nonatomic, assign) BOOL hasloaded;

/// 类型
@property (nonatomic, strong) NSString *typeString;

@end
