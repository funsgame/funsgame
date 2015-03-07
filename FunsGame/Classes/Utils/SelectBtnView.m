//
//  SelectBtnView.m
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "SelectBtnView.h"

@implementation SelectBtnView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}

-(void)initView
{
    //   - (UIImage *)stretchableImageWithLeftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgView.image=[[UIImage imageWithName:@"HXSelectBg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    [self addSubview:bgView];
    
    _firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _firstBtn.tag = 100;
    [_firstBtn setTitle:@"消息" forState:UIControlStateNormal];
    _firstBtn.titleLabel.font = kFontSize15;
    [_firstBtn setTitleColor:kJHSColorMidBlack forState:UIControlStateNormal];
    [_firstBtn setTitleColor:kJHSColorBlack forState:UIControlStateDisabled];
    [_firstBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_firstBtn setBackgroundColor:kColorWhite];
    _firstBtn.frame=CGRectMake(0, 0, kScreenWidth / 3.0, 44);
    [self addSubview:_firstBtn];
    _firstBtn.enabled = NO;
    
    _secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _secondBtn.tag = 101;
    [_secondBtn setTitle:@"联系人" forState:UIControlStateNormal];
    _secondBtn.titleLabel.font = kFontSize15;
    [_secondBtn setTitleColor:kJHSColorMidBlack forState:UIControlStateNormal];
    [_secondBtn setTitleColor:kJHSColorBlack forState:UIControlStateDisabled];
    [_secondBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_secondBtn setBackgroundColor:kColorWhite];
    _secondBtn.frame = CGRectMake(_firstBtn.right, 0, kScreenWidth / 3.0, 44);
    [self addSubview:_secondBtn];
    
    
    _thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _thirdBtn.tag = 102;
    [_thirdBtn setTitle:@"关注商家" forState:UIControlStateNormal];
    _thirdBtn.titleLabel.font = kFontSize15;
    [_thirdBtn setTitleColor:kJHSColorMidBlack forState:UIControlStateNormal];
    [_thirdBtn setTitleColor:kJHSColorBlack forState:UIControlStateDisabled];
    [_thirdBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_thirdBtn setBackgroundColor:kColorWhite];
    _thirdBtn.frame = CGRectMake(_secondBtn.right, 0, kScreenWidth / 3.0, 44);
    [self addSubview:_thirdBtn];
    
    _selectBtnLine = InsertView(self, CGRectMake(0 , 44 - 2, kScreenWidth / 3.0, 2), kJHSColorRed);
    
    InsertView(self, CGRectMake(_firstBtn.right, 12.5, 0.5, 19), kJHSColorLightBlack);
    InsertView(self, CGRectMake(_secondBtn.right, 12.5, 0.5, 19), kJHSColorLightBlack);
    
    InsertView(self, CGRectMake(0, _firstBtn.bottom - 0.5, kScreenWidth, 0.5), kJHSColorLightBlack);

}

-(void)selectButtonClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
            _firstBtn.enabled = NO;
            _secondBtn.enabled = YES;
            _thirdBtn.enabled = YES;
        }
            break;
        case 101:
        {
            _firstBtn.enabled = YES;
            _secondBtn.enabled = NO;
            _thirdBtn.enabled = YES;
        }
            break;
        case 102:
        {
            _firstBtn.enabled = YES;
            _secondBtn.enabled = YES;
            _thirdBtn.enabled = NO;
        }
            break;
        default:
            break;
    }
    
    NSInteger index = sender.tag - 100;
    if (_delegate && [_delegate respondsToSelector:@selector(selectItem:)]) {
        [_delegate selectItem:index];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _selectBtnLine.frame = CGRectMake(kScreenWidth / 3.0 *(sender.tag - 100), 44 - 2, kScreenWidth / 3.0, 2);
    }];
}

- (void)refreshTitleWithTitle:(NSArray *)titleArray
{
    [_firstBtn setTitle:titleArray[0] forState:UIControlStateNormal];
    [_secondBtn setTitle:titleArray[1] forState:UIControlStateNormal];
    [_thirdBtn setTitle:titleArray[2] forState:UIControlStateNormal];
}

@end
