//
//  ALView.m
//  autolayout
//
//  Created by 陈小雅 on 16/10/14.
//  Copyright © 2016年 陈小雅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALView.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ALView ()
{
    CGRect _currFrame;
}

@end

@implementation ALView

- (instancetype) init
{
    if ( self = [super initWithFrame:CGRectZero] ) {
        self.position = ALPositionRelative;
        self.display  = ALDisplayBlock;
        _isAutoHeight = YES;
        _isFullWidth = YES;
        
        _hasSettedTop = NO;
        _hasSettedLeft = NO;
        _hasSettedRight = NO;
        _hasSettedBottom = NO;
        
        _isInNewLine = NO;
        
        _currFrame = CGRectZero;
    }
    return self;
}

- (void) addTo:(UIView *)parent
{
    [parent addSubview: self];
    [self reflow: parent];
}

#pragma mark - reload set...

- (void) setWidth: (CGFloat)width
{
    _isFullWidth = NO;
    _width = width;
}

- (void) setHeight: (CGFloat)height
{
    _isAutoHeight = NO;
    _height = height;
}

- (void) setLeft: (CGFloat)left
{
    _hasSettedLeft = YES;
    _left = left;
}

- (void) setTop: (CGFloat)top
{
    _hasSettedTop = YES;
    _top = top;
}

- (void) setRight:(CGFloat)right
{
    _hasSettedRight = YES;
    _right = right;
}

- (void) setBottom:(CGFloat)bottom
{
    _hasSettedBottom = YES;
    _bottom = bottom;
}

- (void) setPosition:(ALPosition)position
{
    // absolute, fixed 时，isFullWidth要设置为NO
    if ( position == ALPositionAbsolute || position == ALPositionFixed ) {
        _isFullWidth = NO;
    }
    _position = position;
}

#pragma mark - reflow & reCount
- (void) reflow:(UIView *)parent
{
    // 检查父view
    if ( parent == nil ) {
        return;
    }
    // 重置frame
    _currFrame = CGRectMake(_left, _top, _width, _height);

    switch (_position) {
        case ALPositionRelative:
        {
            [self reCountWithRelative: parent];
        }
        break;
            
        case ALPositionAbsolute:
        {
            [self reCountWithAbsolute: parent];
        }
        break;
            
        case ALPositionFixed:
        {
            [self reCountWithFixed: parent];
        }
        break;
            
        default:
            break;
    }
    // 重算自己的高度，可能由子view改变而触发的reflow
    [self reCountHeightIfNeed];
    // draw
    self.frame = _currFrame;
    // 父view是ALView的实例且当前view是relative布局时，触发父view reflow
    if ( [parent isKindOfClass:[ALView class]] && _position == ALPositionRelative ) {
        [((ALView*) parent) reflow:parent.superview];
    }
}

- (void) reCountWithRelative:(UIView *)parent
{
    CGFloat top = _top;
    CGFloat left = _left;
    CGFloat width = _width;
    
    // block 的排版
    if ( _display == ALDisplayBlock ) {
        // block 如果没有设置width的情况，系统默认为父view的宽度
        if ( _isFullWidth ) {
            width = self.superview.frame.size.width - _marginLeft - _marginRight;
        }
        
        // 根据外边距计算left, top
        left += _marginLeft;
        top += _marginTop;
        
        ALView * lastBlockView = [self getLastALView:parent displayModel:ALDisplayBlock];
        
        // 存在最后一个block view且非自己
        if ( lastBlockView && lastBlockView != self ) {
            top +=  lastBlockView.marginBottom +
                    lastBlockView.frame.origin.y +
                    lastBlockView.frame.size.height;
        }
    } else if ( _display == ALDisplayInline ) { // inline-block
        ALView * lastInlineView = [self getLastALView:parent displayModel:ALDisplayInline];
        // 非nil，参照最后一个inline-block类型view右侧排列
        if ( lastInlineView ) {
            CGFloat x = lastInlineView.frame.origin.x +
                        lastInlineView.frame.size.width +
                        lastInlineView.marginRight;
            // 默认取父View的宽高
            CGFloat parentWidth = parent.frame.size.width;
//            CGFloat parentHeight = parent.frame.size.height;
            // 检查是否需要断行
            if ( parentWidth < (x + _marginLeft + _marginRight + _width) ) { // 断行
                // TODO 如果父view不是ALView实例，则无法读取 currInnerHeight，降级处理方案是排在上面view的下面
                if ( [parent isKindOfClass:[ALView class]] ) {
                    top += ((ALView*) parent).currInnerHeight;
                } else {
                    top +=  _marginTop +
                            lastInlineView.frame.origin.y +
                            lastInlineView.frame.size.height +
                            lastInlineView.marginBottom;
                }
                left += _marginLeft;
                _isInNewLine = YES;
            } else { // 不断行
                left += _marginLeft +
                        lastInlineView.frame.origin.x +
                        lastInlineView.frame.size.width +
                        lastInlineView.marginRight;
                // top要以上一节点的y坐标减去顶部外边距为准
                top +=  _marginTop +
                        lastInlineView.frame.origin.y -
                        lastInlineView.marginTop;
            }
        } else {
            // 否则参照最后一个block类型的view下面排列
            ALView * lastBlockView = [self getLastALView:parent displayModel:ALDisplayBlock];
            if ( lastBlockView ) {
                left += _marginLeft;
                top +=  _marginTop +
                        lastBlockView.frame.origin.y +
                        lastBlockView.frame.size.height +
                        lastBlockView.marginBottom;
            } else { // 自己就是开始的节点
                left += _marginLeft;
                top += _marginTop;
            }
            _isInNewLine = YES;
        }
    }
    _currFrame.origin.y = top;
    _currFrame.origin.x = left;
    _currFrame.size.width = width;
}

// absolute方式的排版
// 宽高：没有自动宽，高度可由子view撑高，但不能撑开父view，不能触发父view reflow
// 位置：通过top,left,bottom,right相对于父view来定位，margin不起作用
- (void) reCountWithAbsolute:(UIView *)parent
{
    CGFloat top = _top;
    CGFloat left = _left;
    
    CGFloat parentHeight = parent.frame.size.height;
    CGFloat parentWidth = parent.frame.size.width;
    
    // 底部定位优先
    if ( _hasSettedBottom && !_hasSettedTop ) {
        top = parentHeight - _bottom - _height;
    } // 顶部定位优先直接为top值
    
    // 右边定位优先
    if ( _hasSettedRight && !_hasSettedLeft ) {
        left = parentWidth - _right - _width;
    }
    
    _currFrame.origin.y = top;
    _currFrame.origin.x = left;
}

- (void) reCountWithFixed:(UIView *)parent
{
    _currFrame =  CGRectMake(_left, _top, _width, _height);
}

/*
 * 如果isAutoHeight=YES时，每次子view操作都应当重新计算view的高度
 */
- (void) reCountHeightIfNeed
{
    CGFloat innerHeight = 0;
    // 计算最高的 currInnerHeight
    if ( self.subviews.count > 0 ) {
        UIView * lastView = self.subviews.lastObject;
        innerHeight = lastView.frame.size.height + lastView.frame.origin.y;
        // 加上底部外边距
        if ( [lastView isKindOfClass:[ALView class]] ) {
            innerHeight += ((ALView*)lastView).marginBottom;
        }
        // 取子view中最高的
        if ( _currInnerHeight < innerHeight ) {
            _currInnerHeight = innerHeight;
        } else {
            innerHeight = _currInnerHeight;
        }
    }
    // 如果没设置高度，那就是系统自动设置（根据子view来算自身高度）
    if ( _isAutoHeight ) {
        _currFrame.size.height = innerHeight;
    }
}

#pragma mark - 私有方法
/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (ALView *) getLastALView: (UIView *)parent displayModel: (ALDisplay) displayModel
{
    ALView * lastView = nil;
    NSInteger i = parent.subviews.count - 2; // 跳过自己
    
    for (; i >= 0; i--) {
        lastView = [parent.subviews objectAtIndex:i];
        if ( [lastView isKindOfClass:[ALView class]] && ((ALView*)lastView).display == displayModel ) {
            return lastView;
        }
    }
    return nil;
}

@end
