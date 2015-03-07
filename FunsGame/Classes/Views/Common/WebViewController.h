//
//  WebViewController.h
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "SuperVC.h"

@interface WebViewController : SuperVC<UIWebViewDelegate>
{
    NSString *_url;
}

@property (strong, nonatomic) NSString *webTitle;

@property (strong, nonatomic) UIWebView *webView;

@property (copy, nonatomic) NSString *url;

/// 传的url用于分享
@property (copy, nonatomic) NSString *urlForshare;

@property (assign, nonatomic) BOOL hiddenShare;

- (id)initWithUrl:(NSString *)url;

@end
