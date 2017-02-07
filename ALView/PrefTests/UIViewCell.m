//
//  UIViewCell.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/7.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "UIViewCell.h"

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
    
}
- (void) setModel: (TableViewCellModel *) model
{
    
}

@end
