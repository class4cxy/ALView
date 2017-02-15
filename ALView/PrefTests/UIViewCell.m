//
//  UIViewCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/7.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "UIViewCell.h"

#define CELL_HEIGHT 95
#define CELL_WIDTH [[UIScreen mainScreen] bounds].size.width

@implementation UIViewCell

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
    // 头像
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(10, (CELL_HEIGHT-50)/2, 50, 50)];
    _avatar.layer.cornerRadius = 25;
    _avatar.clipsToBounds = YES;
    [self addSubview: _avatar];
    
    CGFloat infoLeft = CGRectGetMaxX(_avatar.frame)+10;
    
    // 昵称
    _nick = [[UILabel alloc] initWithFrame: CGRectMake(infoLeft, 0, CELL_WIDTH - 70 - 70, 0)];
    _nick.font = [UIFont systemFontOfSize:18];
    _nick.numberOfLines = 1;
    [self addSubview: _nick];
    
    // 视频数量
    _count = [[UILabel alloc] initWithFrame: CGRectMake(infoLeft, 0, CELL_WIDTH - 70 - 70, 0)];
    _count.font = [UIFont systemFontOfSize:12];
    _count.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _count.numberOfLines = 1;
    [self addSubview: _count];
    
    // 拍摄时间
    _time = [[UILabel alloc] initWithFrame: CGRectMake(infoLeft, 0, CELL_WIDTH - 70 - 70, 0)];
    _time.font = [UIFont systemFontOfSize:12];
    _time.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _time.numberOfLines = 1;
    [self addSubview: _time];
    
    // 视频封面
    _cover = [[UIImageView alloc] initWithFrame: CGRectMake(CELL_WIDTH - 70, (CELL_HEIGHT-85)/2, 60, 85)];
    _cover.layer.cornerRadius = 5;
    _cover.clipsToBounds = YES;
    [self addSubview: _cover];
}
- (void) setModel: (TableViewCellModel *) model
{
    _avatar.image = [UIImage imageNamed: model.avatarUrl];
    _nick.text = model.nick;
    CGSize nickSize = [_nick sizeThatFits:CGSizeMake(_nick.frame.size.width, MAXFLOAT)];
    CGRect nickFrame = _nick.frame;
    nickFrame.size.height = nickSize.height;
    
    _count.text = model.count;
    CGSize countSize = [_count sizeThatFits:CGSizeMake(_nick.frame.size.width, MAXFLOAT)];
    CGRect countFrame = _count.frame;
    countFrame.size.height = countSize.height;
    
    _time.text = model.time;
    CGSize timeSize = [_time sizeThatFits:CGSizeMake(_nick.frame.size.width, MAXFLOAT)];
    CGRect timeFrame = _time.frame;
    timeFrame.size.height = timeSize.height;
    
    nickFrame.origin.y = (CELL_HEIGHT - (nickFrame.size.height + 5 + countFrame.size.height + 5 + timeFrame.size.height)) / 2;
    _nick.frame = nickFrame;
    
    countFrame.origin.y = CGRectGetMaxY(nickFrame) + 5;
    _count.frame = countFrame;
    
    timeFrame.origin.y = CGRectGetMaxY(countFrame) + 5;
    _time.frame = timeFrame;
    
    _cover.image = [UIImage imageNamed: model.coverUrl];
}

@end
