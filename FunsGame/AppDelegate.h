//
//  AppDelegate.h
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainViewController *mainViewController;

+ (void)setAppearance;

- (void)showMainVCAndLogin;

@end

