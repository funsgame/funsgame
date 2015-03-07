//
//  WebViewController.m
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
{
    UILabel *titleLabel;
}

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([_webView isLoading])
    {
        [_webView stopLoading];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 滑动图片链接不用分享 
    if (_hiddenShare == 1)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }else
    {
        self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:@"分享" imageName:nil target:self action:@selector(shareButtonClick:)];
        self.navigationItem.rightBarButtonItem.enabled = NO; // 信息未加载成功时不可用
    }
    
    // 1011 修改导航栏字体大小
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = kFontSize17;
    titleLabel.textColor = [UIColor whiteColor];//设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kBodyHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    //  self.title = @"载入中...";
    titleLabel.text = @"载入中...";
    self.navigationItem.titleView = titleLabel;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAction:(UIButton *)button
{
    if (button.tag == 100)
    {
        if ([_webView canGoBack])
        {
            [_webView goBack];
        }
    }
    else if (button.tag == 101)
    {
        if ([_webView canGoForward])
        {
            [_webView goForward];
        }
    }
    else if (button.tag == 102)
    {
        [_webView reload];
    }
}

- (void)backToSuperView
{
    [_webView stopLoading];
    [super backToSuperView];
}

- (id)initWithUrl:(NSString *)url
{
    self = [self init];
    if (self != nil)
    {
        _url = [url copy];
    }
    return self;
}

#pragma mark -UIWebView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO ;
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title && ![title isEqual:@""])
    {
        // self.title = title;
        titleLabel.text = title;
    }
    else
    {
        // self.title = _webTitle;
        titleLabel.text = _webTitle;
    }
    self.navigationItem.titleView = titleLabel;
    
    if ([CommonMethod webRequestStatus:title] || ![NSString isNull:self.webTitle])
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)shareButtonClick:(UIBarButtonItem *)button
{
    [self sendShare];
}

// 响应事件
- (void)sendShare
{
    // 分享
    //    NSString *title = _webTitle;
//    NSString *title = titleLabel.text;
    // end
    
//    NSString *content = _urlForshare;  // 1015 更换分享时的url
//    ShareUtil *shareutil = [[ShareUtil alloc] init];
//    NSDictionary *dic = [shareutil getShareDictionaryWithTitle:title content:content imageUrl:nil];
//    
//    [shareutil showShareMenuWithData:dic controller:self];
}

@end
