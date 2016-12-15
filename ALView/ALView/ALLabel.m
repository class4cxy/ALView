//
//  ALLabel.m
//  ALView
//
//  Created by jdochen on 2016/11/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALLabel.h"
#import "UIView+ALEngine.h"

@implementation ALLabel

- (instancetype) init
{
    if ( self = [super initWithALEngine] ) {
        self.style.display = ALDisplayInline;
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
        CGFloat maxWidth = [self getRowMaxWidthOf: parent];
        if ( fontSize.width + self.style.paddingRight + self.style.paddingLeft > maxWidth ) {
            fontSize.width = self.belongRow.maxWidth - self.style.paddingLeft - self.style.paddingRight;
        }
        // 自动高度 & 自动宽度
        // 宽度自动，但不能大于父view宽度
        if ( self.style.isAutoHeight && self.style.isAutoWidth ) {
            // 如果numberOfLines不为0时，sizeThatFits的计算会以高度为准，所以在这种情况，就直接用原来的值就行了
            if ( self.numberOfLines == 0 ) {
                fontSize = [self sizeThatFits:CGSizeMake(fontSize.width, MAXFLOAT)];
            }
        // 自动高度 & 给定宽度
        // 根据给定的宽度自适应
        } else if ( self.style.isAutoHeight ) {
            fontSize = [self sizeThatFits:CGSizeMake(self.style.width, MAXFLOAT)];
            // sizeThatFits也会重新计算过width值，这里需要重置回来
            fontSize.width = self.style.width;
        // 自动宽度 & 给定高度
        // 宽度自动，但不能大于父view宽度，高度使用给定的高度
        } else if ( self.style.isAutoWidth ) {
            fontSize = [self sizeThatFits:CGSizeMake(fontSize.width, self.style.height)];
            // sizeThatFits也会重新计算过height值，这里需要重置回来
            fontSize.height = self.style.height;
        // 如果都有设置了宽高，那就按设置的来
        } else {
            fontSize.width = self.style.width;
            fontSize.height = self.style.height;
        }
        // padding是会导致内增高的
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fontSize.width + self.style.paddingLeft + self.style.paddingRight, fontSize.height + self.style.paddingTop + self.style.paddingBottom);
        
        // 更新内部值
        [self.style setWidthWithoutAutoWidth: fontSize.width];
        [self.style setHeightWithoutAutoHeight: fontSize.height];
    }
}

- (void) drawTextInRect:(CGRect)rect
{
    // 增加padding计算逻辑
    UIEdgeInsets inset = UIEdgeInsetsMake(self.style.paddingTop, self.style.paddingLeft, self.style.paddingBottom, self.style.paddingRight);
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, inset)];
}

@end
