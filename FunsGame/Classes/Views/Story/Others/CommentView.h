//
//  CommentView.h
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView

/// 初始化
- (id)initWithFrame:(CGRect)frame view:(UIView *)view;

/// 写评论
@property (nonatomic, strong) UIButton *writeCommentBtn;

/// 评论按钮
@property (nonatomic, strong) UIButton *commentBtn;

/// 评论数量
@property (nonatomic, strong) UILabel *commentLabel;

/// 赞按钮
@property (nonatomic, strong) UIButton *praiseBtn;

// 分享数量
@property (nonatomic, strong) UILabel *praiseLabel;

/// 分享按钮
@property (nonatomic, strong) UIButton *shareBtn;

/// 收藏按钮
@property (nonatomic, strong) UIButton *collectBtn;

@end
