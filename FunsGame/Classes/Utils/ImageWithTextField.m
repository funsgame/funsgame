//
//  ImageWithTextField.m
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "ImageWithTextField.h"

@implementation ImageWithTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        /// 忽略大小写
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        UIView *leftView = InsertView(nil, CGRectMake(0, 0, 38, 44), kColorClear);
        _leftImageView = InsertImageView(leftView, CGRectMake(5, 0, leftView.width, leftView.height), nil);
        _leftImageView.contentMode = UIViewContentModeCenter;
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
