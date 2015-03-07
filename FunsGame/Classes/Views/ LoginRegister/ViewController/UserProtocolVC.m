//
//  UserProtocolVC.m
//  kinhop
//
//  Created by weibin on 15/1/21.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "UserProtocolVC.h"

@interface UserProtocolVC ()
{
    UIView *_headView;
}

@property (nonatomic, strong) UITableView *userProTableView;

@end

@implementation UserProtocolVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"用户协议";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView
{
    self.view.backgroundColor = kJHSColorDarkWhite;
    
    _userProTableView = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), nil, nil, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _userProTableView.showsVerticalScrollIndicator = NO;
    _userProTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _userProTableView.backgroundColor = kJHSColorDarkWhite;
    [DataHelper setExtraCellLineHidden:_userProTableView];
    
    _headView = InsertView(self.view, CGRectMake(0, 0, kScreenWidth, 7500), kColorClear);
    _userProTableView.tableHeaderView = _headView;

    [self loadHeadView];
}

- (void)loadHeadView
{
    UILabel *titleLabel = InsertLabel(_headView, CGRectMake(0, 10, kScreenWidth, 20), NSTextAlignmentCenter, @"金合社服务协议", kFontSize18, kJHSColorBlack, NO);
    UILabel *content = InsertLabel(_headView, CGRectMake(20, titleLabel.bottom + 10, kScreenWidth - 40, 7500), NSTextAlignmentLeft, nil, kFontSize13, kJHSColorDarkBlack, NO);
    content.numberOfLines = 0;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userProto"
                                                     ofType:@"txt"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSString *netString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    content.text = netString;

    [content sizeToFit];
}

@end
