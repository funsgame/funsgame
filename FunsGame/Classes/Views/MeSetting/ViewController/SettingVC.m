//
//  SettingVC.m
//  FunsGame
//
//  Created by weibin on 15/3/2.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "SetTypeVC.h"
#import "BindAccountVC.h"

@interface SettingVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingTable;
@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation SettingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.navigationItem.title = @"设置";
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
    _titleArr = @[@[@"字体大小",@"消息通知",@"夜间模式",@"隐私设置",@"账号绑定"],
                  @[@"清理缓存",@"关于我们",@"退出登录"]];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(1 == section)
        return 3;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserCell = @"setting_cell";
    
    SettingCell *cell = (SettingCell *)[tableView dequeueReusableCellWithIdentifier:reuserCell];
    if (!cell)
    {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserCell];
    }
    
    cell.titleLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    if(0 == indexPath.section && 0 == indexPath.row)
    {
        cell.detailLabel.text = @"中";
    }
    else if(1 == indexPath.section && 0 == indexPath.row)
    {
        cell.detailLabel.text = @"123KB";
    }
    else
    {
        cell.detailLabel.text = @"";
    }
    
    if(0 == indexPath.section && 2 == indexPath.row)
    {
        cell.image.image = [UIImage imageNamed:@"off"];
    }
    else if((1 == indexPath.section && 0 == indexPath.row) || (1 == indexPath.section && 2 == indexPath.row))
    {
        cell.image.image = [UIImage imageNamed:@""];
    }
    else
    {
        cell.image.image = [UIImage imageNamed:@"next"];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(0 == indexPath.section && 0 == indexPath.row)
    {
        SetTypeVC *vc = [[SetTypeVC alloc] init];
        vc.setType = SetFont;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(0 == indexPath.section && 1 == indexPath.row)
    {
        SetTypeVC *vc = [[SetTypeVC alloc] init];
        vc.setType = SetNotice;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(0 == indexPath.section && 3 == indexPath.row)
    {
        SetTypeVC *vc = [[SetTypeVC alloc] init];
        vc.setType = SetPerson;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(0 == indexPath.section && 4 == indexPath.row)
    {
        BindAccountVC *vc = [[BindAccountVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    



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
