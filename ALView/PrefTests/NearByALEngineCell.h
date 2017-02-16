//
//  NearByALEngineCell.h
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ALEngine.h"
#import "UserInfoModel.h"

@interface NearByALEngineCell : UITableViewCell
{
    UIImageView * _avatar;
    ALLabel * _nick;
    UIImageView * _descIcon;
    ALLabel * _desc;
    ALView * _ageView;
    ALLabel * _age;
    UIImageView * _sex;
    ALLabel * _professionTag;
    ALLabel * _charmLevelTag;
    UIImageView * _vipTag;
    ALView * _distWrap;
    ALLabel * _commonLabel;
    ALLabel * _distance;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setModel: (UserInfoModel *) model;

@end
