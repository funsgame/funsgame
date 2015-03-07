//
//  ProgressView.m
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  

#import "ProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"
#import "MDRadialProgressView.h"

@interface ProgressView ()
{
    ProgressMode progressMode;
    
    UIProgressView *lineProgressView;
    
    MDRadialProgressView *radialView; // 环形图或饼图
}

@end

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    if (radialView)
    {
        radialView = nil;
    }
    if (lineProgressView)
    {
        lineProgressView = nil;
    }
}

#pragma mark - 初始化

// 初始化
- (id)initWithView:(UIView *)view frame:(CGRect)rect progressMode:(ProgressMode)mode
{
    self = [super init];
    if (self)
    {
        self.frame = rect;
        progressMode = mode;
        
        if (view)
        {
            [view addSubview:self];
        }
        
        if (BarMode == mode)
        {
            self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, 20.0);
            
            // 条形进度视图2
            lineProgressView = [[UIProgressView alloc] initWithFrame:self.bounds];
            [self addSubview:lineProgressView];
            
            if (ISIOS7)
            {
                CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 3.0f);
                lineProgressView.transform = transform;
            }
        }
        else
        {
            // 环形或饼图进度视图
            radialView = [[MDRadialProgressView alloc] initWithFrame:self.bounds];
            [self addSubview:radialView];
            // 初始数值
            radialView.progressTotal = 10; // 总数
            if (PieMode == mode)
            {
                // 环形边宽(等于视图大小时，即显示为饼图)
                radialView.theme.thickness = self.frame.size.height;
            }
            // 进度视图属性设置 环形属性
            radialView.theme.sliceDividerHidden = YES;
        }
    }
    
    return self;
}

#pragma mark - set方法

// 进度数（大于0，小于1）
- (void)setFinishedVlaue:(CGFloat)finishedVlaue
{
    _finishedVlaue = finishedVlaue;
    if (progressMode == BarMode)
    {
        lineProgressView.progress = _finishedVlaue;
    }
    else
    {
        _finishedVlaue = finishedVlaue * 10.0;
        radialView.progressCounter = _finishedVlaue;
    }
}

// 未完成状态颜色
- (void)setUnfinishedColor:(UIColor *)unfinishedColor
{
    _unfinishedColor = unfinishedColor;
    if (progressMode == BarMode)
    {
        lineProgressView.trackTintColor = _unfinishedColor;
    }
    else
    {
        radialView.theme.incompletedColor = _unfinishedColor;
    }
}

// 已完成状态颜色
- (void)setFinishedColor:(UIColor *)finishedColor
{
    _finishedColor = finishedColor;
    if (progressMode == BarMode)
    {
        lineProgressView.progressTintColor = _finishedColor;
    }
    else
    {
        radialView.theme.completedColor = _finishedColor;
    }
}

// 环形边框线宽（环形图有效）
- (void)setRingWidth:(CGFloat)ringWidth
{
    if (progressMode == RingMode)
    {
        _ringWidth = ringWidth;
        if (_ringWidth < 10.0)
        {
            _ringWidth = 10.0;
        }
        else if (_ringWidth > self.frame.size.height)
        {
            _ringWidth = (self.frame.size.height / 5 * 3);
        }
        radialView.theme.thickness = _ringWidth;
    }
}

// 字体颜色（环形图有效）
- (void)setValueColor:(UIColor *)valueColor
{
    if (progressMode == RingMode)
    {
        _valueColor = valueColor;
        radialView.label.textColor = _valueColor;
    }
}

// 字体大小（环形图有效）
- (void)setValueFont:(UIFont *)valueFont
{
    if (progressMode == RingMode)
    {
        _valueFont = valueFont;
        radialView.label.font = _valueFont;
    }
}

// 中间视图颜色（环形视图有效）
- (void)setCenterColor:(UIColor *)centerColor
{
    if (progressMode == RingMode)
    {
        _centerColor = centerColor;
        radialView.theme.centerColor = _centerColor;
    }
}

@end
