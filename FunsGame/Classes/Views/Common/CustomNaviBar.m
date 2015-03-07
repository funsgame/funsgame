//
//  CustomNaviBar.m
//  kinhop
//
//  Created by weibin on 15/1/6.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "CustomNaviBar.h"

@implementation CustomNaviBar

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL isTouchAllowed = YES;
    if (point.y<0 || point.y>44) {
        isTouchAllowed = NO;
    }
    
    if (isTouchAllowed) {
        self.userInteractionEnabled = YES;
    } else {
        self.userInteractionEnabled = NO;
    }
    return [super hitTest:point withEvent:event];
}

@end
