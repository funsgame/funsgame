//
//  JHSScrollerView.m
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "JHSScrollerView.h"

#define JHSTIME 5

@interface JHSScrollerView()
{
    CFRunLoopRef _myRunLoop;//获取当前线程
}

@end

@implementation JHSScrollerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    //scrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
    
    //pageControl
    CGRect  rect = self.bounds;
    rect.origin.y = rect.size.height - 22;
    rect.size.height = 15;
    _pageControl = [[UIPageControl alloc]initWithFrame:rect];
    _isShowPageControl = YES;
    //    _pageControl.layer.cornerRadius = 9;
    _pageControl.backgroundColor = [UIColor clearColor];
    //    _pageControl.alpha = 0.7;
    _pageControl.userInteractionEnabled = NO;
    [self addSubview:_pageControl];
    _curPage = 0;
}

//开启定时器
- (void)setIsTimer:(BOOL)isTimer
{
    _isTimer = isTimer;
    
    if (isTimer)
    {
        [self stopTimer];
        kSelfWeak;
        DLog(@"=========================异步创建定时器");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            _myRunLoop = CFRunLoopGetCurrent();
            _timer = [NSTimer timerWithTimeInterval:JHSTIME target:weakSelf selector:@selector(runTimePage) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
        });
    }
    else
    {
        [self stopTimer];
    }
    
}

//停止定时器
- (void)stopTimer
{
    //停止掉子线程中runloop
    if (_myRunLoop)
    {
        CFRunLoopStop(_myRunLoop);
        _myRunLoop = nil;
    }
    
    //返回上个视图
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
        DLog(@"定时器销毁");
    }
}

- (void)setIsShowPageControl:(BOOL)isShowPageControl
{
    _pageControl.hidden = !isShowPageControl;
}

- (void)setDatasource:(id<JHSScrollViewDataSource>)datasource
{
    _datasource = datasource;
    
    [self reloadData];
}

- (void)reloadData
{
    _totalPage = [_datasource numberOfPages];
    
    if (_totalPage == 0)
    {
        return;
    }
    
    _pageControl.numberOfPages = _totalPage;
    
    [self loadData];
}

- (void)loadData
{
    _pageControl.currentPage = _curPage;
    //从scrollview 上移除所有的subview
    if (_scrollView.subviews.count != 0)
    {
        [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        if ([v isKindOfClass:[UIImageView class]])
        {
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
        }
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)getDisplayImagesWithCurpage:(NSInteger)page
{
    NSInteger pre = [self validPageValue:_curPage - 1];
    NSInteger last = [self validPageValue:_curPage + 1];
    
    if (!_curViews)
    {
        _curViews = [[NSMutableArray alloc]init];
    }
    [_curViews removeAllObjects];
    
    if (_datasource)
    {
        [_curViews addObject:[_datasource pageAtIndex:pre]];
        [_curViews addObject:[_datasource pageAtIndex:page]];
        [_curViews addObject:[_datasource pageAtIndex:last]];
    }
}

- (NSInteger)validPageValue:(NSInteger)value
{
    if (value == -1)
    {
        value = _totalPage -1;
    }
    if (value == _totalPage)
    {
        value = 0;
    }
    return value;
}

#pragma mark - TapGestureRecognizer

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if (_deleagte && [_deleagte respondsToSelector:@selector(scrollView:didSelectPageAtIndex:)])
    {
        [_deleagte scrollView:self didSelectPageAtIndex:_curPage];
    }
}

#pragma mark - UIScrollViewDelegate

#if 1
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 暂停计时
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 启动计时
    [_timer setFireDate:[NSDate dateWithTimeInterval:JHSTIME sinceDate:[NSDate date]]];
}
#endif

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    int x = aScrollView.contentOffset.x;
    
#if 0  // 没什么作用
    //滑动一张表将定时停止 重新开启定时
    if (_isShowPageControl)
    {
        if (_isTimer)
        {
            [_timer invalidate];
            _timer = nil;
        }
        _isTimer = YES;
    }
#endif
    
    //往下翻一张
    if (x >= (2 * self.frame.size.width))
    {
        _curPage = [self validPageValue:_curPage + 1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0)
    {
        _curPage = [self validPageValue:_curPage - 1];
        [self loadData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    //    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
}

#pragma mark - 定时循环

- (void)runTimePage
{
    DLog(@"_curPage=============%ld",(long)_curPage);
#if 0
    NSInteger page = _pageControl.currentPage; // 获取当前的page
    _curPage = [self validPageValue:page + 1];
    [self loadData];
#else
    _curPage = [self validPageValue:_curPage];
    [self loadData];
    [_scrollView setContentOffset:CGPointMake(2 * _scrollView.frame.size.width, 0) animated:YES];
#endif
}

//向前滑动一下
- (void)forwardRunPage
{
    if (!_isShowPageControl)
    {
        NSInteger page = _pageControl.currentPage; // 获取当前的page
        //        DLog(@"第%d个页面",page);
        [iToast alertWithTitle:[NSString stringWithFormat:@"第%d个页面",(int)page + 1]];
        _curPage = [self validPageValue:page + 1];
        [self loadData];
    }
}

@end
