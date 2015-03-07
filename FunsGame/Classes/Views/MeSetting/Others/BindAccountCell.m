//
//  BindAccountCell.m
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "BindAccountCell.h"

#define kLeftDis 25.0f
#define kTopDis 8.0f
#define kRightDis 15.0f
#define kHeadImageHeight 20.0f
#define kBtnHeight 50.0f
#define kCellHeight 44.0f

@implementation BindAccountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    _headImage = InsertImageView(self, CGRectMake(kLeftDis, (kCellHeight - kHeadImageHeight) / 2, kHeadImageHeight, kHeadImageHeight), nil);
    
    _titleLabel = InsertLabel(self, CGRectMake(_headImage.right + 10, 0, 60, kCellHeight), NSTextAlignmentLeft, nil, kFontSize14, kFunsColorBlack, NO);
    
    _bindBtn = InsertButtonRoundedRect(self, CGRectMake(kScreenWidth - kRightDis - kBtnHeight, kTopDis, kBtnHeight, kCellHeight - kTopDis * 2), 99, @"绑定", self, nil);
    _bindBtn.layer.cornerRadius = 4;
    _bindBtn.layer.borderWidth = 1;
    _bindBtn.layer.borderColor = kColorBlue.CGColor;
    _bindBtn.clipsToBounds = YES;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
