//
//  StoryCell.m
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "StoryCell.h"

#define kLeftDis 10.0f
#define kTopDis 10.0f
#define kHeadImageHeight 44.0f
#define kBgImageHeight 200.0f

@implementation StoryCell

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
    _bgImage = InsertImageView(self, CGRectMake(0, 0, kScreenWidth, kBgImageHeight), [UIImage imageNamed:@"default_bg"]);

    UIView *topView = InsertView(self, CGRectMake(0, kTopDis - 5, kScreenWidth, kHeadImageHeight + 20), kFunsColorBlack);
    topView.alpha = 0.05;
    
    _headImage = InsertImageView(self, CGRectMake(kLeftDis, kTopDis + 5, kHeadImageHeight, kHeadImageHeight), [UIImage imageNamed:@"default_small"]);
    
    _nameLabel = InsertLabel(self, CGRectMake(_headImage.right + 10, _headImage.top + 12, 200, 20), NSTextAlignmentLeft,@"匠人", kFontSize16, kColorWhite, NO);
    
    UIView *bottomView = InsertView(self, CGRectMake(0, kBgImageHeight - 35, kScreenWidth, 30), kFunsColorBlack);
    bottomView.alpha = 0.05;

    _titleLabel = InsertLabel(self, CGRectMake(kLeftDis, kBgImageHeight - 30, kScreenWidth - 20, 20), NSTextAlignmentLeft,@"匠asdadasdasd人", kFontSize16, kColorWhite, NO);
    
    _descripLabel = InsertLabel(self, CGRectMake(kLeftDis, kBgImageHeight + 10, kScreenWidth - 20, 20), NSTextAlignmentLeft,@"匠asdasdasdasdasdasdasd人", kFontSize15, kFunsColorBlack, NO);
}

- (void)refreshUIWithModel:(StoryModel *)model
{
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.authorImage] placeholderImage:[UIImage imageLocalizedNamed:@"default_small"]];
    
    _nameLabel.text = model.author;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.bgImage] placeholderImage:[UIImage imageLocalizedNamed:@"default_bg"]];
    
    _titleLabel.text = model.title;
    
    _descripLabel.text = model.descrip;
    
    CGFloat descripHeight = [[self class] getCellHeight:model] - 220;
    
    if(descripHeight > 60)
        descripHeight = 60;
    
    _descripLabel.frame = CGRectMake(kLeftDis, kBgImageHeight + 10, kScreenWidth - 20, descripHeight);
    _descripLabel.numberOfLines = 0;
}

+ (CGFloat)getCellHeight:(StoryModel *)model
{
    CGFloat height;
    
    if ([NSString isNull:model.descrip])
    {
        height = kBgImageHeight;
    }
    else
    {
        height = [DataHelper heightWithString:model.descrip font:kFontSize15 constrainedToWidth:kScreenWidth - 20];
        
        if(height > 60)
            height = 60;
        height += 220;
    }
    return height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
