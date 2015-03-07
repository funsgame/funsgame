//
//  SetTypeVC.h
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "SuperVC.h"

typedef enum
{
    SetFont = 0,
    SetNotice = 1,
    SetPerson = 2
} SetType;

@interface SetTypeVC : SuperVC

@property (nonatomic, assign) SetType setType;

@end
