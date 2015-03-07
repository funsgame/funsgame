//
//  LoadingAndRefreshView.h
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadingAndRefreshViewDelegate <NSObject>

//点击刷新
- (void)refreshClick;

@end

@interface LoadingAndRefreshView : UIView

@property(assign,nonatomic) BOOL isLoading;
@property(weak,  nonatomic) id<LoadingAndRefreshViewDelegate>delegate;
@property(copy, nonatomic) void (^refleshBlock) (void);

- (void)setLoadingState;
- (void)setSuccessState;
- (void)setFailedState;

@end
