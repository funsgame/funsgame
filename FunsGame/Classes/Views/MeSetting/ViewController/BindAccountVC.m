//
//  BindAccountVC.m
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "BindAccountVC.h"
#import "BindAccountCell.h"

@interface BindAccountVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *bindAccountTable;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation BindAccountVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _titleArr = [NSArray array];
        _imageArr = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initView];
    
    [self loadTitle];
}

- (void)initView
{
    _bindAccountTable = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), self, self, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _bindAccountTable.showsVerticalScrollIndicator = NO;
    _bindAccountTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _bindAccountTable.backgroundColor = kBackgroundColor;
    _bindAccountTable.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    
    [DataHelper setExtraCellLineHidden:_bindAccountTable];
}

- (void)loadTitle
{
    _titleArr = @[@[@"微博",@"微信",@"QQ空间"]];
    _imageArr = @[@[@"weibo_login",@"weixin_login",@"qzone_login"]];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserCell = @"bind_accout_cell";
    
    BindAccountCell *cell = (BindAccountCell *)[tableView dequeueReusableCellWithIdentifier:reuserCell];
    if (!cell)
    {
        cell = [[BindAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserCell];
    }
    
    cell.headImage.image = [UIImage imageNamed:_imageArr[indexPath.section][indexPath.row]];
    cell.titleLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
