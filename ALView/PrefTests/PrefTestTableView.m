//
//  PrefTestTableView.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/7.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "PrefTestTableView.h"
#import "TableViewCellModel.h"
#import "UIViewCell.h"
#import "ALEngineViewCell.h"

@interface PrefTestTableView() <UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _tableDataSource;
}

@end

@implementation PrefTestTableView

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
    NSArray * nicks = [NSArray arrayWithObjects:@"jdochen", @"simplehuang", @"maxsezhang", @"cirolong", @"justinytang", @"nicema", @"peterlmeng", @"xiangruli", nil];
    NSArray * counts = [NSArray arrayWithObjects:@"33", @"12", @"3", @"1", @"8", @"22", @"43", @"31", nil];
    NSArray * times = [NSArray arrayWithObjects:@"19:08", @"16:18", @"15:28", @"11:50", @"2月6日 10:43", @"1月24日 15:43", @"1月9日 15:50", @"1月19日 15:50", @"1月18日 20:26", @"1月18日 15:43", nil];
    NSArray * coverUrls = [NSArray arrayWithObjects:@"1.jpeg", @"2.jpeg", @"3.jpeg", @"4.jpeg", @"5.jpeg", @"6.jpeg", @"7.jpeg", @"8.jpeg", nil];
    int i = 0;
    _tableDataSource = [NSMutableArray new];
    
    for (; i < 1; i++) {
        TableViewCellModel * model = [TableViewCellModel new];
        model.avatarUrl = [NSString stringWithFormat:@"%@.png", [nicks objectAtIndex: (i%8)]];
        model.nick = [nicks objectAtIndex: (i%8)];
        model.count = [NSString stringWithFormat:@"%@个小视频", [counts objectAtIndex: (i%8)]];
        model.time = [times objectAtIndex: (i%10)];
        model.coverUrl = [coverUrls objectAtIndex: (i%8)];
        [_tableDataSource addObject:model];
    }
    [_tableView reloadData];
}

#pragma mark  Delegate And DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
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
    ALEngineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALEngine"];
    if (cell == nil)
    {
        cell = [[ALEngineViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ALEngine"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setModel:[_tableDataSource objectAtIndex:indexPath.row]];
    return cell;
}

@end
