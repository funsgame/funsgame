//
//  MainViewController.m
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "MainViewController.h"
#import "StoryVC.h"
#import "HeadlineVC.h"
#import "GameVC.h"
#import "MeSettingVC.h"
#import "BufferedNavigationController.h"

//#import "LoginViewController.h"
#import "CustomNaviBar.h"

@interface MainViewController () <UITabBarControllerDelegate>

@property (nonatomic ,strong) StoryVC *_kinHop;

@property (nonatomic, strong) HeadlineVC *_accountVC;


@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setBackgroundColor:kColorWhite];

    [self initViewController];
}

- (void)initViewController
{
    /**
     *  故事 * 头条 * 游戏 * 我
     */
    StoryVC *storyVC = [[StoryVC alloc] init];
    HeadlineVC *headlineVC = [[HeadlineVC alloc] init];
    GameVC *gameVC = [[GameVC alloc] init];
    MeSettingVC *setVC = [[MeSettingVC alloc] init];
    
    NSArray *views = @[storyVC,headlineVC,gameVC,setVC];
    NSMutableArray *viewcontrollers = [NSMutableArray arrayWithCapacity:3];
    for (UIViewController *viewcontroller in views) {
        BufferedNavigationController *nav = [[BufferedNavigationController alloc] initWithRootViewController:viewcontroller];
        if ([viewcontroller isKindOfClass:[headlineVC class]]) {
            NSMutableData *data = [[NSMutableData alloc] init];
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
            [archiver encodeObject:nav forKey:@"kRootKey"];
            [archiver finishEncoding];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            [unarchiver setClass:[CustomNaviBar class] forClassName:NSStringFromClass([UINavigationBar class])];
            nav = [unarchiver decodeObjectForKey:@"kRootKey"];
        }
        
        [viewcontrollers addObject:nav];
    }
    
//    NSArray * items = @[@"故事",@"头条",@"我"];
    
    for (int i = 0; i < views.count; i ++) {
        BufferedNavigationController *nav = viewcontrollers[i];
//        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:items[i] image:nil tag:i];
        [nav.tabBarItem setFinishedSelectedImage:[UIImage imageWithName:[NSString stringWithFormat:@"tabbar_s_%d",i ]] withFinishedUnselectedImage:[UIImage imageWithName:[NSString stringWithFormat:@"tabbar_n_%d",i ]]];
        
        [[self class] setTableBarItemStyle:nav.tabBarItem];
        [[self class] setNavigationStyle:nav];
    }
    
    self.delegate = self; 
    self.viewControllers = viewcontrollers;

    [self.tabBar setBackgroundImage:[UIImage imageWithColor:kColorClear andSize:CGSizeMake(1, 49)]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:kColorClear andSize:CGSizeMake(1, 49)]];
}

+ (void)setTableBarItemStyle:(UITabBarItem*)tabBarItem
{
    [tabBarItem setImageInsets:UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0)];
}

+ (void)setNavigationStyle:(UINavigationController*)nav
{
    
    nav.navigationBar.translucent = YES;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    // 保存进入后台的参数，用于判断从哪个视图进入后台
    self.currentVCNumber = [NSNumber numberWithInt:(int)index];
    
    // 1015 修复新闻不需判断是否登录
    if (4 == index)
    {
        // 我的帐户时判断是否登录
        if (![DataManager sharedManager].isLogin)
        {
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            loginVC.showleftButton = YES;
//            loginVC.completionBack = ^(){
//                
//                
//                [NotificationManager postNotificationRefreshMyAccount];
//            };
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
//            [MainViewController setNavigationStyle:navigationController];
//            [self presentViewController:navigationController animated:YES completion:nil];
            
            return NO;
        }
    }
    
    return YES;
}

@end
