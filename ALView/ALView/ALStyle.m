//
//  ALStyle.m
//  ALView
//
//  Created by 陈小雅 on 2016/12/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALStyle.h"
#import "UIView+ALEngine.h"

@implementation ALStyle

@synthesize center = _center;
@synthesize margin = _margin;
@synthesize padding = _padding;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _hidden = NO;
        
        _isEndOFLine = NO;
        _isAutoHeight = YES;
        _isAutoWidth = YES;
        
        _hasSettedTop = NO;
        _hasSettedLeft = NO;
        _hasSettedRight = NO;
        _hasSettedBottom = NO;
        _hasSettedCenterX = NO;
        _hasSettedCenterY = NO;
    }
    return self;
}

#pragma mark - 重装属性赋值
- (void) setWidth: (CGFloat) width
{
    _isAutoWidth = NO;
    if ( width < 0 ) { width = 0; }
    if ( _display != ALDisplayBlock && _maxWidth && width > _maxWidth ) { width = _maxWidth; }

    _width = width;
    
    if ( _view ) {
        [_view reflowWidth];
        [_view reflowWhenWidthChange];
    }
}
- (void) setWidthWithoutAutoWidth:(CGFloat)width
{
    if ( width < 0 ) { width = 0; }
    if ( _display != ALDisplayBlock && _maxWidth && width > _maxWidth ) { width = _maxWidth; }
    
    _width = width;
}

- (void) setHeight: (CGFloat) height
{
    _isAutoHeight = NO;
    if ( height < 0 ) { height = 0; }
    if ( _maxHeight && height > _maxHeight ) { height = _maxHeight; }

    _height = height;
    
    if ( _view ) {
        [_view reflowHeight];
        [_view reflowWhenHeightChange];
    }
}
- (void) setHeightWithoutAutoHeight:(CGFloat)height
{
    if ( height < 0 ) { height = 0; }
    if ( _maxHeight && height > _maxHeight ) { height = _maxHeight; }
    
    _height = height;
}

- (void) setMaxWidth:(CGFloat) maxWidth
{
    if ( _display != ALDisplayBlock ) {
        if ( _width > maxWidth ) {
            _width = maxWidth;
        }
        _maxWidth = maxWidth;
    }
}

- (void) setMaxHeight:(CGFloat) maxHeight
{
    if ( _height > maxHeight ) {
        _height = maxHeight;
    }
    _maxHeight = maxHeight;
}

- (void) setSize: (CGSize) size
{
    self.width = size.width;
    self.height = size.height;
    _size = size;
}

- (CGSize) getSize
{
    return CGSizeMake(_width, _height);
}

- (void) setOrigin: (ALRect) origin
{
    if ( origin.top ) {
        _hasSettedTop = YES;
        _top = origin.top;
    }
    if ( origin.left ) {
        _hasSettedLeft = YES;
        _left = origin.left;
    }
    if ( origin.right ) {
        _hasSettedRight = YES;
        _right = origin.right;
    }
    if ( origin.bottom ) {
        _hasSettedBottom = YES;
        _bottom = origin.bottom;
    }

    _origin = origin;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}
- (ALRect) getOrigin
{
    return (ALRect){_top, _left, _bottom, _right};
}

- (void)setTop: (CGFloat) top
{
    _hasSettedTop = YES;
    _top = top;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}

- (void)setLeft: (CGFloat) left
{
    _hasSettedLeft = YES;
    _left = left;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}

- (void)setRight: (CGFloat) right
{
    _hasSettedRight = YES;
    _right = right;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}

- (void)setBottom: (CGFloat) bottom
{
    _hasSettedBottom = YES;
    _bottom = bottom;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}

- (CGPoint)center
{
    return (CGPoint) {_centerX, _centerY};
}

- (void) setCenter: (CGPoint) center
{
    self.centerX = center.x;
    self.centerY = center.y;
    _center = center;
}

- (void) setCenterX: (CGFloat) centerX
{
    _hasSettedCenterX = YES;
    _centerX = centerX;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}

- (void)setCenterY: (CGFloat) centerY
{
    _hasSettedCenterY = YES;
    _centerY = centerY;
    
    if ( _view ) {
        [_view reflowOriginWhenAbsolute];
    }
}

- (void) setMarginTop:(CGFloat)marginTop
{
    _marginTop = marginTop;
    if ( _view ) {
        [_view reflowWhenMarginYChange: ALMarginTop];
    }
}

- (void) setMarginBottom:(CGFloat)marginBottom
{
    _marginBottom = marginBottom;
    if ( _view ) {
        [_view reflowWhenMarginYChange: ALMarginBottom];
    }
}

- (void) setMarginLeft:(CGFloat)marginLeft
{
    _marginLeft = marginLeft;
    if ( _view ) {
        [_view reflowWhenMarginXChange: ALMarginLeft];
    }
}

- (void) setMarginRight:(CGFloat)marginRight
{
    _marginRight = marginRight;
    if ( _view ) {
        [_view reflowWhenMarginXChange: ALMarginRight];
    }
}

- (void)setMargin: (ALRect) margin
{
    _margin = margin;
    _marginTop = margin.top;
    _marginLeft = margin.left;
    _marginRight = margin.right;
    _marginBottom = margin.bottom;
    
    if ( _view ) {
        [_view reflowWhenMarginYChange: ALMarginTop];
        [_view reflowWhenMarginXChange: ALMarginLeft];
    }
}

- (ALRect) margin
{
    return (ALRect) {_marginTop, _marginLeft, _marginBottom, _marginRight};
}

- (void)setPadding: (ALRect) padding
{
    _padding = padding;
    _paddingTop = padding.top;
    _paddingLeft = padding.left;
    _paddingRight = padding.right;
    _paddingBottom = padding.bottom;
}

- (ALRect) padding
{
    return (ALRect) {_paddingTop, _paddingLeft, _paddingBottom, _paddingRight};
}

- (void) setHidden:(BOOL)hidden
{
    _hidden = hidden;
    if ( _view ) {
        _view.hidden = hidden;
        [_view reflowWhenHiddenChange];
    }
}

@end
