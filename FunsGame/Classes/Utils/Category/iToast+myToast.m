//
//  iToast+myToast.m
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "iToast+myToast.h"

static iToast *staticIToast;

@implementation iToast (myToast)

// 实例化iToast
+ (iToast *)alertWithTitle:(NSString *)title
{
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:iToastGravityTop
                  offsetLeft:0
                   offsetTop:120];
    [staticIToast show];
    return staticIToast;
}

+ (iToast *)alertWithTitleCenter:(NSString *)title
{
    staticIToast = [iToast makeText:title ];
    [iToastSettings getSharedSettings].postition = CGPointMake(kScreenWidth, 120);
    [staticIToast setGravity:iToastGravityCenter
                  offsetLeft:0
                   offsetTop:120];
    [staticIToast show];
    return staticIToast;
}

+ (void)hiddenIToast
{
//    [staticIToast hidden];
}

@end
