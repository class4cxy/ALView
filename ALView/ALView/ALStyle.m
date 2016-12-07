//
//  ALStyle.m
//  ALView
//
//  Created by 陈小雅 on 2016/12/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALStyle.h"

@interface ALStyle ()
{
    // layout 值是记录最终排版的值，跟view.frame.size的值有一定差异
    CGFloat _layoutWidth;
    CGFloat _layoutHeight;
    
    CGFloat _layoutTop;
    CGFloat _layoutLeft;
    CGFloat _layoutRight;
    CGFloat _layoutBottom;
}

@end

@implementation ALStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isAutoHeight = YES;
        _isAutoWidth = YES;
        
        _hasSettedTop = NO;
        _hasSettedLeft = NO;
        _hasSettedRight = NO;
        _hasSettedBottom = NO;
        _hasSettedCenterX = NO;
        _hasSettedCenterY = NO;
        
        _layoutWidth = 0;
        _layoutHeight = 0;
        _layoutTop = 0;
        _layoutLeft = 0;
        _layoutRight = 0;
        _layoutBottom = 0;
    }
    return self;
}

#pragma mark - 重装属性赋值
- (void)setWidth: (CGFloat) width
{
    _isAutoWidth = NO;
    if ( width < 0 ) { width = 0; }
    _width = width;
}

- (void)setHeight: (CGFloat) height
{
    _isAutoHeight = NO;
    if ( height < 0 ) { height = 0; }
    _height = height;
}

- (void)setTop: (CGFloat) top
{
    _hasSettedTop = YES;
    _top = top;
}

- (void)setLeft: (CGFloat) left
{
    _hasSettedLeft = YES;
    _left = left;
}

- (void)setRight: (CGFloat) right
{
    _hasSettedRight = YES;
    _right = right;
}

- (void)setBottom: (CGFloat) bottom
{
    _hasSettedBottom = YES;
    _bottom = bottom;
}

- (void)setCenterX: (CGFloat) centerX
{
    _hasSettedCenterX = YES;
    _centerX = centerX;
}

- (void)setCenterY: (CGFloat) centerY
{
    _hasSettedCenterY = YES;
    _centerY = centerY;
}

- (void)setMargin: (CGFloat) margin
{
    _margin = margin;
    _marginTop = margin;
    _marginLeft = margin;
    _marginRight = margin;
    _marginBottom = margin;
}

- (void)setPadding: (CGFloat) padding
{
    _padding = padding;
    _paddingTop = padding;
    _paddingLeft = padding;
    _paddingRight = padding;
    _paddingBottom = padding;
}

@end
