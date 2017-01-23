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
        _isAutoHeight = YES;
        _isAutoWidth = YES;
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
        [self reflowWhenWidthChange];
//        [_view reflowWhenWidthChange];
    }
}

- (void) setHeight: (CGFloat) height
{
    _isAutoHeight = NO;
    if ( height < 0 ) { height = 0; }
    if ( _maxHeight && height > _maxHeight ) { height = _maxHeight; }

    _height = height;
    
    if ( _view ) {
        [_view reflowHeight];
        [self reflowWhenHeightChange];
//        [_view reflowWhenHeightChange];
    }
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
    
    if ( [self isCanReflow] ) {
        [self reflowWhenMarginChange: ALMarginTop];
    }
}

- (void) setMarginBottom:(CGFloat)marginBottom
{
    _marginBottom = marginBottom;
    
    if ( [self isCanReflow] ) {
        [self reflowWhenMarginChange: ALMarginBottom];
    }
}

- (void) setMarginLeft:(CGFloat)marginLeft
{
    _marginLeft = marginLeft;
    
    if ( [self isCanReflow] ) {
        [self reflowWhenMarginChange: ALMarginLeft];
    }
}

- (void) setMarginRight:(CGFloat)marginRight
{
    _marginRight = marginRight;
    
    if ( [self isCanReflow] ) {
        [self reflowWhenMarginChange: ALMarginRight];
    }
}

- (void)setMargin: (ALRect) margin
{
    _margin = margin;
    _marginTop = margin.top;
    _marginLeft = margin.left;
    _marginRight = margin.right;
    _marginBottom = margin.bottom;
    
    if ( [self isCanReflow] ) {
        [self reflowWhenMarginChange: ALMarginTop];
        [self reflowWhenMarginChange: ALMarginLeft];
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
        [self reflowWhenHiddenChange];
    }
}

#pragma mark - layout
- (void) layoutWithTop: (CGFloat) top
{
    CGRect f = _view.frame;
    f.origin.y = top;
    _view.frame = f;
    _y = top;
}

- (void) layoutWithLeft: (CGFloat) left
{
    CGRect f = _view.frame;
    f.origin.x = left;
    _view.frame = f;
    _x = left;
}

- (void) layoutWithOrigin: (CGPoint) origin
{
    CGRect f = _view.frame;
    f.origin = origin;
    _view.frame = f;
    _x = origin.x;
    _y = origin.y;
}

- (void) layoutWithWidth: (CGFloat) width
{
    CGRect f = _view.frame;
    f.size.width = width;
    _view.frame = f;
    // 如果autoWidth=YES
    if ( _isAutoWidth ) {
        // ALLabel需要减去padding才是真正的width
        if ( [_view isKindOfClass:[ALLabel class]] ) {
            width -= (_view.style.paddingLeft + _view.style.paddingRight);
        }
        _width = width;
    }
}

- (void) layoutWithHeight: (CGFloat) height
{
    CGRect f = _view.frame;
    f.size.height = height;
    _view.frame = f;
    // 如果autoHeight=YES
    if ( _isAutoHeight ) {
        // ALLabel需要减去padding才是真正的height
        if ( [_view isKindOfClass:[ALLabel class]] ) {
            height -= (_view.style.paddingTop + _view.style.paddingBottom);
        }
        _height = height;
    }
}

- (void) layoutWithSize: (CGSize) size
{
    [self layoutWithWidth: size.width];
    [self layoutWithHeight: size.height];
}

#pragma mark - reflow
- (BOOL) isCanReflow
{
    return _view && _view.superview && _view.isALEngine;
}
// hidden改变，重排
- (void) reflowWhenHiddenChange
{
    if ( [self isCanReflow] ) {
        if ( _position == ALPositionRelative ) {
            // 满足这两条件需重刷size
            if ( _hidden == NO && _isAutoWidth ) {
                // 排版size
                [_view reflowSize];
            }
            // 防止未知错误
            if ( _view.superview.rowManager ) {
                [_view.superview.rowManager reflowWhenYChange: _view need2reflowSelfTop: NO];
                // 如果isAutoWidth=YES或者contentAlign != ALContentAlignLeft，需重排内部子view
                if ( (_isAutoWidth || _contentAlign != ALContentAlignLeft) && _hidden == NO ) {
                    [_view.superview.rowManager reflowWhenXChange: _view need2ReflowSubView: YES];
                } else {
                    [_view.superview.rowManager reflowWhenXChange: _view need2ReflowSubView: NO];
                }
            }
        }
    }
}
// marginLeft/marginRight改变，重排
- (void) reflowWhenMarginChange: (ALMarginType) marginType
{
    if ( [self isCanReflow] ) {
        if ( _position == ALPositionRelative ) {
            // 防止未知错误
            if ( _view.superview.rowManager ) {
                switch (marginType) {
                    case ALMarginTop:
                    {
                        [_view.superview.rowManager reflowWhenYChange: _view need2reflowSelfTop: YES];
                    }
                        break;
                    case ALMarginBottom:
                    {
                        [_view.superview.rowManager reflowWhenYChange: _view need2reflowSelfTop: NO];
                    }
                        break;
                    case ALMarginLeft:
                    {
                        [_view.superview.rowManager reflowWhenXChange: _view need2ReflowSubView: NO];
                    }
                        break;
                    case ALMarginRight:
                    {
                        [_view.superview.rowManager reflowWhenXChange: _view need2ReflowSubView: NO];
                    }
                        break;
                    default:
                        break;
                }
            }
        }
    }
}
// width改变，重排
- (void) reflowWhenWidthChange
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( [self isCanReflow] ) {
        if ( _position == ALPositionRelative ) {
            // 防止未知错误
            if ( _view.superview.rowManager ) {
                [_view.superview.rowManager reflowWhenXChange: _view need2ReflowSubView: YES];
            }
        } else {
            if ( _view.rowManager ) {
                [_view.rowManager reflowSubView];
                [_view reflowSizeWhenAutoSize];
            }
            [_view reflowOriginWhenAbsolute];
        }
        
        [_view reflowSubviewWhichISAbsolute];
    }
}

// height改变，重排
- (void) reflowWhenHeightChange
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( [self isCanReflow] ) {
        // 重排row
        if ( _position == ALPositionRelative ) { // relative
            // 防止未知错误
            if ( _view.superview.rowManager ) {
                [_view.superview.rowManager reflowWhenYChange: _view need2reflowSelfTop: NO];
            }
        } else { // absolute
            [_view reflowOriginWhenAbsolute];
        }
        
        [_view reflowSubviewWhichISAbsolute];
    }
}
@end
