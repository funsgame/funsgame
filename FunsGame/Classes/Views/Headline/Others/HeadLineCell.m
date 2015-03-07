//
//  HeadLineCell.m
//  FunsGame
//
//  Created by weibin on 15/3/5.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "HeadLineCell.h"

#define kLeft 12.0f
#define kTop 5.0f
#define kTitleHeight 40.0f
#define kImageWith 80.0f
#define kImageHeight 60.0f

@implementation HeadLineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

- (void) initView
{
    _titleLabel = InsertLabel(self, CGRectMake(kLeft, kTop, 210, kTitleHeight), NSTextAlignmentLeft,@"匠人1212121212121212121212121212121212121212121212", kFontSize15, UIColorHex(@"121212"), NO);
    
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLeft, kTop, 210, kTitleHeight)];
//    _titleLabel.textAlignment = NSTextAlignmentLeft;
//    _titleLabel.font = kFontSize15;
//    _titleLabel.textColor = UIColorHex(@"121212");
    _titleLabel.numberOfLines = 0;
//    [self addSubview:_titleLabel];
    
    _image = InsertImageView(self, CGRectMake(kScreenWidth - kImageWith - kLeft, _titleLabel.top, kImageWith, kImageHeight), nil);
    
    _sourceLabel = InsertLabel(self, CGRectMake(kLeft, _titleLabel.bottom + 5, 60, 20), NSTextAlignmentLeft, @"1234", kFontSize12, UIColorHex(@"#a6a6a6"), NO);
    
    _praiseImage = InsertImageView(self, CGRectMake(_sourceLabel.right, _sourceLabel.top + 3, 15, 15), [UIImage imageNamed:@"comment"]);
    
    _praiseLabel = InsertLabel(self, CGRectMake(_praiseImage.right + 5, _sourceLabel.top, 40, 20), NSTextAlignmentLeft, @"123", kFontSize12,  UIColorHex(@"#a6a6a6"), NO);

}

- (void)refreshUIWithModel:(HeadlineModel *)model
{
    _titleLabel.text = model.title;
    
    if([model.img isEqualToString:@""])
    {
        _titleLabel.frame = CGRectMake(kLeft, kTop, kScreenWidth - 2 * kLeft, kTitleHeight);
    }
    else
    {
        [_image sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    }
    
    _sourceLabel.text = model.site;

    _praiseLabel.text = [NSString stringWithFormat:@"%@",model.commentCount];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
