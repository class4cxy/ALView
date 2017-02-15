//
//  NearByUIViewCell.h
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ALEngine.h"
#import "UserInfoModel.h"

@interface NearByUIViewCell : UITableViewCell
{
    ALLabel * _nick;
    ALLabel * _count;
    ALLabel * _time;
    UIImageView * _avatar;
    UIImageView * _cover;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setModel: (UserInfoModel *) model;

@end
