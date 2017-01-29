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

- (instancetype) initWithView: (UIView *) view
{
    self = [super init];
    if (self) {
        _isAutoHeight = YES;
        _isAutoWidth = YES;
        self.view = view;
    }
    return self;
}

#pragma mark - 重装属性赋值
- (void) setWidth: (CGFloat) width
{
    _isAutoWidth = NO;
    if ( width != _width ) {
        if ( width < 0 ) { width = 0; }
        if ( _display != ALDisplayBlock && _maxWidth && width > _maxWidth ) { width = _maxWidth; }

        _width = width;
        
        [self layoutWithWidth: width];
        [self reflowWhenWidthChange];
    }
}

- (void) setHeight: (CGFloat) height
{
    _isAutoHeight = NO;
    if ( height != _height ) {
        if ( height < 0 ) { height = 0; }
        if ( _maxHeight && height > _maxHeight ) { height = _maxHeight; }

        _height = height;
        
        [self layoutWithHeight: height];
        [self reflowWhenHeightChange];
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
    
    [self layoutOriginWhenAbsolute];
}
- (ALRect) getOrigin
{
    return (ALRect){_top, _left, _bottom, _right};
}

- (void)setTop: (CGFloat) top
{
    _hasSettedTop = YES;
    _top = top;
    
    [self layoutOriginWhenAbsolute];
}

- (void)setLeft: (CGFloat) left
{
    _hasSettedLeft = YES;
    _left = left;
    
    [self layoutOriginWhenAbsolute];
}

- (void)setRight: (CGFloat) right
{
    _hasSettedRight = YES;
    _right = right;

    [self layoutOriginWhenAbsolute];
}

- (void)setBottom: (CGFloat) bottom
{
    _hasSettedBottom = YES;
    _bottom = bottom;

    [self layoutOriginWhenAbsolute];
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
    
    [self layoutOriginWhenAbsolute];
}

- (void)setCenterY: (CGFloat) centerY
{
    _hasSettedCenterY = YES;
    _centerY = centerY;

    [self layoutOriginWhenAbsolute];
}

- (void) setMarginTop:(CGFloat)marginTop
{
    _marginTop = marginTop;
    // 重排
    [self reflowWhenMarginChange: ALMarginTop];
}

- (void) setMarginBottom:(CGFloat)marginBottom
{
    _marginBottom = marginBottom;
    // 重排
    [self reflowWhenMarginChange: ALMarginBottom];
}

- (void) setMarginLeft:(CGFloat)marginLeft
{
    _marginLeft = marginLeft;
    // 重排
    [self reflowWhenMarginChange: ALMarginLeft];
}

- (void) setMarginRight:(CGFloat)marginRight
{
    _marginRight = marginRight;
    // 重排
    [self reflowWhenMarginChange: ALMarginRight];
}

- (void)setMargin: (ALRect) margin
{
    _margin = margin;
    _marginTop = margin.top;
    _marginLeft = margin.left;
    _marginRight = margin.right;
    _marginBottom = margin.bottom;

    [self reflowWhenMarginChange: ALMarginTop];
    [self reflowWhenMarginChange: ALMarginLeft];
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

#pragma mark - reCount
- (CGFloat) reCountWidth
{
    CGFloat width = _width;
    if ( [self isValidALView] ) {
//        if ( [_view isKindOfClass:[ALLabel class]] ) {
//            width = [((ALLabel *) _view) reCountSize].width;
//        } else {
            // 相对定位时
        if ( _position == ALPositionRelative ) {
            // 如果是block，且自动宽度布局，那默认宽度是父view的宽度
            if ( _display == ALDisplayBlock && _isAutoWidth ) {
                CGFloat parentWidth = _view.superview.frame.size.width;
                if ( _view.superview.isALEngine ) {
                    parentWidth = _view.superview.style.width;
                }
                width = parentWidth - _marginLeft - _marginRight;
            }
        }
//        }
    }
    return width;
}

- (CGFloat) reCountHeight
{
    CGFloat height = _height;
//    if ( [self isValidALView] ) {
//        if ( [_view isKindOfClass:[ALLabel class]] ) {
//            height = [((ALLabel *) _view) reCountSize].height;
//        }
//    }
    return height;
}

#pragma mark - layout(排版同时记录相关数据)
/*
 * 自动排版absolute类型的view的origin（系统根据属性自动计算合适的size）
 */
- (void) layoutOriginWhenAbsolute
{
    if ( [self isValidALView] ) {
        UIView * parent = _view.superview;
        
        CGFloat top = _top;
        CGFloat left = _left;
        
        CGFloat parentWidth = parent.frame.size.width;
        CGFloat parentHeight = parent.frame.size.height;
        
        if ( parent.isALEngine ) {
            parentWidth = parent.style.width;
            parentHeight = parent.style.height;
        }
        
        // 如果父view是scrollView，排版需参考父view的content
        // contentSize与frame.size，谁大用谁
        if ( [parent isKindOfClass:[UIScrollView class]] ) {
            CGFloat contentHeight = ((UIScrollView*)parent).contentSize.height;
            CGFloat contentWidth = ((UIScrollView*)parent).contentSize.width;
            
            if ( contentHeight > parentHeight ) {
                parentHeight = contentHeight;
            }
            if ( contentWidth > parentWidth ) {
                parentWidth = contentWidth;
            }
        }
        // 优先级：top > centerY > bottom
        if ( !_hasSettedTop ) {
            if ( _hasSettedCenterY ) {
                top = (parentHeight - _height) / 2 + _centerY;
            } else if ( _hasSettedBottom ) {
                top = parentHeight - _bottom - _height;
            }
        }
        // 优先级：left > centerX > right
        if ( !_hasSettedLeft ) {
            if ( _hasSettedCenterX ) {
                left = (parentWidth - _width) / 2 + _centerX;
            } else if ( _hasSettedRight ) {
                left = parentWidth - _right - _width;
            }
        }
        
        [self layoutWithOrigin: CGPointMake(left, top)];
    }
}
// 自动排版：系统根据属性自动计算合适的size
- (void) layoutSize
{
    // 如果后续增加其他类型的view，私有排版方法可统一在这加
    // ALLabel私有排版方法
    if ( [_view isKindOfClass:[ALLabel class]] ) {
        [((ALLabel*)_view) layoutSize];
    } else {
        [self layoutWithWidth: [self reCountWidth]];
        [self layoutWithHeight: [self reCountHeight]];
    }
}

- (void) layoutWithTop: (CGFloat) top
{
    if ( [self isValidALView] ) {
        CGRect f = _view.frame;
        f.origin.y = top;
        _view.frame = f;
        _y = top;
    }
}

- (void) layoutWithLeft: (CGFloat) left
{
    if ( [self isValidALView] ) {
        CGRect f = _view.frame;
        f.origin.x = left;
        _view.frame = f;
        _x = left;
    }
}

- (void) layoutWithOrigin: (CGPoint) origin
{
    if ( [self isValidALView] ) {
        CGRect f = _view.frame;
        f.origin = origin;
        _view.frame = f;
        _x = origin.x;
        _y = origin.y;
    }
}

- (void) layoutWithWidth: (CGFloat) width
{
    if ( [self isValidALView] ) {
        CGRect f = _view.frame;
        f.size.width = width;
        _view.frame = f;
        // 如果autoWidth=YES
        if ( _isAutoWidth ) {
            _width = width;
        }
    }
}

- (void) layoutWithHeight: (CGFloat) height
{
    if ( [self isValidALView] ) {
        CGRect f = _view.frame;
        f.size.height = height;
        _view.frame = f;
        // 如果autoHeight=YES
        if ( _isAutoHeight ) {
            _height = height;
        }
    }
}

- (void) layoutWithSize: (CGSize) size
{
    [self layoutWithWidth: size.width];
    [self layoutWithHeight: size.height];
}

#pragma mark - reflow(属性改变需触发相关重排)
// hidden改变，重排
- (void) reflowWhenHiddenChange
{
    if ( [self isValidALView] ) {
        if ( _position == ALPositionRelative ) {
            // 满足这两条件需重刷size
            if ( _hidden == NO && _isAutoWidth ) {
                // 排版size
                [self layoutSize];
//                [_view reflowSize];
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
    if ( [self isValidALView] ) {
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
    if ( [self isValidALView] ) {
        if ( _position == ALPositionRelative ) {
            // 防止未知错误
            if ( _view.superview.rowManager ) {
                [_view.superview.rowManager reflowWhenXChange: _view need2ReflowSubView: YES];
            }
        } else {
            if ( _view.rowManager ) {
                [_view.rowManager reflowSubView];
                [_view.style reflowSizeWhenAuto];
//                [_view reflowSizeWhenAutoSize];
            }
            [self layoutOriginWhenAbsolute];
        }
        
        [self reflowSubviewOriginWhichISAbsolute];
    }
}

// height改变，重排
- (void) reflowWhenHeightChange
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( [self isValidALView] ) {
        // 重排row
        if ( _position == ALPositionRelative ) { // relative
            // 防止未知错误
            if ( _view.superview.rowManager ) {
                [_view.superview.rowManager reflowWhenYChange: _view need2reflowSelfTop: NO];
            }
        } else { // absolute
            [self layoutOriginWhenAbsolute];
        }
        
        [self reflowSubviewOriginWhichISAbsolute];
    }
}
#pragma mark - reflow(自动更新size，针对autoHeight=YES or autoWidth=YES时的重排)
/*
 * 如果当前view是auto size，那么根据指定的size排版当前view尺寸
 */
- (ALSizeIsChange) reflowSizeWhenAuto
{
    ALSizeIsChange hasChange;
    if ( [self isValidALView] ) {
        hasChange.width = [self reflowWidthWhenAuto];
        hasChange.height = [self reflowHeightWhenAuto];
    }
    return hasChange;
}
/*
 * 如果当前view是auto size，那么根据指定的size排版当前view尺寸
 */
- (BOOL) reflowWidthWhenAuto
{
    // 是否有更新了宽度，如果没有更新宽度，其实不必要重排内部子view的origin
    BOOL hasChange = NO;
    if ( [self isValidALView] && _isAutoWidth ) {
        // 取最新的宽度
        CGFloat width = _width;
        if ( _view.rowManager ) {
            width = [_view.rowManager getOnwerViewInnerWidth];
        }
        if ( _width != width &&
             // TODO，这里对ALLabel有兼容问题
             ((_display == ALDisplayBlock && _width < width && width <= _view.rowManager.maxWidth) || _display == ALDisplayInline || _position == ALPositionAbsolute)
        ) {
            [self layoutWithWidth: width];
            // 更新行信息
            if ( _position == ALPositionRelative ) {
                [_view.belongRow refreshWidth];
            }
            hasChange = YES;
        }
    }
    return hasChange;
}

/*
 * 如果当前view是auto height，那么根据指定的height排版当前view height
 */
- (BOOL) reflowHeightWhenAuto
{
    BOOL hasChange = NO;
    
    if ( [self isValidALView] ) {
        // 如果是ownerView是relative类型，需额外做以下逻辑：
        // 1、如果ownerView是ALScrollView类，需重排该view内部（reflowInnerFrame）
        // 2、更新ownerView所属行的size
        if ( [_view isKindOfClass: [ALScrollView class]] ) {
            [((ALScrollView *) _view) reflowInnerFrame];
        }
        if ( _isAutoHeight ) {
            CGFloat height = _height;
            if ( _view.rowManager ) {
                height = [_view.rowManager getOnwerViewInnerHeight];
            }
            if ( height != _height ) {
                [self layoutWithHeight: height];
                
                if ( _position == ALPositionRelative ) {
                    [_view.belongRow refreshHeight];
                }
                hasChange = YES;
            }
        }
    }
    
    return hasChange;
}

// 当size发生变化时，重排子view中使用absolute排版的
- (void) reflowSubviewOriginWhichISAbsolute
{
    if ( _view ) {
        for (UIView * subView in _view.subviews) {
            if (
                subView.isALEngine &&
                subView.style.position == ALPositionAbsolute &&
                (subView.style.hasSettedRight ||
                 subView.style.hasSettedBottom ||
                 subView.style.hasSettedCenterX ||
                 subView.style.hasSettedCenterY)
                ) {
                [subView.style layoutOriginWhenAbsolute];
            }
        }
    }
}

#pragma mark - 辅助方法

- (BOOL) isValidALView
{
    return _view && _view.isALEngine;
}

/*
 * 获取父view的宽度
 * 特殊：使用absolute布局且isAutoWidth=YES的父view，需递归一直往上查找
 */
- (CGFloat) getBelongRowMaxWidth
{
    CGFloat maxWidth = 0;
    if ( _view.isALEngine && _isAutoWidth ) {
        if ( _view.belongRow ) {
            maxWidth = _view.belongRow.maxWidth;
        } else if ( _view.superview ) {
            if ( _view.superview.isALEngine ) {
                return [_view.superview.style getBelongRowMaxWidth];
            } else {
                maxWidth = _view.superview.frame.size.width;
            }
        } else {
            // 否则直接返回屏幕宽度
            maxWidth = [[UIScreen mainScreen] bounds].size.width;
        }
        // 不能超过指定的最大值
        if ( _maxWidth && _maxWidth < maxWidth ) {
            maxWidth = _maxWidth;
        }
        // isAutoWidth=YES的情况，需减去左右外边距才是正真的最大宽度
        if ( _position == ALPositionRelative ) {
            // 减去自身的外边距
            maxWidth -= (_marginRight + _marginLeft);
        }
    } else {
        if ( _view.isALEngine ) {
            maxWidth = _width;
        } else {
            maxWidth = _view.frame.size.width;
        }
    }
    
    return maxWidth;
}

@end
