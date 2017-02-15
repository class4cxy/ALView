//
//  NearByUIViewCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/15.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "NearByUIViewCell.h"

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
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 86);
}

- (void) setModel: (UserInfoModel *) model
{
    
}

@end
