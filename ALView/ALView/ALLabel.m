//
//  ALLabel.m
//  ALView
//
//  Created by jdochen on 2016/11/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALLabel.h"
#import "UIView+ALBase.h"

@implementation ALLabel

- (instancetype) init
{
    if ( self = [super initWithALBase] ) {
        self.display  = ALDisplayInline;
    }
    return self;
}

#pragma mark - 重载父类方法
/*
 * 增加默认行为：setText时如果isAutoWidth & isAutoHeight 为YES时，需自动调整宽高
 */
- (void)setText:(NSString *)text
{
    [super setText: text];
    [self reflowWithInnerText: self.superview];
}

- (void) reflowWithInnerText:(UIView *) parent
{
    if ( parent != nil ) {
        // 根据font大小动态计算
        CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
        // label的宽度不能超过parent的宽度
        if ( fontSize.width > parent.frame.size.width ) {
            fontSize.width = parent.frame.size.width;
        }
        // 自动高度 & 自动宽度
        // 宽度自动，但不能大于父view宽度
        if ( self.isAutoHeight && self.isAutoWidth ) {
            fontSize = [self sizeThatFits:CGSizeMake(fontSize.width, MAXFLOAT)];
        // 自动高度 & 给定宽度
        // 根据给定的宽度自适应
        } else if ( self.isAutoHeight ) {
            fontSize = [self sizeThatFits:CGSizeMake(self.width, MAXFLOAT)];
        // 自动宽度 & 给定高度
        // 宽度自动，但不能大于父view宽度，高度使用给定的高度
        } else if ( self.isAutoWidth ) {
            fontSize = [self sizeThatFits:CGSizeMake(fontSize.width, self.height)];
        // 如果都有设置了宽高，那就按设置的来
        } else {
            fontSize.width = self.width;
            fontSize.height = self.height;
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fontSize.width, fontSize.height);
    }
}

@end
