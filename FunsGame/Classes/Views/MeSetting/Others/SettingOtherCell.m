//
//  SettingOtherCell.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "SettingOtherCell.h"

#define kLeftDis 25.0f
#define kRightDis 20.0f
#define kHeadImageHeight 20.0f
#define kPointImageHeight 7.0f
#define kCellHeight 44.0f

@implementation SettingOtherCell

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
    
    _titleLabel = InsertLabel(self, CGRectMake(_headImage.right + 16, 0, 40, kCellHeight), NSTextAlignmentLeft, nil, kFontSize15, kFunsColorBlack, NO);
    
    _detailLabel = InsertLabel(self, CGRectMake(kScreenWidth - 40, 0, 20, 20), NSTextAlignmentRight, nil, kFontSize15, kFunsColorBlack, NO);

    _pointImage = InsertImageView(self, CGRectMake(kScreenWidth - kRightDis - kPointImageHeight, (kCellHeight - kPointImageHeight) / 2, kPointImageHeight, kPointImageHeight), [UIImage imageNamed:@"points"]);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
