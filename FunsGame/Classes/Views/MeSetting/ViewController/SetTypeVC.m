//
//  SetTypeVC.m
//  FunsGame
//
//  Created by weibin on 15/3/3.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "SetTypeVC.h"
#import "SetTypeCell.h"

@interface SetTypeVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingTable;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation SetTypeVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _titleArr = [NSArray array];
        
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
    _settingTable = InsertTableView(self.view, CGRectMake(0, 0, kScreenWidth, kAllHeight), self, self, UITableViewStyleGrouped, UITableViewCellSeparatorStyleSingleLine);
    _settingTable.showsVerticalScrollIndicator = NO;
    _settingTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _settingTable.backgroundColor = kBackgroundColor;
    _settingTable.separatorInset = UIEdgeInsetsMake(0,15, 0, 15);
    
    [DataHelper setExtraCellLineHidden:_settingTable];
}

- (void)loadTitle
{
    if(_setType == SetFont)
    {
        _titleArr = @[@[@"小号字体",@"中号字体",@"大号字体",@"夜间模式"]];
    }
    else if(_setType == SetNotice)
    {
        _titleArr = @[@[@"要闻推送",@"新对话时提醒",@"新粉丝时提醒",@"新评论时提醒"]];
    }
    else if(_setType == SetPerson)
    {
        _titleArr = @[@[@"允许我关注的人向我发起对话",@"允许陌生人向我发起对话",@"向我推荐微博好友"]];
    }
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_setType == SetPerson)
    {
        return 3;
    }
    else if(_setType == SetFont || _setType == SetNotice)
    {
        return 4;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserCell = @"set_font_cell";
    
    SetTypeCell *cell = (SetTypeCell *)[tableView dequeueReusableCellWithIdentifier:reuserCell];
    if (!cell)
    {
        cell = [[SetTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserCell];
    }
    
    cell.titleLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    cell.image.image = [UIImage imageNamed:@"off"];
    
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
