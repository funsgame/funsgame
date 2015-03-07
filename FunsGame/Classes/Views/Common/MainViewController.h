//
//  MainViewController.h
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITabBarController

/// 当前被选中视图索引
@property (nonatomic, strong) NSNumber *currentVCNumber;

+ (void)setNavigationStyle:(UINavigationController*)nav;

@end
