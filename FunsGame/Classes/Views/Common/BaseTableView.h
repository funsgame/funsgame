//
//  BaseTableView.h
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AllClassButtonBlock)(UIButton *);

@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *data;//提供数据

@property (nonatomic, assign) BOOL isDelete; //是否删除

@property (nonatomic, assign) BOOL isShowHeadView;


@property (nonatomic, assign) int tag;//0 详情页 1 聊天页 2 支付页

@property (nonatomic ,copy) AllClassButtonBlock allClassButtonBlock;//分类Button

@end
