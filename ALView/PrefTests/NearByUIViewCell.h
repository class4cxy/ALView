//
//  NearByUIViewCell.h
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

@interface NearByUIViewCell : UITableViewCell
{
    UIImageView * _avatar;
    UILabel * _nick;
    UIImageView * _descIcon;
    UILabel * _desc;
    UIView * _ageView;
    UILabel * _age;
    UIImageView * _sex;
    UILabel * _professionTag;
    UILabel * _charmLevelTag;
    UIImageView * _vipTag;
    UILabel * _commonLabel;
    UILabel * _distance;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setModel: (UserInfoModel *) model;

@end
