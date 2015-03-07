//
//  BaseTableView.m
//  KinHop
//
//  Created by weibin on 14/11/26.
//  Copyright (c) 2014年 cwb. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate   = self;
        self.dataSource = self;
        self.accessibilityLabel = @"businessTable";
        self.isShowHeadView = NO;
    }
    return self;
}

#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isDelete) {
        return YES;
    }
    return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isShowHeadView) {
        return 31;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //        if (editingStyle ==UITableViewCellEditingStyleDelete ) {
    //            [self.data removeObjectAtIndex:indexPath.row];
    //            [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    //        }
}


- (void)reloadData
{
    [super reloadData];
    //修改 by chenli
    [self footerEndRefreshing];
    [self headerEndRefreshing];
}

#pragma mark - UIScrollViewDelegate
// 下拉进行网络加载过程中，当网络异常且往上滚动时，隐藏下拉刷新状态视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    float lastOffsetY = 1.0;
    if (currentOffsetY - lastOffsetY >= 1.0)
    {
        [self headerEndRefreshingScrollUp];
    }
}

@end
