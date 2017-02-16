//
//  NearByALEngineCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "NearByALEngineCell.h"

#define CELL_HEIGHT 86
#define CELL_WIDTH [[UIScreen mainScreen] bounds].size.width

@implementation NearByALEngineCell


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
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, CELL_HEIGHT);
    
    // 头像
    _avatar = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 70, 70)] translate2AbsoluteALView];
    _avatar.style.centerY = 0;
    _avatar.style.left = 10;
    _avatar.layer.cornerRadius = 35;
    _avatar.clipsToBounds = YES;
    [_avatar addTo: self];
    
    // 昵称
    _nick = [ALLabel new];
    _nick.style.margin = (ALRect) {15, 0, 0, 90};
    _nick.font = [UIFont systemFontOfSize:18];
    _nick.numberOfLines = 1;
    [_nick addTo: self];
    
    ALView * tagWrap = [ALView new];
    tagWrap.style.margin = (ALRect) {3, 0, 3, 90};
    [tagWrap addTo: self];
    // 年龄性别标签
    _ageView = [ALView newInlineView];
    _ageView.style.marginRight = 2;
    _ageView.style.height = 14;
    _ageView.backgroundColor = [UIColor colorWithRed:252/255.0 green:181/255.0 blue:200/255.0 alpha:1];
    _ageView.layer.cornerRadius = 3;
    _ageView.clipsToBounds = YES;
    [_ageView addTo: tagWrap];
    // 性别
    _sex = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 8, 10)] translate2InlineALView];
    _sex.style.margin = (ALRect) {2, 2, 0, 6};
    [_sex addTo:_ageView];
    // 年龄
    _age = [ALLabel new];
    _age.style.margin = (ALRect){1, 6, 0, 0};
    _age.font = [UIFont systemFontOfSize:10];
    _age.textColor = [UIColor whiteColor];
    [_age addTo: _ageView];
    // 个人职业标签
    _professionTag = [ALLabel new];
    _professionTag.style.marginRight = 2;
    _professionTag.style.height = 14;
    _professionTag.style.padding = (ALRect) {0, 6, 0, 6};
    _professionTag.backgroundColor = [UIColor colorWithRed:134/255.0 green:212/255.0 blue:241/255.0 alpha:1];
    _professionTag.layer.cornerRadius = 3;
    _professionTag.clipsToBounds = YES;
    _professionTag.font = [UIFont systemFontOfSize:10];
    _professionTag.textColor = [UIColor whiteColor];
    [_professionTag addTo: tagWrap];
    // 等级标签
    _charmLevelTag = [ALLabel new];
    _charmLevelTag.style.height = 14;
    _charmLevelTag.style.marginRight = 2;
    _charmLevelTag.style.padding = (ALRect) {0, 6, 0, 6};
    _charmLevelTag.backgroundColor = [UIColor colorWithRed:253/255.0 green:202/255.0 blue:99/255.0 alpha:1];
    _charmLevelTag.layer.cornerRadius = 3;
    _charmLevelTag.clipsToBounds = YES;
    _charmLevelTag.font = [UIFont systemFontOfSize:10];
    _charmLevelTag.textColor = [UIColor whiteColor];
    [_charmLevelTag addTo: tagWrap];
    // 会员标签
    _vipTag = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 28, 14)] translate2InlineALView];
    _vipTag.image = [UIImage imageNamed:@"lbs_nearbyfriend_vip_icon.png"];
    _vipTag.layer.cornerRadius = 3;
    _vipTag.clipsToBounds = YES;
    [_vipTag addTo: tagWrap];
    
    ALView * descWrap = [ALView new];
    descWrap.style.marginLeft = 90;
    [descWrap addTo:self];
    // 喜爱icon
    _descIcon = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 14, 14)] translate2AbsoluteALView];
    _descIcon.image = [UIImage imageNamed:@"lbs_nearbyfriend_tag_icon.png"];
    _descIcon.style.centerY = 0;
    [_descIcon addTo: descWrap];
    // 个人描述或者喜爱
    _desc = [ALLabel new];
    _desc.font = [UIFont systemFontOfSize:14];
    _desc.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _desc.numberOfLines = 1;
    [_desc addTo: descWrap];
    
    // 距离模块
    _distWrap = [ALView newAbsoluteView];
    _distWrap.style.contentAlign = ALContentAlignRight;
    _distWrap.style.origin = (ALRect) {17, 10, 0, 0};
    [_distWrap addTo: self];
    
    // 距离
    _distance = [ALLabel new];
    _distance.style.isEndOFLine = YES;
    _distance.style.marginBottom = 6;
    _distance.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _distance.font = [UIFont systemFontOfSize:12];
    [_distance addTo: _distWrap];
    
    // 共同标签
    _commonLabel= [ALLabel new];
    _commonLabel.font = [UIFont systemFontOfSize:12];
    _commonLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [_commonLabel addTo: _distWrap];
}

- (void) setModel: (UserInfoModel *) model
{
    _avatar.image = [UIImage imageNamed: model.avatarUrl];
    // 女
    if ( model.sex == 1 ) {
        _sex.image = [UIImage imageNamed: @"lbs_nearbyfriend_female_icon.png"];
    } else {
        _sex.image = [UIImage imageNamed: @"lbs_nearbyfriend_male_icon.png"];
    }
    
    if ( model.age > 0 ) {
        _age.text = [NSString stringWithFormat:@"%ld", (long)model.age];
    }
    
    if ( model.professionTag ) {
        _professionTag.text = model.professionTag;
        _professionTag.style.hidden = NO;
    } else {
        _professionTag.style.hidden = YES;
    }
    
    if ( model.charmLevelTag ) {
        _charmLevelTag.text = model.charmLevelTag;
        _charmLevelTag.style.hidden = NO;
    } else {
        _charmLevelTag.style.hidden = YES;
    }
    
    if ( model.isVip ) {
        _vipTag.style.hidden = NO;
        _nick.textColor = [UIColor redColor];
    } else {
        _vipTag.style.hidden = YES;
        _nick.textColor = [UIColor blackColor];
    }
    
    if ( model.interest ) {
        _descIcon.style.hidden = NO;
        _desc.style.marginLeft = 17;
        _desc.text = model.interest;
    } else {
        _descIcon.style.hidden = YES;
        _desc.style.marginLeft = 0;
        _desc.text = model.richStateText;
    }
    
    _distance.text = model.distance;
    _commonLabel.text = model.commonLabel;
    
    _nick.style.width = CELL_WIDTH - 90 - 10 - _distWrap.style.width;
    _nick.text = model.nick;
}

@end
