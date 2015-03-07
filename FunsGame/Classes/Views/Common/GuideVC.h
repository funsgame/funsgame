//
//  GuideVC.h
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideVC : UIViewController<UIScrollViewDelegate>

@property(nonatomic, copy) void (^startBlock)(void);

@end
