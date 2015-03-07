//
//  JHSScrollerView.h
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JHSScrollViewDataSource;
@protocol JHSScrollViewDeleagte;

@interface JHSScrollerView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSInteger _totalPage;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign)id<JHSScrollViewDataSource>datasource;
@property (nonatomic, assign)id<JHSScrollViewDeleagte>deleagte;
@property (nonatomic, assign) BOOL isTimer; //是否显示定时
@property (nonatomic, assign) BOOL isShowPageControl;
@property (nonatomic, strong) NSTimer *timer;

- (void)reloadData;

- (void)forwardRunPage;

@end

@protocol JHSScrollViewDeleagte <NSObject>

@optional
- (void)scrollView:(JHSScrollerView *)scrollView didSelectPageAtIndex:(NSInteger)index;

@end

@protocol JHSScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfPages;

- (UIView *)pageAtIndex:(NSInteger)index;

@end
