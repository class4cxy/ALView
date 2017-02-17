//
//  PerfTestNeatByTableView.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/14.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "PerfTestNeatByTableView.h"
#import "UserInfoModel.h"
#import "NearByALEngineCell.h"
#import "NearByUIViewCell.h"

@interface PerfTestNeatByTableView() <UITableViewDelegate, UITableViewDataSource>

{
    UITableView * _tableView;
    NSMutableArray * _tableDataSource;
    NSInteger _currentIndex;
}

@end

@implementation PerfTestNeatByTableView

- (instancetype) initWithFrame:(CGRect) frame
{
    if ( self = [super initWithFrame:frame] ) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.opaque = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [self addSubview: _tableView];
        [self initData];
    }
    return self;
}

- (void) initData
{
    NSArray * data = [NSArray arrayWithObjects: @"", nil];
    
    NSInteger avatarLen = 25;
    NSUInteger sourceLen = [data count];
    _tableDataSource = [NSMutableArray new];
    int i = 0;
    for (; i < sourceLen; i++) {
        NSDictionary * item = [data objectAtIndex: i];
        UserInfoModel * model = [[UserInfoModel alloc] init];
        model.avatarUrl = [NSString stringWithFormat:@"%ld.jpeg", (long)(140+(i%avatarLen))];
        model.nick = [NSString stringWithFormat:@"%d%@", i, [item objectForKey:@"nick"]];
        model.distance = [item objectForKey:@"description"];
        model.sex = [[item objectForKey:@"sex"] intValue];
        model.age = [[item objectForKey:@"age"] intValue];
        model.charmLevelTag = [item objectForKey:@"charmLevelTag"];
        model.professionTag = [item objectForKey:@"professionTag"];
        model.interest = [item objectForKey:@"interest"];
        model.richStateText = [item objectForKey:@"richStateText"];
        model.commonLabel = [item objectForKey:@"commonLabel"];
        model.isVip = [[item objectForKey:@"isVip"] intValue];
        [_tableDataSource addObject:model];
    }
    [_tableView reloadData];
    _currentIndex = 9;
    [self performSelector:@selector(autoRunTabelView) withObject:nil afterDelay:10.0];
}
- (void) autoRunTabelView
{
    if ( (_currentIndex += 10) >= [_tableDataSource count] ) {
        return;
    }
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self performSelector:@selector(autoRunTabelView) withObject:nil afterDelay:5.0];
}

#pragma mark  Delegate And DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByUIViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALEngine"];
    if (cell == nil)
    {
        cell = [[NearByUIViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ALEngine"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setModel:[_tableDataSource objectAtIndex:indexPath.row]];
    return cell;
}

@end
