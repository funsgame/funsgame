//
//  HendLineDetailVC.m
//  FunsGame
//
//  Created by weibin on 15/3/7.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "HendLineDetailVC.h"
#import "CommentView.h"
#import "InputView.h"

#define bottomHeight 44.0f

@interface HendLineDetailVC ()<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIWebView *_webView;
    NSString *_newsId;
    NSString *_url;
    CommentView *_commentView;
    InputView *_inputview;
    UITextField *_virtualTextField;      //虚拟输入textfield
    UIView *_gestureView;
}

@end

@implementation HendLineDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"头条详情";
    }
    return self;
}




@end
