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

- (instancetype) initAbsolute
{
    if ( self = [super initALEngine] ) {
        self.style.display = ALDisplayInline;
        self.style.position = ALPositionAbsolute;
    }
    return self;
}

+ (instancetype) newAbsolute
{
    return [[self alloc] initAbsolute];
}

#pragma mark - 重载父类方法
/*
 * 增加默认行为：setText时如果isAutoWidth & isAutoHeight 为YES时，需自动调整宽高
 */
- (void)setText:(NSString *)text
{
    [super setText: text];
    [self layoutSize];
}

- (void) layoutSize
{
    if ( self.node.parent ) {
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
}

- (CGSize) reCountSize
{
    CGSize fontSize;
    // 固定宽高
    if ( !self.style.isAutoWidth && !self.style.isAutoHeight ) {
        fontSize.width = self.style.width;
        fontSize.height = self.style.height;
    // 自动高，固定宽
    } else if ( self.style.isAutoHeight && !self.style.isAutoWidth ) {
        fontSize = [self sizeThatFits:CGSizeMake(self.style.width, MAXFLOAT)];
        // sizeThatFits也会重新计算过width值，这里需要重置回来
        fontSize.width = self.style.width;
    
    // 自动宽，固定高
    } else if ( self.style.isAutoWidth && !self.style.isAutoHeight ) {
        fontSize = [self sizeThatFits:CGSizeMake(MAXFLOAT, self.style.height)];
        // sizeThatFits也会重新计算过height值，这里需要重置回来
        fontSize.height = self.style.height;
    // 自动宽高
    } else {
        CGFloat maxWidth = [self.style getBelongRowMaxWidth];
        CGFloat width = maxWidth - self.style.paddingLeft - self.style.paddingRight;
        fontSize = [self sizeThatFits:CGSizeMake(width, MAXFLOAT)];
        if ( fontSize.width > width ) {
            fontSize.width = width;
        }
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
