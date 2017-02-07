//
//  UIViewCell.h
//  ALView
//
//  Created by 陈小雅 on 2017/2/7.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellModel.h"

@interface UIViewCell : UITableViewCell
{
    UILabel * _nick;
    UILabel * _count;
    UILabel * time;
    UIImageView * _avatar;
    UIImageView * _cover;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) setModel: (TableViewCellModel *) model;

@end
