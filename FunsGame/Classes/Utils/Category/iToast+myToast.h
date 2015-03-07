//
//  iToast+myToast.h
//  KinHop
//
//  Created by weibin on 14/11/25.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "iToast.h"

@interface iToast (myToast)

+ (iToast *)alertWithTitle:(NSString *)title;

+ (iToast *)alertWithTitleCenter:(NSString *)title;

+ (void)hiddenIToast;

@end
