//
//  HeadLineCell.h
//  FunsGame
//
//  Created by weibin on 15/3/5.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadlineModel.h"

@interface HeadLineCell : UITableViewCell

// cell内容
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIImageView *praiseImage;
@property (nonatomic, strong) UILabel *praiseLabel;

/// 类型
@property (nonatomic, strong) NSString *typeString;

- (void)refreshUIWithModel:(HeadlineModel *)model;

@end
