//
//  HeadlineVC.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "HeadlineVC.h"
#import "HeadLineTableView.h"
#import "HeadlineModel.h"

#define kLeft 10.0f
#define kTopViewHeight 35.0f
#define kTableViewTag 2000

@interface HeadlineVC ()<UIScrollViewDelegate>
{
    UIView *_topView;
    UIView *_lineView;
    NSUInteger _curBtnTag;
    UIScrollView *_scrollView;
    HeadLineTableView *_tableView;
    
    int _currentPage;  // 当前页码
    NSString *_currentType;  // 当前类型
    
    NSArray *_titleDataArr;
}

@end

@implementation HeadlineVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"头条";
        _titleDataArr = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTitle];
    
    [self loadData];
}

- (void)loadTitle
{
    kSelfWeak;
    [HeadlineModel getNewsTitleSuccess:^(id data, id list) {
        
        [weakSelf loadDataFinish:data list:list];
        [weakSelf initView];
    }];
}

- (void)loadDataFinish:(StatusModel *)data list:(StatusArrModel *)list
{
    if (data.code == 0)
    {
        // 加载成功，移除加载视图
        [self loadingDataSuccess];
        
        if ([list.list isKindOfClass:[NSArray class]])
        {
            _titleDataArr = list.list;
        }
    }
    else
    {
        [self loadingDataFail];
    }
}

- (void)initView
{
    _topView = InsertView(self.view, CGRectMake(0, 0, kScreenWidth, kTopViewHeight), kColorWhite);
    
    for(int i = 0;i < _titleDataArr.count;i++)
    {
        HeadlineModel *model = _titleDataArr[i];
        NSString *title = model.name;
        UIButton *topBtn = InsertButtonRoundedRect(_topView, CGRectMake(10 + i * (kScreenWidth - kLeft * 2) /  _titleDataArr.count, 0, (kScreenWidth - kLeft * 2) /  _titleDataArr.count, kTopViewHeight), 1000 + i, title, self, @selector(titleClick:));
        [topBtn setTitleColor:UIColorHex(@"#565656") forState:UIControlStateNormal];
        [topBtn setTitleColor:UIColorHex(@"#e0433a") forState:UIControlStateDisabled];
        topBtn.backgroundColor = kColorWhite;
        topBtn.titleLabel.font = kFontSize14;
        if (i == 0)
        {
            topBtn.enabled = NO;
        }
    }
    
    _lineView = InsertView(_topView,CGRectMake(kLeft, _topView.height - 3, (kScreenWidth - kLeft * 2) /  _titleDataArr.count, 2) , UIColorHex(@"#e0433a"));
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topView.bottom, kScreenWidth, kBodyHeight)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * _titleDataArr.count, kBodyHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];

    for (int i = 0; i < _titleDataArr.count; i ++)
    {
        _tableView = [[HeadLineTableView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kBodyHeight - 90)];
        _tableView.tag = kTableViewTag + i;
        
        [_scrollView addSubview:_tableView];
        
        kSelfWeak;
        [_tableView addHeaderWithCallback:^{
            [weakSelf reflashClick];
        }];
    }
}

- (void)titleClick:(UIButton *)button
{
    button.enabled = NO;
    NSInteger index = button.tag - 1000;
    if (index != _curBtnTag )
    {
        UIButton *lastButton = (UIButton *)[self.view viewWithTag:_curBtnTag + 1000];
        lastButton.enabled = YES;
        _curBtnTag = index;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.frame = CGRectMake(button.left, _topView.height - 3, kScreenWidth / 7.0, 2);
    }];
    
    _scrollView.contentOffset = CGPointMake(kScreenWidth * index, 0);
    
    // 设置类型，并判断是否进行网络请求
    _currentPage = (int)index;
    _currentType = [self setCurrentTypeInfo:_currentPage];
    [self setCurrentTableView:_currentPage type:_currentType];
}

- (void)reflashClick
{
    [self getData:_currentType page:1];
}

- (void)loadData
{
    _currentPage = 0;
    _currentType = [self setCurrentTypeInfo:_currentPage];
    [self setCurrentTableView:_currentPage type:_currentType];
}

// 设置当前类型
- (NSString *)setCurrentTypeInfo:(int)index
{
    if (0 == index)
    {
        // 资讯
        return @"资讯";
    }
    else if (1 == index)
    {
        // 聚焦
        return @"聚焦";
    }
    else if (2 == index)
    {
        // 评测
        return @"评测";
    }
    else if (3 == index)
    {
        // 攻略
        return @"攻略";
    }
    else if (4 == index)
    {
        // 行业
        return @"行业";
    }
    else if (5 == index)
    {
        // 专栏
        return @"专栏";
    }
    
    return nil;
}

// 确定当前显示表视图
- (void)setCurrentTableView:(int)index type:(NSString *)type
{
    NSInteger tagTabelView = kTableViewTag + index;
    HeadLineTableView *tableview = (HeadLineTableView *)[self.view viewWithTag:tagTabelView];
    tableview.typeString = type;
    if (!tableview.hasloaded)
    {
        [self getData:_currentType page:1];
    }
}

#pragma mark - 网络请求

- (void)getData:(NSString *)type page:(NSInteger)page
{
    // 没有网络时不进行请求
    if (GetNetworkStatusNotReachable)
    {
        [iToast alertWithTitle:kloadfailedNotNetwork];
        return;
    }
    
    kSelfWeak;
    [HeadlineModel newsListWithNewsType:_currentType page:page success:^(id data, id list)
     {
         [weakSelf loadFinishHeadline:data list:list page:page WithNewsType:_currentType];

    }];
}

- (void)loadFinishHeadline:(StatusModel *)data list:(StatusArrModel *)list page:(NSInteger)page WithNewsType:(NSString *)type
{
    NSInteger tagTabelView = kTableViewTag + _currentPage;
    HeadLineTableView *tableview = (HeadLineTableView *)[self.view viewWithTag:tagTabelView];
    tableview.hasloaded = YES;
    tableview.typeString = type;
    
    [tableview headerEndRefreshing];
    [tableview footerEndRefreshing];
    
    kSelfWeak;
    if ([data isKindOfClass:[StatusModel class]])
    {
        StatusModel *model = (StatusModel *)data;
        if (0 == model.code)
        {
            if (page == 1)
            {
                // 首次加载
                [tableview.data removeAllObjects];
                
                if ([list.list isKindOfClass:[NSArray class]])
                {
                    tableview.data = [NSMutableArray arrayWithArray:list.list];
                }
                else
                {
                    if (list.list)
                    {
                        [tableview.data addObject:list.list];
                    }
                }
            }
            else
            {
                [tableview.data addObjectsFromArray:list.list];
            }
            
            // 加载数据成功
            [self loadingDataSuccess];
            
            // 根据数据个数判断是否需要显示上拉加载更多的控件及操作
            if (list.total > tableview.data.count)
            {
                [tableview setFooterHidden:NO];
                [tableview addFooterWithCallback:^{
                    [weakSelf loadMoreData:type];
                }];
            }
            else
            {
                [tableview setFooterHidden:YES];
            }
            
            // 刷新表视图
            [CommonMethod refreshTableView:tableview.data tabelview:tableview message:WithoutData];
        }
        else
        {
            [self loadingDataFail];
        }
    }
}

- (void)loadMoreData:(NSString *)type
{
    NSInteger tagTabelView = kTableViewTag + _currentPage;
    HeadLineTableView *tableview = (HeadLineTableView *)[self.view viewWithTag:tagTabelView];
    NSInteger page = (int)tableview.data.count / kPageSize + 1;
    [self getData:_currentType page:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
