//
//  NearByUIViewCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "NearByUIViewCell.h"

#define CELL_HEIGHT 86
#define CELL_WIDTH [[UIScreen mainScreen] bounds].size.width

@implementation NearByUIViewCell

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
    _avatar = [[UIImageView alloc] initWithFrame: CGRectMake(10, (CELL_HEIGHT-70)/2, 70, 70)];
    _avatar.layer.cornerRadius = 35;
    _avatar.clipsToBounds = YES;
    [self addSubview:_avatar];
    
    CGFloat avatarRight = CGRectGetMaxX(_avatar.frame)+10;
    
    // 昵称
    _nick = [[UILabel alloc] initWithFrame:CGRectMake(avatarRight, 15, 0, 0)];
    _nick.font = [UIFont systemFontOfSize:18];
    _nick.numberOfLines = 1;
    [self addSubview:_nick];
    
    // 年龄性别标签
    _ageView = [[UIView alloc] initWithFrame:CGRectMake(avatarRight, 0, 0, 14)];
    _ageView.backgroundColor = [UIColor colorWithRed:252/255.0 green:181/255.0 blue:200/255.0 alpha:1];
    _ageView.layer.cornerRadius = 3;
    _ageView.clipsToBounds = YES;
    [self addSubview:_ageView];
    // 性别
    _sex = [[UIImageView alloc] initWithFrame: CGRectMake(6, 2, 8, 10)];
    [_ageView addSubview:_sex];
    // 年龄
    _age = [[UILabel alloc] initWithFrame:CGRectMake(6+8+2, 1, 0, 0)];
    _age.font = [UIFont systemFontOfSize:10];
    _age.textColor = [UIColor whiteColor];
    [_ageView addSubview:_age];
    // 个人职业标签
    _professionTag = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 14)];
    _professionTag.textAlignment = NSTextAlignmentCenter;
    _professionTag.backgroundColor = [UIColor colorWithRed:134/255.0 green:212/255.0 blue:241/255.0 alpha:1];
    _professionTag.layer.cornerRadius = 3;
    _professionTag.clipsToBounds = YES;
    _professionTag.font = [UIFont systemFontOfSize:10];
    _professionTag.textColor = [UIColor whiteColor];
    [self addSubview:_professionTag];
    //等级标签
    _charmLevelTag = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 14)];
    _charmLevelTag.textAlignment = NSTextAlignmentCenter;
    _charmLevelTag.backgroundColor = [UIColor colorWithRed:253/255.0 green:202/255.0 blue:99/255.0 alpha:1];
    _charmLevelTag.layer.cornerRadius = 3;
    _charmLevelTag.clipsToBounds = YES;
    _charmLevelTag.font = [UIFont systemFontOfSize:10];
    _charmLevelTag.textColor = [UIColor whiteColor];
    [self addSubview:_charmLevelTag];
    // 会员标签
    _vipTag = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 28, 14)];
    _vipTag.image = [UIImage imageNamed:@"lbs_nearbyfriend_vip_icon.png"];
    _vipTag.layer.cornerRadius = 3;
    _vipTag.clipsToBounds = YES;
    [self addSubview:_vipTag];
    
    // 喜爱icon
    _descIcon = [[UIImageView alloc] initWithFrame: CGRectMake(avatarRight, 0, 14, 14)];
    _descIcon.image = [UIImage imageNamed:@"lbs_nearbyfriend_tag_icon.png"];
    [self addSubview:_descIcon];
    // 个人喜爱或者描述
    _desc = [[UILabel alloc] initWithFrame:CGRectZero];
    _desc.font = [UIFont systemFontOfSize:14];
    _desc.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _desc.numberOfLines = 1;
    [self addSubview:_desc];
    
    // LBS信息
    _distance = [[UILabel alloc] initWithFrame:CGRectMake(0, 17, 0, 0)];
    _distance.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _distance.font = [UIFont systemFontOfSize:12];
    [self addSubview:_distance];
    
    // 共同标签
    _commonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commonLabel.font = [UIFont systemFontOfSize:12];
    _commonLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:_commonLabel];
}

- (void) setModel: (UserInfoModel *) model
{
    _avatar.image = [UIImage imageNamed: model.avatarUrl];
    
    _distance.text = model.distance;
    [_distance sizeToFit];
    CGRect distanceF = _distance.frame;
    distanceF.origin.x = CELL_WIDTH-10-distanceF.size.width;
    _distance.frame = distanceF;
    
    _commonLabel.text = model.commonLabel;
    [_commonLabel sizeToFit];
    CGRect commonLabelF = _commonLabel.frame;
    commonLabelF.origin.x = CELL_WIDTH-10-commonLabelF.size.width;
    commonLabelF.origin.y = CGRectGetMaxY(_distance.frame)+6;
    _commonLabel.frame = commonLabelF;
    
    _nick.text = model.nick;
    [_nick sizeToFit];
    CGRect nickF = _nick.frame;
    nickF.size.width = CELL_WIDTH-90-distanceF.size.width-10;
    _nick.frame = nickF;

    // 女
    if ( model.sex == 1 ) {
        _sex.image = [UIImage imageNamed: @"lbs_nearbyfriend_female_icon.png"];
    } else {
        _sex.image = [UIImage imageNamed: @"lbs_nearbyfriend_male_icon.png"];
    }
    
    CGRect ageViewF = _ageView.frame;
    if ( model.age > 0 ) {
        _age.hidden = NO;
        _age.text = [NSString stringWithFormat:@"%ld", (long)model.age];
        [_age sizeToFit];
        ageViewF.size.width = CGRectGetMaxX(_age.frame) + 6;
    } else {
        _age.hidden = YES;
        ageViewF.size.width = CGRectGetMaxX(_sex.frame) + 6;
    }
    ageViewF.origin.y = CGRectGetMaxY(_nick.frame) + 3;
    _ageView.frame = ageViewF;
    
    if ( model.professionTag ) {
        _professionTag.hidden = NO;
        _professionTag.text = model.professionTag;
        [_professionTag sizeToFit];
        CGRect professionTagF = _professionTag.frame;
        professionTagF.origin = CGPointMake(CGRectGetMaxX(_ageView.frame) + 2, CGRectGetMinY(_ageView.frame));
        professionTagF.size = CGSizeMake(professionTagF.size.width + 12, 14);
        _professionTag.frame = professionTagF;
    } else {
        _professionTag.hidden = YES;
    }
    
    if ( model.charmLevelTag ) {
        _charmLevelTag.hidden = NO;
        _charmLevelTag.text = model.charmLevelTag;
        [_charmLevelTag sizeToFit];
        CGRect charmLevelTagF = _charmLevelTag.frame;
        if ( _professionTag.hidden ) {
            charmLevelTagF.origin = CGPointMake(CGRectGetMaxX(_ageView.frame) + 2, CGRectGetMinY(_ageView.frame));
        } else {
            charmLevelTagF.origin = CGPointMake(CGRectGetMaxX(_professionTag.frame) + 2, CGRectGetMinY(_ageView.frame));
        }
        charmLevelTagF.size = CGSizeMake(charmLevelTagF.size.width + 12, 14);
        _charmLevelTag.frame = charmLevelTagF;
    } else {
        _charmLevelTag.hidden = YES;
    }
    
    if ( model.isVip ) {
        _vipTag.hidden = NO;
        CGRect vipTagF = _vipTag.frame;
        if ( _charmLevelTag.hidden ) {
            if ( _professionTag.hidden ) {
                vipTagF.origin = CGPointMake(CGRectGetMaxX(_ageView.frame) + 2, CGRectGetMinY(_ageView.frame));
            } else {
                vipTagF.origin = CGPointMake(CGRectGetMaxX(_professionTag.frame) + 2, CGRectGetMinY(_ageView.frame));
            }
        } else {
            vipTagF.origin = CGPointMake(CGRectGetMaxX(_charmLevelTag.frame) + 2, CGRectGetMinY(_ageView.frame));
        }
        _vipTag.frame = vipTagF;
        _nick.textColor = [UIColor redColor];
    } else {
        _vipTag.hidden = YES;
        _nick.textColor = [UIColor blackColor];
    }
    
    if ( model.interest ) {
        _descIcon.hidden = NO;
        CGRect descIconF = _descIcon.frame;
        descIconF.origin.y = CGRectGetMaxY(_ageView.frame) + 5;
        _descIcon.frame = descIconF;
        
        _desc.text = model.interest;
        [_desc sizeToFit];
        CGRect descF = _desc.frame;
        descF.size.width = CELL_WIDTH-90-CGRectGetWidth(_descIcon.frame)-3-10;
        descF.origin = CGPointMake(CGRectGetMaxX(descIconF)+3, CGRectGetMinY(descIconF)-2);
        _desc.frame = descF;
    } else {
        _descIcon.hidden = YES;
        _desc.text = model.richStateText;
        [_desc sizeToFit];
        CGRect descF = _desc.frame;
        descF.size.width = CELL_WIDTH-90-10;
        descF.origin = CGPointMake(CGRectGetMinX(_ageView.frame), CGRectGetMaxY(_ageView.frame) + 3);
        _desc.frame = descF;
    }
}

@end
