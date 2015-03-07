//
//  GuideVC.m
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "GuideVC.h"

#define kCount 4
#define new_feature_pagecontrol_point @"new_feature_pagecontrol_point"
#define new_feature_pagecontrol_checked_point @"new_feature_pagecontrol_checked_point"
#define new_feature_finish_button     @"new_feature_finish_button"
#define new_feature_background        @"new_feature_background.png"

@interface GuideVC () <UIGestureRecognizerDelegate>
{
    UIPageControl *_pageControl;
    UIButton      *_show;
    UIScrollView  *_scrollView;
}

@end

@implementation GuideVC

#pragma mark 自定义控制器的view
- (void)loadView
{
    [super loadView];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.image = [UIImage imageWithName:new_feature_background];
    imageView.userInteractionEnabled = YES;
    self.view = imageView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)initView
{
    CGSize viewSize = self.view.bounds.size;
    
    // 1.加载UIScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = self.view.bounds;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(kCount * viewSize.width, 0);
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    //    _scrollView.directionalLockEnabled = YES;
    [self.view addSubview:_scrollView];
    
    // 2.添加UIImageView
    for (int i = 0; i<kCount; i++) {
        [self addImageViewAtIndex:i inView:_scrollView];
    }
    
    // 3.加载UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    //    pageControl.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.95);
    pageControl.frame = CGRectMake(0, kAllHeight - 214/2 - 20, kScreenWidth, 0);
    pageControl.numberOfPages = kCount;
    pageControl.pageIndicatorTintColor = UIColorRGB(250, 157, 135);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    
    if (pageControl.numberOfPages <= 1)
    {
        pageControl.hidden = YES;
    }
    else
    {
        pageControl.hidden = NO;
    }
    
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
    
    
    UIImageView *buttonBack = InsertImageView(self.view, CGRectMake(0, kAllHeight - 214/2, kScreenWidth, 214/2),[UIImage imageWithName:@"newFeature_button_back"]);
    
    InsertImageButtonWithTitle(buttonBack, CGRectMake((kScreenWidth - 160)/2, 25, 160, 44), 1, kImg_Common_bt_normal, kImg_Common_bt_normal, @"立即体验", UIEdgeInsetsMake(5, 5, 5, 5), kFontSize18, UIColorHex(@"ffffff"), self, @selector(start));
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 添加scrollview里面的imageview

- (void)addImageViewAtIndex:(int)index inView:(UIView *)view
{
    CGSize viewSize = self.view.frame.size;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = (CGRect){{index * viewSize.width, 0} , viewSize};
    NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
    
    if (iPhone5)
    {
        name = [NSString stringWithFormat:@"new_feature_50%d", index + 1];
    }
    
    imageView.image = [UIImage imageWithName:name];
    
    [view addSubview:imageView];
}

- (void)start
{
    if (_startBlock) {
        _startBlock();
    }
}
#pragma mark 滚动代理
#pragma mark 减速完毕就会调用（scrollview静止）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    _pageControl.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (_pageControl.currentPage>2) {
        _scrollView.bounces = YES;
    }else{
        _scrollView.bounces = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ((kCount-1)*kScreenWidth<scrollView.contentOffset.x) {
        [self start];
    }
}

@end
