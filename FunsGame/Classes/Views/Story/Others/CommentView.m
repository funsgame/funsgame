//
//  CommentView.m
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "CommentView.h"

#define kHeight 44.0f
#define kImageHeight 19.0f
#define kTopHeight 8.0f

@implementation CommentView

- (id)initWithFrame:(CGRect)frame view:(UIView *)view
{
    self = [super init];
    if (self)
    {
        CGRect rectSelf = frame;
        rectSelf.size.height = kHeight;
        self.frame = rectSelf;
        
        if (view)
        {
            [view addSubview:self];
        }
        
        [self initView];
    }
    
    return self;
}

- (void)initView
{
    _writeCommentBtn  = InsertButtonRoundedRect(self, CGRectMake(0, 0, kScreenWidth / 3.0, kHeight), 1000, @"写评论", self, nil);
    _writeCommentBtn.titleLabel.font = kFontSize16;
    [_writeCommentBtn setImage:[UIImage imageLocalizedNamed:@"write_comment"] forState:UIControlStateNormal];
    _writeCommentBtn.tintColor = UIColorHex(@"#b0b0b0");
    
    InsertView(self, CGRectMake(_writeCommentBtn.right, kTopHeight, 1, kHeight - kTopHeight * 2), UIColorHex(@"#d6d6d6"));
    
    CGFloat width = 2 * kScreenWidth / 12.0;
    _commentBtn  = InsertButtonRoundedRect(self, CGRectMake(_writeCommentBtn.right, 0, width, kHeight), 1001, nil, self, nil);
    
    UIImageView *comImg = InsertImageView(_commentBtn, CGRectMake((width - kImageHeight) / 2, kTopHeight - 2, kImageHeight, kImageHeight), [UIImage imageNamed:@"comment"]);
    comImg.userInteractionEnabled = NO;
    
    _commentLabel = InsertLabel(_commentBtn, CGRectMake(comImg.left + kImageHeight / 2, 5, 15, 10), NSTextAlignmentCenter, @"128", kFontSize8, kColorWhite, NO);
    _commentLabel.backgroundColor = UIColorHex(@"#e0433a");
    _commentLabel.userInteractionEnabled = NO;
    
    UILabel *comLbl = InsertLabel(_commentBtn, CGRectMake(0, comImg.bottom, width, 16), NSTextAlignmentCenter, @"评论", kFontSize12,  UIColorHex(@"#b0b0b0"), NO);
    comLbl.userInteractionEnabled = NO;
    
    _praiseBtn  = InsertButtonRoundedRect(self, CGRectMake(_commentBtn.right, 0, width, kHeight), 1001, nil, self, nil);
    
    UIImageView *loveImg = InsertImageView(_praiseBtn, CGRectMake((width - kImageHeight) / 2, kTopHeight - 2, kImageHeight, kImageHeight), [UIImage imageNamed:@"love"]);
    loveImg.userInteractionEnabled = NO;
    
    _praiseLabel = InsertLabel(_praiseBtn, CGRectMake(loveImg.left + kImageHeight / 2, 5, 15, 10), NSTextAlignmentCenter, @"16", kFontSize8, kColorWhite, NO);
    _praiseLabel.backgroundColor = UIColorHex(@"#e0433a");
    _praiseLabel.userInteractionEnabled = NO;
    
    UILabel *loveLbl = InsertLabel(_praiseBtn, CGRectMake(0, loveImg.bottom, width, 16), NSTextAlignmentCenter, @"喜欢", kFontSize12,  UIColorHex(@"#b0b0b0"), NO);
    loveLbl.userInteractionEnabled = NO;
    
    _shareBtn  = InsertButtonRoundedRect(self, CGRectMake(_praiseBtn.right, 0, width, kHeight), 1001, nil, self, nil);
    
    UIImageView *shareImg = InsertImageView(_shareBtn, CGRectMake((width - kImageHeight) / 2, kTopHeight - 2, kImageHeight, kImageHeight), [UIImage imageNamed:@"share"]);
    shareImg.userInteractionEnabled = NO;
    
    UILabel *shareLbl = InsertLabel(_shareBtn, CGRectMake(0, shareImg.bottom, width, 16), NSTextAlignmentCenter, @"分享", kFontSize12,  UIColorHex(@"#b0b0b0"), NO);
    shareLbl.userInteractionEnabled = NO;
    
    _collectBtn  = InsertButtonRoundedRect(self, CGRectMake(_shareBtn.right, 0, width, kHeight), 1001, nil, self, nil);
    
    UIImageView *collecImg = InsertImageView(_collectBtn, CGRectMake((width - kImageHeight) / 2, kTopHeight - 2, kImageHeight, kImageHeight), [UIImage imageNamed:@"favourite"]);
    collecImg.userInteractionEnabled = NO;
    
    UILabel *collectLbl = InsertLabel(_collectBtn, CGRectMake(0, collecImg.bottom, width, 16), NSTextAlignmentCenter, @"收藏", kFontSize12,  UIColorHex(@"#b0b0b0"), NO);
    collectLbl.userInteractionEnabled = NO;

    _writeCommentBtn.enabled = NO;
    _commentBtn.enabled = NO;
    _praiseBtn.enabled = NO;
    _shareBtn.enabled = NO;
    _collectBtn.enabled = NO;
}

@end
