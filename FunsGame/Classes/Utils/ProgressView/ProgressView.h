//
//  ProgressView.h
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//  功能描述：进度状态视图

#import <UIKit/UIKit.h>

/// 视图样式
typedef enum
{
    /// 条形图
    BarMode,
    /// 环形图
    RingMode,
    /// 饼图
    PieMode
}ProgressMode;

@interface ProgressView : UIView

/// 进度状态视图初始化方法
- (id)initWithView:(UIView *)view frame:(CGRect)rect progressMode:(ProgressMode)mode;

/// 进度数（大于0，小于1）
@property (nonatomic, assign) CGFloat finishedVlaue;

/// 未完成状态颜色
@property (nonatomic, strong) UIColor *unfinishedColor;

/// 已完成状态颜色
@property (nonatomic, strong) UIColor *finishedColor;

/// 环形边框线宽（环形图有效）
@property (nonatomic, assign) CGFloat ringWidth;

/// 字体颜色（环形图有效）
@property (nonatomic, strong) UIColor *valueColor;

/// 字体大小（环形图有效）
@property (nonatomic, strong) UIFont *valueFont;

/// 中间视图颜色（环形视图有效）
@property (nonatomic, strong) UIColor *centerColor;

@end

/*
 进度状态视图使用说明
 步骤1 导入头文件
 #import "ProgressView.h"
 
 步骤2 初始化及相关属性设置
 // 环形图RingMode或饼图PieMode或条形图BarMode
 ProgressView *progressView = [[ProgressView alloc] initWithView:self.view
 frame:CGRectMake(20.0, 160.0, 50.0, 50.0)
 progressMode:PieMode];                // 1 初始化
 progressView.finishedVlaue = 0.4;                     // 2 进度值（0-1）
 progressView.unfinishedColor = [UIColor orangeColor]; // 3 已完成进度颜色
 progressView.finishedColor = [UIColor purpleColor];   // 4 未完成进度颜色
 progressView.ringWidth = 20.0;                        // 5 环形图时边框宽
 progressView.centerColor = [UIColor greenColor];      // 6 环形图时中间视图颜色
 
 */
