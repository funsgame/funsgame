//
//  WithoutDataView.m
//  kinhop
//
//  Created by weibin on 15/1/21.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "WithoutDataView.h"

static CGFloat const SizeImageWidth = 209.0 / 2;
static CGFloat const SizeImageHeight = 269.0 / 2;
static CGFloat const SizeWidthButton = 45.0;
static CGFloat const SizeHeightButton = 44.5;

@interface WithoutDataView ()

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UIButton *button;

@end

@implementation WithoutDataView

@synthesize imageview;
@synthesize button;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initWithoutDataView:(UIView *)superview
{
    self = [super init];
    if (self)
    {
        if (superview)
        {
            [superview addSubview:self];
        }
        
        self.backgroundColor = [UIColor clearColor];
        
        CGRect rect = superview.frame;
        self.frame = CGRectMake(0.0, 0.0, rect.size.width, 0.0);
        
        // 图标
        self.imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, SizeImageWidth, SizeImageHeight)];
        self.imageview.center = CGPointMake(kScreenWidth / 2.0, (kBodyHeight - 44 - 100) / 2.0);
        [self addSubview:self.imageview];
        self.imageview.contentMode = UIViewContentModeScaleAspectFit;
        self.imageview.image = [UIImage imageLocalizedNamed:@"no_data"];
        self.imageview.backgroundColor = [UIColor clearColor];
        
        UIView *currentView = self.imageview;
        
        // 重新加载按钮
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.button];
        self.button.frame = CGRectMake((self.frame.size.width - SizeWidthButton) / 2, self.imageview.bottom + 10, SizeWidthButton, SizeHeightButton);
        [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageWithName:@"refresh_button"] forState:UIControlStateNormal];
        [self.button setBackgroundImage:[UIImage imageWithName:@"refresh_button_s"] forState:UIControlStateHighlighted];
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.button.backgroundColor = [UIColor clearColor];
        
        currentView = self.button;
        
        CGFloat realHeight = currentView.frame.origin.y + currentView.frame.size.height;
        CGRect selfRect = self.frame;
        selfRect.size.height = realHeight;
        selfRect.origin.y = (superview.frame.size.height - realHeight) / 2 - 64.0;
        self.frame = selfRect;
    }
    
    return self;
}

- (void)buttonClick:(UIButton *)button
{
    if (self.buttonClick)
    {
        self.buttonClick();
    }
}

@end
