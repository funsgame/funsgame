//
//  InputView.m
//  FunsGame
//
//  Created by weibin on 15/3/4.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "InputView.h"

#define kHeight 44.0f
#define kTop 5.0f
#define kLeft 10.0f
#define kBtnWith 60.0f

@implementation InputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = UIColorHex(@"#e9e9e9");
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kHeight);
    
    //评论输入
    _textView = InsertTextViewWithTextColor(self, self, CGRectMake(kLeft, kTop, kScreenWidth - kLeft - kBtnWith, kHeight - 2 * kTop),kFontSize14, NSTextAlignmentLeft,UIColorHex(@"#999999"));
    
    _sendBtn = InsertButtonWithType(self, CGRectMake(_textView.right, 0, kBtnWith, kHeight), 0, self, @selector(sendClick), UIButtonTypeCustom);
    _sendBtn.titleLabel.font = kFontSize14;
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn setTitleColor:kColorRed forState:UIControlStateNormal];
}

- (void)sendClick
{
    if (_clickBlock)
    {
        _clickBlock();
    }
}

@end
