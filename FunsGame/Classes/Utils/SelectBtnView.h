//
//  SelectBtnView.h
//  KinHop
//
//  Created by weibin on 14/12/15.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectButtonViewDelegate <NSObject>

-(void)selectItem:(NSInteger)index;

@end

@interface SelectBtnView : UIView

@property (nonatomic, weak) id <SelectButtonViewDelegate> delegate;
@property (nonatomic, strong) UIView *selectBtnLine;
@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) UIButton *thirdBtn;

- (void)refreshTitleWithTitle:(NSArray *)titleArray;

@end
