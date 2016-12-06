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
        self.alDisplay = ALDisplayInline;
    }
    return self;
}

-(void)setAlPadding:(CGFloat)alPadding
{
    _alPadding = alPadding;
    _alPaddingTop = alPadding;
    _alPaddingLeft = alPadding;
    _alPaddingBottom = alPadding;
    _alPaddingRight = alPadding;
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
        if ( fontSize.width + self.alPaddingRight + self.alPaddingLeft > parent.frame.size.width ) {
            fontSize.width = parent.frame.size.width - self.alPaddingLeft - self.alPaddingRight;
        }
        // 自动高度 & 自动宽度
        // 宽度自动，但不能大于父view宽度
        if ( self.alIsAutoHeight && self.alIsAutoWidth ) {
            // 如果numberOfLines不为0时，sizeThatFits的计算会以高度为准，所以在这种情况，就直接用原来的值就行了
            if ( self.numberOfLines == 0 ) {
                fontSize = [self sizeThatFits:CGSizeMake(fontSize.width, MAXFLOAT)];
            }
        // 自动高度 & 给定宽度
        // 根据给定的宽度自适应
        } else if ( self.alIsAutoHeight ) {
            fontSize = [self sizeThatFits:CGSizeMake(self.alWidth, MAXFLOAT)];
            // sizeThatFits也会重新计算过width值，这里需要重置回来
            fontSize.width = self.alWidth;
        // 自动宽度 & 给定高度
        // 宽度自动，但不能大于父view宽度，高度使用给定的高度
        } else if ( self.alIsAutoWidth ) {
            fontSize = [self sizeThatFits:CGSizeMake(fontSize.width, self.alHeight)];
            // sizeThatFits也会重新计算过height值，这里需要重置回来
            fontSize.height = self.alHeight;
        // 如果都有设置了宽高，那就按设置的来
        } else {
            fontSize.width = self.alWidth;
            fontSize.height = self.alHeight;
        }
        // padding是会导致内增高的
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fontSize.width + self.alPaddingLeft + self.alPaddingRight, fontSize.height + self.alPaddingTop + self.alPaddingBottom);
    }
}

- (void) drawTextInRect:(CGRect)rect
{
    // 增加padding计算逻辑
    UIEdgeInsets inset = UIEdgeInsetsMake(self.alPaddingTop, self.alPaddingLeft, self.alPaddingBottom, self.alPaddingRight);
    
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, inset)];
}

@end
