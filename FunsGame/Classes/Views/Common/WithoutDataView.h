//
//  WithoutDataView.h
//  kinhop
//
//  Created by weibin on 15/1/21.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithoutDataView : UIView

// 初始化没有网络时，或加载失败时的视图
- (id)initWithoutDataView:(UIView *)superview;

/// 回调方法
@property (nonatomic, copy) void (^buttonClick)(void);

@end
