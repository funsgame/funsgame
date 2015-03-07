//
//  SuperVC.m
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "SuperVC.h"
#import "LoadingAndRefreshView.h"
//#import "LoginViewController.h"

@interface SuperVC ()<LoadingAndRefreshViewDelegate>
{
    LoadingAndRefreshView   *_loadingAndRefreshView;
    
    UITapGestureRecognizer  *_tap;      //添加手势用于点击空白处收回键盘
}

@end

@implementation SuperVC

- (void)dealloc
{
    DLog(@"%@释放了",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kBackgroundColor;
    
    [[self class] setNavigationStyle:self.navigationController];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"custom_funs"]];

    if (ISIOS7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 显示系统返回按钮
    if (!self.navigationItem.leftBarButtonItem)
    {
        self.navigationItem.leftBarButtonItem = [self isTabbarRoot] ? nil : [self barBackButton];
    }

    // 监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    // 键盘弹出后在屏幕添加手势，点击空白处收回键盘
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHidden)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleLightContent)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }

    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled = NO;
    self.navigationItem.rightBarButtonItem.customView.userInteractionEnabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self isTabbarRoot]) {
        self.hidesBottomBarWhenPushed = YES;
    }else{
        self.hidesBottomBarWhenPushed = YES;
    }
    
    self.navigationItem.leftBarButtonItem.customView.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem.customView.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self isTabbarRoot]) {
        self.hidesBottomBarWhenPushed = NO;
    }else{
        self.hidesBottomBarWhenPushed = YES;
    }
    
    [SVProgressHUD dismiss];
}

- (BOOL)isNavRoot
{
    return self.navigationController.viewControllers.firstObject == self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//  判断登录
- (void)loginVerifySuccess:(void (^)())success
{
    if ([DataManager sharedManager].isLogin)
    {
        if (success)
        {
            success();
        }
    }
    else
    {
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
//        loginVC.completionBack = [success copy];
//        //        loginVC.navigationItem.leftBarButtonItem = [self barBackButton];
//        loginVC.showleftButton = YES;
//        loginVC.GesUnlockView = self.isGexUnlockView;
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//        [MainViewController setNavigationStyle:navigationController];
//        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

#pragma mark- 网络加载视图
- (void)refreshClick
{

}

- (void)addLoadingView
{
    if (_loadingAndRefreshView==nil)
    {
        _loadingAndRefreshView=[[LoadingAndRefreshView alloc] initWithFrame: self.view.bounds];
        _loadingAndRefreshView.delegate=self;
    }
    
    if (_loadingAndRefreshView.superview==nil)
    {
        [self.view addSubview:_loadingAndRefreshView];
    }
    
    [self.view bringSubviewToFront:_loadingAndRefreshView];
}

- (void)loadingDataStart
{
    [self addLoadingView];
    
    [_loadingAndRefreshView setLoadingState];
}

- (void)loadingDataSuccess
{
    if (_loadingAndRefreshView.superview!=nil)
    {
        [_loadingAndRefreshView removeFromSuperview];
    }
}

- (void)loadingDataFail
{
    [self addLoadingView];
    [_loadingAndRefreshView setFailedState];
}

- (void)loadingDataBlank
{
    [self addLoadingView];
}

- (void)loadingDataBlankWithTitle:(NSString *)title
{
    [self addLoadingView];
}

#pragma mark- 网络操作的添加和释放

- (void)addNet:(MKNetworkOperation *)net
{
    if (!_networkOperations)
    {
        _networkOperations = [[NSMutableArray alloc] init];
    }
    
    [_networkOperations addObject:net];
}

- (void)releaseNet
{
    for (MKNetworkOperation *net in _networkOperations)
    {
        if ([net isKindOfClass:[MKNetworkOperation class]])
        {
            [net cancel];
        }
    }
}

#pragma mark - 导航栏按钮

- (BOOL)isTabbarRoot
{
    for (UINavigationController *nc in self.tabBarController.viewControllers) {
        if (nc.viewControllers.firstObject == self) {
            return YES;
        }
    }
    return NO;
}

// 设置导航栏左按钮
- (UIBarButtonItem *)barBackButton
{
    return [self barBackButtonWithImage:[UIImage imageWithName:@"back"]];
}

- (UIBarButtonItem *)barBackButtonForPrensentedVC;
{
    return [self barBackButtonWithImage:[UIImage imageWithName:@"back"]];
}

- (UIBarButtonItem *)barBackButtonWithImage:(UIImage *)image
{
    CGRect buttonFrame;
    if (ISIOS7)
    {
        buttonFrame = CGRectMake(0, 0, image.size.width, image.size.height);
    }
    else
    {
        buttonFrame = CGRectMake(0, 0, image.size.width + 20, image.size.height);
    }
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(backToSuperView) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    button.accessibilityLabel = @"back";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}


// 设置导航栏右按钮
+ (UIBarButtonItem *)rightBarButtonWithName:(NSString *)name
                                  imageName:(NSString *)imageName
                                     target:(id)target
                                     action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName && ![imageName isEqualToString:@""])
    {
        UIImage *image = [UIImage imageWithName:imageName];
        [btn setImage:image forState:UIControlStateNormal];
        
        UIImage *imageSelected = [UIImage imageWithName:[NSString stringWithFormat:@"%@_s",imageName]];
        if (imageSelected)
        {
            [btn setImage:imageSelected forState:UIControlStateSelected];
        }
        
        if (ISIOS7)
        {
            btn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }
        else
        {
            btn.frame = CGRectMake(0, 0, image.size.width+20, image.size.height);
        }
    }
    else
    {
        btn.frame=CGRectMake(0, 0, 50, 30);
    }
    
    if (name && ![name isEqualToString:@""])
    {
        [btn setTitle:name forState:UIControlStateNormal];
        btn.titleLabel.font = kFontSizeBold16;
        [btn setTitleColor:kFunsColorBlack forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forState:UIControlStateDisabled];
    }
    
    if (ISIOS7)
    {
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)backToSuperView
{
    //取消网络请求
    [self releaseNet];
    [self.view endEditing:YES];
    
    if (self.navigationController.viewControllers.firstObject == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

+ (void)setNavigationStyle:(UINavigationController *)nav
{
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"custom_navbar_bg"] forBarMetrics:UIBarMetricsDefault];
    
    if (ISIOS7)
    {
        [nav.navigationBar setShadowImage:[UIImage imageWithColor:kColorClear andSize:CGSizeMake(1, 64)]];
    }
    else
    {
        [nav.navigationBar setShadowImage:[UIImage imageWithColor:kColorClear andSize:CGSizeMake(1, 44)]];
    }
    
    nav.navigationBar.translucent = YES;
}

#pragma mark- 键盘弹出点击空白处回收键盘

//点击空白处键盘收回
- (void)textFieldReturn{
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //键盘弹出后在屏幕添加手势，点击空白处收回键盘
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHidden)];
}

//键盘弹出添加手势
- (void)keyboardWillShow:(NSNotification*)notification
{
    [self.view addGestureRecognizer:_tap];
}

//键盘收回移除手势
- (void)keyboardWillHide:(NSNotification*)notification
{
    [self.view removeGestureRecognizer:_tap];
}

//收回键盘
- (void)keyboardHidden
{
    [self.view endEditing:YES];
}

//销毁键盘弹出通知
- (void)deallocTextFieldNSNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
