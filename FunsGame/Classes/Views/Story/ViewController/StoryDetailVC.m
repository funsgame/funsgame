//
//  StoryDetailVC.m
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "StoryDetailVC.h"
#import "SetTypeVC.h"
#import "CommentView.h"
#import "InputView.h"

#define bottomHeight 44.0f

@interface StoryDetailVC ()<UIWebViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    UIWebView *_webView;
    NSString *_storyId;
    NSString *_url;
    CommentView *_commentView;
    InputView *_inputview;
    UITextField *_virtualTextField;      //虚拟输入textfield
    UIView *_gestureView;
}

@property (nonatomic, strong) UITableView *storyDetailTable;

@end

@implementation StoryDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"故事详情";
    }
    return self;
}

- (id)initWithStoryId:(NSString *)sid
{
    if(self = [super init])
    {
        _storyId = sid;
    }
    return self;
}

//- (void)dealloc
//{
//    [_webView removeFromSuperview];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView
{
    self.navigationItem.rightBarButtonItem = [[self class] rightBarButtonWithName:nil imageName:@"fontsize" target:self action:@selector(modeClick:)];
    
    _storyDetailTable = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight - bottomHeight), nil, nil, UITableViewStylePlain, UITableViewCellSeparatorStyleNone);
    _webView = InsertWebView(self.view, CGRectZero, self, 0);
    _storyDetailTable.tableHeaderView = _webView;
    [self loadWebContent];
    
    // 底端视图
    CGRect rectBottom = CGRectMake(0.0, kScreenHeight - bottomHeight - 44, kScreenWidth, bottomHeight);
    
    _commentView = [[CommentView alloc] initWithFrame:rectBottom view:self.view];
    _commentView.backgroundColor = UIColorHex(@"#fefefe");
    
    [_commentView.writeCommentBtn addTarget:self action:@selector(writeCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_commentView.commentBtn addTarget:self action:@selector(commentClick:) forControlEvents:UIControlEventTouchUpInside];

    [_commentView.praiseBtn addTarget:self action:@selector(praiseClick:) forControlEvents:UIControlEventTouchUpInside];

    [_commentView.shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];

    [_commentView.collectBtn addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //带输入textview的键盘
    _virtualTextField = [[MyTextField alloc] initWithFrame:CGRectMake(0, CGFLOAT_MAX, 10, 10)];
    _virtualTextField.delegate = self;
    [self.view addSubview:_virtualTextField];
    _inputview = [[InputView alloc] init];
    kSelfWeak;
    _inputview.clickBlock = ^{
        [weakSelf publishComment];
    };
    [_virtualTextField setInputAccessoryView:_inputview];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(textFiledEditChanged:)
//                                                 name:UITextViewTextDidChangeNotification
//                                               object:nil];
}

- (void)modeClick:(id)sender
{
    SetTypeVC *vc = [[SetTypeVC alloc] init];
    vc.setType = SetFont;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadWebContent {
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@/api/story_detail?id=%@",kServerHost,_storyId];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSURL *url = [NSURL URLWithString:urlStr];
        NSStringEncoding encode;
        NSError *error;
        
        NSString *content = [NSString stringWithContentsOfURL:url usedEncoding:&encode error:&error];
        
        if (nil == content) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
//                [self showInfoTip:[error localizedDescription]];
            });
        }
        else {
            
            NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dic  = [[[json objectForKey:@"result"] objectForKey:@"list"] objectAtIndex:0];
            
            NSString *content = [dic objectForKey:@"content"];
            
            NSString *title = [dic objectForKey:@"title"];
            
            NSString *author = [dic objectForKey:@"author"];
            
            NSString *image = [dic objectForKey:@"cover_img"];
            
            [self loadHtmlContent:content title:title author:author image:image];
        }
    });
}

#pragma mark - public
- (void)loadHtmlContent:(NSString *)htmlContent title:(NSString *)title author:(NSString *)author image:(NSString *)image
{
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"html/article" ofType:@"html"];
    NSURL *htmlUrl = [NSURL fileURLWithPath:htmlFile];
    
    NSMutableString* mutableHtmlString = [NSMutableString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    
    [mutableHtmlString replaceOccurrencesOfString:@"{{title}}" withString:title options:NSLiteralSearch range:NSMakeRange(0, mutableHtmlString.length)];
    
    [mutableHtmlString replaceOccurrencesOfString:@"{{cover_img}}" withString:image options:NSLiteralSearch range:NSMakeRange(0, mutableHtmlString.length)];
    
    [mutableHtmlString replaceOccurrencesOfString:@"{{author}}" withString:author options:NSLiteralSearch range:NSMakeRange(0, mutableHtmlString.length)];

    [mutableHtmlString replaceOccurrencesOfString:@"{{content}}" withString:htmlContent options:NSLiteralSearch range:NSMakeRange(0, mutableHtmlString.length)];
    
//    FunsFont *font = [[J2LocalDatas sharedInstance].currSettings fontSetting];
//    NSInteger fontsize = J2Boundi([font.font_size intValue], 1, 3);
//    NSInteger fontnight = [font.font_night_mode intValue];
    
//    [mutableHtmlString replaceOccurrencesOfString:@"{{fontsize}}" withString:[NSString stringWithFormat:@"%d",(int)fontsize] options:NSLiteralSearch range:NSMakeRange(0, mutableHtmlString.length)];
//    [mutableHtmlString replaceOccurrencesOfString:@"{{fontnight}}" withString:[NSString stringWithFormat:@"%d",(int)fontnight] options:NSLiteralSearch range:NSMakeRange(0, mutableHtmlString.length)];
    
    [_webView loadHTMLString:mutableHtmlString baseURL:htmlUrl];
}

- (void)writeCommentClick:(id)sender
{
    [self keyboardShow];
}

- (void)commentClick:(id)sender
{
    
}

- (void)praiseClick:(id)sender
{
    
}

- (void)shareClick:(id)sender
{
    
}

- (void)collectClick:(id)sender
{
    
}

//发布按钮
- (void)publishComment
{
    [self keyboardHidden];
    if ([NSString isNull:_inputview.textView.text] || [_inputview.textView.text isBlank])
    {
        [iToast alertWithTitle:@"评论内容不能为空！"];
        return;
    }
}

#pragma mark - 发表评论键盘显示与隐藏
- (void)keyboardShow
{
    //隐藏键盘手势
    _gestureView = InsertView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), kColorClear);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
    [_gestureView addGestureRecognizer:tap];
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHidden)];
//    swipe.direction = UISwipeGestureRecognizerDirectionDown | UISwipeGestureRecognizerDirectionUp;
//    [_gestureView addGestureRecognizer:swipe];
    
    [_virtualTextField becomeFirstResponder];
    [_inputview.textView becomeFirstResponder];
}

- (void)keyboardHidden
{
    [_inputview.textView resignFirstResponder];
    [_virtualTextField resignFirstResponder];
    [_gestureView removeFromSuperview];
}

#pragma mark - webViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    CGSize fittingSize = webView.scrollView.contentSize;
    NSString *webHeight = [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];
//    _webViewTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    frame.size = fittingSize;
    webView.frame = CGRectMake(0.0, 0.0, kScreenWidth - 20,[webHeight floatValue]);
    
//    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'";
//    [_webView stringByEvaluatingJavaScriptFromString:str];
    
    _commentView.writeCommentBtn.enabled = YES;
    _commentView.commentBtn.enabled = YES;
    _commentView.praiseBtn.enabled = YES;
    _commentView.shareBtn.enabled = YES;
    _commentView.collectBtn.enabled = YES;
    
    _storyDetailTable.tableHeaderView = _webView;
    [_storyDetailTable reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
