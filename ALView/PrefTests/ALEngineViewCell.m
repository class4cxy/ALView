//
//  ALEngineViewCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/7.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "ALEngineViewCell.h"

@implementation ALEngineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initUI];
    }
    return self;
}

- (void) initUI
{
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 95);
    // 头像
    _avatar = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 50, 50)] translate2AbsoluteALView];
    _avatar.style.centerY = 0;
    _avatar.style.left = 10;
    _avatar.layer.cornerRadius = 25;
    _avatar.clipsToBounds = YES;
    [_avatar addTo: self];

    // 信息模块
    ALView * infoWrap = [ALView newAbsoluteView];
    infoWrap.style.centerY = 0;
    infoWrap.style.left = 70;
    infoWrap.style.width = CGRectGetWidth(self.frame) - 70 - 70;
    [infoWrap addTo: self];
    
    // 昵称
    _nick = [ALLabel new];
    _nick.style.isEndOFLine = YES;
    _nick.font = [UIFont systemFontOfSize:16];
    _nick.numberOfLines = 0;
    [_nick addTo: infoWrap];
    // 视频数量
    _count = [ALLabel new];
    _count.style.margin = (ALRect) {5, 0, 5, 0};
    _count.style.isEndOFLine = YES;
    _count.font = [UIFont systemFontOfSize:12];
    _count.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _count.numberOfLines = 0;
    [_count addTo: infoWrap];
    // 拍摄时间
    _time = [ALLabel new];
    _time.font = [UIFont systemFontOfSize:12];
    _time.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _time.numberOfLines = 0;
    [_time addTo: infoWrap];

    // 封面
    _cover =  [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 60, 85)] translate2AbsoluteALView];
    _cover.style.centerY = 0;
    _cover.style.right = 10;
    _cover.layer.cornerRadius = 5;
    _cover.clipsToBounds = YES;
    [_cover addTo: self];
}

- (void) setModel: (TableViewCellModel *) model
{
    _avatar.image = [UIImage imageNamed: model.avatarUrl];
    _nick.text = model.nick;
    _count.text = model.count;
    _time.text = model.time;
    _cover.image = [UIImage imageNamed: model.coverUrl];
}

@end
