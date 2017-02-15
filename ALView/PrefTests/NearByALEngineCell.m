//
//  NearByALEngineCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "NearByALEngineCell.h"

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
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 86);
    
    // 头像
    _avatar = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 70, 70)] translate2AbsoluteALView];
    _avatar.style.centerY = 0;
    _avatar.style.left = 10;
    _avatar.layer.cornerRadius = 35;
    _avatar.clipsToBounds = YES;
    [_avatar addTo: self];
    
    // 信息模块
    ALView * infoWrap = [ALView newAbsoluteView];
    infoWrap.style.centerY = 0;
    infoWrap.style.left = 95;
    infoWrap.style.width = CGRectGetWidth(self.frame) - 95 - 10;
    [infoWrap addTo: self];
    
    // 昵称
    _nick = [ALLabel new];
    _nick.style.marginBottom = 5;
    _nick.style.isEndOFLine = YES;
    _nick.font = [UIFont systemFontOfSize:16];
    _nick.numberOfLines = 1;
    [_nick addTo: infoWrap];
    
    // 年龄性别标签
    _ageView = [ALView newInlineView];
    _ageView.style.margin = (ALRect) {0, 2, 5, 0};
    _ageView.style.isFirstOFLine = YES;
    _ageView.backgroundColor = [UIColor colorWithRed:255/255 green:180.0/255.0 blue:200.0/255.0 alpha:1];
    _ageView.layer.cornerRadius = 2;
    _ageView.clipsToBounds = YES;
    [_ageView addTo: infoWrap];
    // 性别
    _sex = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 10, 10)] translate2InlineALView];
    [_sex addTo:_ageView];
    // 年龄
    _age = [ALLabel new];
    _age.font = [UIFont systemFontOfSize:10];
    _age.textColor = [UIColor whiteColor];
    [_age addTo: _ageView];
    // 个人职业标签
    _professionTag = [ALLabel new];
    _professionTag.style.margin = (ALRect) {0, 2, 5, 0};
    _professionTag.backgroundColor = [UIColor colorWithRed:129.0/255.0 green:212.0/255.0 blue:243.0/255.0 alpha:1];
    _professionTag.layer.cornerRadius = 2;
    _professionTag.clipsToBounds = YES;
    _professionTag.font = [UIFont systemFontOfSize:10];
    _professionTag.textColor = [UIColor whiteColor];
    [_professionTag addTo: infoWrap];
    // 等级标签
    _charmLevelTag = [ALLabel new];
    _charmLevelTag.backgroundColor = [UIColor colorWithRed:255/255 green:171.0/255.0 blue:171.0/255.0 alpha:1];
    _charmLevelTag.layer.cornerRadius = 2;
    _charmLevelTag.clipsToBounds = YES;
    _charmLevelTag.font = [UIFont systemFontOfSize:10];
    _charmLevelTag.textColor = [UIColor whiteColor];
    [_charmLevelTag addTo: infoWrap];
    // 喜爱icon
    _descIcon = [[[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 14, 14)] translate2InlineALView];
    _descIcon.image = [UIImage imageNamed:@"lbs_nearbyfriend_tag_icon.png"];
    _descIcon.style.isFirstOFLine = YES;
    [_descIcon addTo: infoWrap];
    // 个人描述或者喜爱
    _desc = [ALLabel new];
    _desc.font = [UIFont systemFontOfSize:12];
    _desc.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _desc.numberOfLines = 1;
    [_desc addTo: infoWrap];
    
    // 距离模块
    ALView * distWrap = [ALView newAbsoluteView];
    distWrap.style.contentAlign = ALContentAlignRight;
    distWrap.style.origin = (ALRect) {20, 10, 0, 0};
    [distWrap addTo: self];
    
    // 距离
    _distance = [ALLabel new];
    _distance.style.isEndOFLine = YES;
    _distance.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    _distance.font = [UIFont systemFontOfSize:12];
    [_distance addTo: distWrap];
    
    // 共同标签
    _commonLabel= [ALLabel new];
    _commonLabel.font = [UIFont systemFontOfSize:12];
    [_commonLabel addTo: distWrap];
}

- (void) setModel: (UserInfoModel *) model
{
    _avatar.image = [UIImage imageNamed: model.avatarUrl];
    _nick.text = model.nick;
    // 女
    if ( model.sex == 1 ) {
        _sex.image = [UIImage imageNamed: @"lbs_nearbyfriend_icon_female.png"];
    } else {
        _sex.image = [UIImage imageNamed: @"lbs_nearbyfriend_icon_male.png"];
    }
    
    if ( model.age > 0 ) {
        _age.text = [NSString stringWithFormat:@"%ld", model.age];
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
    if ( model.interest ) {
        _descIcon.style.hidden = NO;
        _desc.text = model.interest;
    } else {
        _descIcon.style.hidden = YES;
        _desc.text = model.richStateText;
    }
    
    _distance.text = model.distance;
    _commonLabel.text = model.commonLabel;
}

@end
