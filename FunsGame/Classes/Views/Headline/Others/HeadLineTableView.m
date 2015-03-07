//
//  HeadLineTableView.m
//  FunsGame
//
//  Created by weibin on 15/3/5.
//  Copyright (c) 2015年 cwb. All rights reserved.
//

#import "HeadLineTableView.h"
#import "HeadLineCell.h"

#define kTableViewHeight 80.f

@implementation HeadLineTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.dataSource = self;
        self.delegate = self;
        
        if (ISIOS7)
        {
            self.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
            
        }
        [DataHelper setExtraCellLineHidden:self];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    HeadLineCell *cell = (HeadLineCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[HeadLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];;
    }
    
    cell.typeString = _typeString;
    HeadlineModel *model = self.data[indexPath.row];
    [cell refreshUIWithModel:model];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kTableViewHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
}

@end
