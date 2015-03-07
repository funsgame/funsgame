//
//  SettingCell.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "SettingCell.h"

#define kLeftDis 30.0f
#define kHeadImageHeight 24.0f
#define kCellHeight 44.0f

@implementation SettingCell

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
    _titleLabel = InsertLabel(self, CGRectMake(kLeftDis, 0, 200, kCellHeight), NSTextAlignmentLeft,nil, kFontSize15, kFunsColorBlack, NO);
    
    _detailLabel = InsertLabel(self, CGRectMake(kScreenWidth - 60, 0, 50, kCellHeight), NSTextAlignmentLeft,nil, kFontSize14, kFunsColorBlack, NO);
    
    _image = InsertImageView(self, CGRectMake(kScreenWidth - kHeadImageHeight - 20, (kCellHeight - kHeadImageHeight) / 2, kHeadImageHeight, kHeadImageHeight), nil);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end