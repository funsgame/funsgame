//
//  StoryVC.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "StoryVC.h"
#import "StoryCell.h"
#import "StoryModel.h"
#import "StoryDetailVC.h"

#define FirstPage 1

@interface StoryVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *storyTable;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NSMutableArray *netData;

@end

@implementation StoryVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"故事";
        _netData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _queue = dispatch_queue_create("queue", NULL);
    
    [self initView];
    
    [self loadData:FirstPage];
}

- (void)initView
{
//    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:nil imageName:@"search" target:self action:@selector(searchClick:)];
    
    _storyTable = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), self, self, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _storyTable.showsVerticalScrollIndicator = NO;
    _storyTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _storyTable.backgroundColor = kBackgroundColor;
    
    [DataHelper setExtraCellLineHidden:_storyTable];
    
    kSelfWeak;
    [_storyTable addHeaderWithCallback:^{
        [weakSelf refreshClick];
    }];

}

- (void)searchClick:(id)sender
{
    
}

-(void)refreshClick
{
    [self loadData:FirstPage];
}

- (void)loadData:(NSInteger)page
{
    kSelfWeak;
    [StoryModel getStoryListWithPage:page success:^(id data, id list) {
        [weakSelf loadDataFinish:data list:list page:page];

    }];
//    [StoryModel getStoryListWithPage:page success:^(id data) {
//        [weakSelf loadDataFinish:data page:page];
//    }];
}

- (void)loadDataFinish:(StatusModel *)data list:(StatusArrModel *)list page:(NSInteger)page
{
    if (data.code == 0)
    {
        // 加载成功，移除加载视图
        [self loadingDataSuccess];
        
//        NSMutableArray *arr = [NSMutableArray array];
//        if (data.result)
//        {
//            [arr addObject:data.result];
//        }
        
        if (FirstPage == page)
        {
            // 首次加载
            [_netData removeAllObjects];
            
            if ([list.list isKindOfClass:[NSArray class]])
            {
                _netData = [NSMutableArray arrayWithArray:list.list];
            }
            else
            {
                if (list.list)
                {
                    [_netData addObject:list.list];
                }
            }
        }
        else
        {
            // 加载更多
            [_netData addObjectsFromArray:list.list];
        }
        if (data.total > _netData.count)
        {
            [_storyTable setFooterHidden:NO];
            kSelfWeak;
            [_storyTable addFooterWithCallback:^{
                [weakSelf loadMoreData];
            }];
        }
        else
        {
            [_storyTable setFooterHidden:YES];
            [_storyTable footerEndRefreshing];
        }


//        for (StatusArrModel *model in arr)
//        {
//            if (FirstPage == page)
//            {
//                // 首次加载
//                [_netData removeAllObjects];
//                
//                if ([model.list isKindOfClass:[NSArray class]])
//                {
//                    _netData = [NSMutableArray arrayWithArray:model.list];
//                }
//                else
//                {
//                    if (model.list)
//                    {
//                        [_netData addObject:model.list];
//                    }
//                }
//            }
//            else
//            {
//                // 加载更多
//                [_netData addObjectsFromArray:model.list];
//            }
//        
//            if (data.total > _netData.count)
//            {
//                [_storyTable setFooterHidden:NO];
//                kSelfWeak;
//                [_storyTable addFooterWithCallback:^{
//                    [weakSelf loadMoreData];
//                }];
//            }
//            else
//            {
//                [_storyTable setFooterHidden:YES];
//                [_storyTable footerEndRefreshing];
//            }
//
//        }
    }
    else
    {
        [self loadingDataFail];
    }
    
    if (FirstPage == page && 0 != _netData.count)
    {
        // 首次加载时，滚动到顶端
        [_storyTable setContentOffset:CGPointZero animated:NO];
        [self headerEndRefreshing];
    }
    
    [_storyTable reloadData];
}

- (void)headerEndRefreshing
{
    [_storyTable headerEndRefreshing];
}

- (void)loadMoreData
{
    [self loadData:_netData.count / kPageSize + FirstPage];
    [_storyTable footerEndRefreshing];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _netData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserCell = @"story_list_cell";
    
    StoryCell *cell = (StoryCell *)[tableView dequeueReusableCellWithIdentifier:reuserCell];
    if (!cell)
    {
        cell = [[StoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    StoryModel *model = _netData[indexPath.section];
    
    [cell refreshUIWithModel:model];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    StoryModel *model = _netData[indexPath.section];
    
    StoryDetailVC *vc = [[StoryDetailVC alloc] initWithStoryId:model.storyId];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoryModel *model = _netData[indexPath.section];

    return [StoryCell getCellHeight:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
