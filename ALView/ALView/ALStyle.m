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

    _width = width + _paddingLeft + _paddingRight;
    
    if ( _view ) {
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

    _height = height + _paddingTop + _paddingBottom;
    
    if ( _view ) {
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
    if ( origin.top ) { self.top = origin.top; }
    if ( origin.left ) { self.left = origin.left; }
    if ( origin.right ) { self.right = origin.right; }
    if ( origin.bottom ) { self.bottom = origin.bottom; }

    _origin = origin;
}
- (ALRect) getOrigin
{
    return (ALRect){_top, _left, _bottom, _right};
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
}

- (void)setCenterY: (CGFloat) centerY
{
    _hasSettedCenterY = YES;
    _centerY = centerY;
}

- (void) setMarginTop:(CGFloat)marginTop
{
    _marginTop = marginTop;
    if ( _view ) {
        [_view reflowWhenMarginYChange];
    }
}

- (void) setMarginBottom:(CGFloat)marginBottom
{
    _marginBottom = marginBottom;
    if ( _view ) {
        [_view reflowWhenMarginYChange];
    }
}

- (void) setMarginLeft:(CGFloat)marginLeft
{
    _marginLeft = marginLeft;
    if ( _view ) {
        [_view reflowWhenMarginXChange];
    }
}

- (void) setMarginRight:(CGFloat)marginRight
{
    _marginRight = marginRight;
    if ( _view ) {
        [_view reflowWhenMarginXChange];
    }
}

- (void)setMargin: (ALRect) margin
{
    _margin = margin;
    _marginTop = margin.top;
    _marginLeft = margin.left;
    _marginRight = margin.right;
    _marginBottom = margin.bottom;
}

- (ALRect) margin
{
    return (ALRect) {_marginTop, _marginLeft, _marginBottom, _marginRight};
}

- (void) setPaddingTop:(CGFloat)paddingTop
{
    if ( !_isAutoHeight ) {
        self.height += paddingTop;
    }
    _paddingTop = paddingTop;
}

- (void) setPaddingBottom:(CGFloat)paddingBottom
{
    if ( !_isAutoHeight ) {
        self.height += paddingBottom;
    }
    _paddingBottom = paddingBottom;
}

- (void) setPaddingLeft:(CGFloat)paddingLeft
{
    if ( !_isAutoWidth ) {
        self.width += paddingLeft;
    }
    _paddingLeft = paddingLeft;
}

- (void) setPaddingRight:(CGFloat)paddingRight
{
    if ( !_isAutoWidth ) {
        self.width += paddingRight;
    }
    _paddingRight = paddingRight;
}

- (void)setPadding: (ALRect) padding
{
    _padding = padding;
    self.paddingTop = padding.top;
    self.paddingLeft = padding.left;
    self.paddingRight = padding.right;
    self.paddingBottom = padding.bottom;
}

- (ALRect) padding
{
    return (ALRect) {_paddingTop, _paddingLeft, _paddingBottom, _paddingRight};
}

@end
