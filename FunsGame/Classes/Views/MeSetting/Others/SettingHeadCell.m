//
//  SettingHeadCell.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "SettingHeadCell.h"

#define kLeftDis 20.0f
#define kTopDis 8.0f
#define kHeadImageHeight 54.0f
#define kSinaImageHeight 24.0f

@implementation SettingHeadCell

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
    _headImage = InsertImageView(self, CGRectMake(kLeftDis, kTopDis, kHeadImageHeight, kHeadImageHeight), [UIImage imageNamed:@"default_bit"]);
    
    _titleLabel = InsertLabel(self, CGRectMake(_headImage.right + 10, _headImage.top + 5, 200, 20), NSTextAlignmentLeft,@"微博或微信登录", kFontSize15, kFunsColorBlack, NO);
    
    _sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sinaBtn.frame = CGRectMake(_headImage.right + 20, _titleLabel.bottom + 5, kSinaImageHeight, kSinaImageHeight);
    _sinaBtn.tag = 10000;
    [self addSubview:_sinaBtn];
    [_sinaBtn setImage:[UIImage imageNamed:@"weibo_login"] forState:UIControlStateNormal];
        
    _lineView = InsertView(self, CGRectMake(_sinaBtn.right + 15, _sinaBtn.top + 4, 1, kSinaImageHeight - 8), UIColorHex(@"#cacaca"));
    
    _qzoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _qzoneBtn.frame = CGRectMake(_lineView.right + 15, _titleLabel.bottom + 5, kSinaImageHeight, kSinaImageHeight);
    _qzoneBtn.tag = 10001;
    [self addSubview:_qzoneBtn];
    [_qzoneBtn setImage:[UIImage imageNamed:@"qzone_login"] forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
