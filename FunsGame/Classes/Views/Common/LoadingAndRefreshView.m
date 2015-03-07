//
//  LoadingAndRefreshView.m
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "LoadingAndRefreshView.h"

static CGFloat const SizeImageWidth = 501.0 / 2;
static CGFloat const SizeImageHeight = 289.0 / 2;

@interface LoadingAndRefreshView()

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView; //加载指示器

@end

@implementation LoadingAndRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
    }
    return self;
}

- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = frame;
    self.frame = rect;
    
    self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SizeImageWidth, SizeImageHeight)];
    self.imageview.center = CGPointMake(kScreenWidth / 2.0, (kBodyHeight - 44 - 30) / 2.0);
    [self addSubview:self.imageview];
    self.imageview.contentMode = UIViewContentModeScaleAspectFit;
    self.imageview.image = [UIImage imageLocalizedNamed:@"without_network_icon"];
    self.imageview.backgroundColor = [UIColor clearColor];
    
    // 重新加载按钮
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.button];
    self.button.frame = CGRectMake(0.0, 0.0, SizeImageWidth, SizeImageHeight);
    self.button.center = CGPointMake(kScreenWidth / 2.0, (kBodyHeight - 44 - 30) / 2.0);
    [self.button addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    self.button.backgroundColor = kColorClear;
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    _indicatorView.center = CGPointMake(kScreenWidth / 2,kBodyHeight / 2);
    [self addSubview:_indicatorView];
}

//刷新
-(void)refreshClick
{
    
    [self setLoadingState];
    
    if (_refleshBlock) {
        _refleshBlock();
    }
    if (_delegate && [_delegate respondsToSelector:@selector(refreshClick)]) {
        [_delegate refreshClick];
    }
}

- (void)setLoadingState
{
    _imageview.hidden=YES;
    _button.hidden=YES;
    
    _indicatorView.hidden = NO;
    [_indicatorView startAnimating];
}

- (void)setSuccessState{
    [self removeFromSuperview];
}

- (void)setFailedState
{
    _imageview.hidden=NO;
    _button.hidden=NO;
    
    _indicatorView.hidden = YES;
    [_indicatorView stopAnimating];
}

@end
