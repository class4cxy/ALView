//
//  ALLabel.m
//  ALView
//
//  Created by jdochen on 2016/11/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALLabel.h"
#import "UIView+ALEngine.h"
//#import "ALLayout.h"

@implementation ALLabel

- (instancetype) init
{
    if ( self = [super initALEngine] ) {
        self.style.display = ALDisplayInline;
    }
    return self;
}

- (instancetype) initWithAbsolute
{
    if ( self = [super initALEngine] ) {
        self.style.display = ALDisplayInline;
        self.style.position = ALPositionAbsolute;
    }
    return self;
}

+ (instancetype) newWithAbsolute
{
    return [[self alloc] initAbsoluteView];
}

#pragma mark - 重载父类方法
/*
 * 增加默认行为：setText时如果isAutoWidth & isAutoHeight 为YES时，需自动调整宽高
 */
- (void)setText:(NSString *)text
{
    [super setText: text];
    if ( self.node.parent ) {
        [self layoutSize];
    }
}

- (void) layoutSize
{
    CGSize newSize = [self reCountSize];
    BOOL isHeightChange = newSize.height != self.style.height;
    BOOL isWidthChange = newSize.width != self.style.width;
    
    if ( !CGSizeEqualToSize(newSize, self.style.size) ) {
        [self.style layoutWithSize: newSize];
    }
    // 触发响应的重排
    if ( isHeightChange ) {
        [self.style reflowWhenHeightChange];
        // 更新行信息
        [self.belongRow refreshHeight];
    }
    if ( isWidthChange ) {
        [self.style reflowWhenWidthChange];
        // 更新行信息
        [self.belongRow refreshWidth];
    }
}

- (CGSize) reCountSize
{
    // 根据font大小动态计算
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    // label的宽度不能超过parent的宽度
    CGFloat maxWidth = [self.style getBelongRowMaxWidth];

    if ( fontSize.width + self.style.paddingRight + self.style.paddingLeft > maxWidth ) {
        fontSize.width = maxWidth - self.style.paddingLeft - self.style.paddingRight;
    }
    // 自动高度 & 自动宽度
    // 宽度自动，但不能大于父view宽度
    if ( self.style.isAutoHeight && self.style.isAutoWidth ) {
        // 如果numberOfLines不为0时，sizeThatFits的计算会以高度为准，所以在这种情况，就直接用原来的值就行了
        if ( self.numberOfLines != 1 ) {
            CGFloat width = fontSize.width;
            fontSize = [self sizeThatFits:CGSizeMake(width, MAXFLOAT)];
            fontSize.width = width;
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
        fontSize = [self sizeThatFits:CGSizeMake(MAXFLOAT, self.style.height)];
        // sizeThatFits也会重新计算过height值，这里需要重置回来
        fontSize.height = self.style.height;
        // 如果都有设置了宽高，那就按设置的来
    } else {
        fontSize.width = self.style.width;
        fontSize.height = self.style.height;
    }
    
    fontSize.width += (self.style.paddingLeft + self.style.paddingRight);
    fontSize.height += (self.style.paddingTop + self.style.paddingBottom);
    
    return fontSize;
}

- (void) drawTextInRect:(CGRect)rect
{
    // 增加padding计算逻辑
    UIEdgeInsets inset = UIEdgeInsetsMake(self.style.paddingTop, self.style.paddingLeft, self.style.paddingBottom, self.style.paddingRight);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, inset)];
}

@end
