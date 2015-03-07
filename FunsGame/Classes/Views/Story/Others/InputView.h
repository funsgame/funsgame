//
//  InputView.h
//  FunsGame
//
//  Created by weibin on 15/3/4.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickBlock)(void);

@interface InputView : UIView<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, copy) ClickBlock clickBlock;

@end
