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
    UIView * _currParentView;
}

@end

@implementation ALView

- (instancetype) init
{
    if ( self = [super initWithFrame:CGRectZero] ) {
        self.position = ALPositionRelative;
        self.display  = ALDisplayBlock;
        _isAutoHeight = NO;
        _isFullWidth = NO;
        _isInNewLine = NO;
        
        self.top = -1;
        self.bottom = -1;
        self.left = -1;
        self.right = -1;
        
        self.marginTop = -1;
        self.marginBottom = -1;
        self.marginLeft = -1;
        self.marginRight = -1;
        
        self.height = -1;
        self.width = -1;
        // 私有
        _currParentView = nil;
        _currFrame = CGRectZero;
    }
    return self;
}

- (void) initConfig: (UIView*) parent
{
    // 设置自动高度
    if ( _height == -1 ) {
        _isAutoHeight = YES;
    }
    // BLOCK 如果没设置width值，则默认为父view的宽度
    if ( _display == ALDisplayBlock && _width == -1 ) {
        _isFullWidth = YES;
    }
    
    _currParentView = parent;
    
    // 初始化
    if ( _top == -1 ) self.top = 0;
    if ( _bottom == -1 ) self.bottom = 0;
    if ( _left == -1 ) self.left = 0;
    if ( _right == -1 ) self.right = 0;
    
    if ( _marginTop == -1 ) self.marginTop = 0;
    if ( _marginBottom == -1 ) self.marginBottom = 0;
    if ( _marginLeft == -1 ) self.marginLeft = 0;
    if ( _marginRight == -1 ) self.marginRight = 0;
    
    if ( _height == -1 ) self.height = 0;
    if ( _width == -1 ) self.width = 0;
}

- (void) addTo:(UIView *)parent
{
    [parent addSubview: self];
    [self initConfig: parent];
    [self reflow: parent];
}

#pragma mark - reload set...

- (void) setWidth: (CGFloat)width
{
    _currFrame.size.width = width;
    _width = width;
}

- (void) setHeight: (CGFloat)height
{
    _currFrame.size.height = height;
    _height = height;
}

- (void) setLeft: (CGFloat)left
{
    _currFrame.origin.x = left;
    _left = left;
}

- (void) setTop: (CGFloat)top
{
    _currFrame.origin.y = top;
    _top = top;
}

// TODO: 初始状态是ALDisplayInline且没设置width的时候有问题
//- (void) setDisplay: (ALDisplay)display
//{
//    _display = display;
//}

#pragma mark - reflow & reCount
- (void) reflow:(UIView *)parent
{
    // 检查父view
    if ( parent == nil ) {
        return;
    }
    // 重置frame
    _currFrame = CGRectZero;
    
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
    //
    switch (_display) {
        case ALDisplayBlock:
        {
            [self reCountWithBlock: parent];
        }
            break;
            
        case ALDisplayInlineBlock:
        {
            [self reCountWithInlineBlock: parent];
        }
            break;
            
        default:
            break;
    }
    // 通过margin计算top, left, width
    [self reCountWithMargin:parent];
    // 重算自己的高度，可能由子view改变而触发的reflow
    [self reCountHeightIfNeed];
    // draw
    self.frame = _currFrame;
    // 触发父view reflow
    if ( [parent isKindOfClass:[ALView class]] ) {
        [((ALView*) parent) reflow:parent.superview];
    }
}

- (void) reCountWithRelative:(UIView *)parent
{
    _currFrame = CGRectMake(_left, _top, _width, _height);
}

- (void) reCountWithAbsolute:(UIView *)parent
{
    _currFrame =  CGRectMake(_left, _top, _width, _height);
}

- (void) reCountWithFixed:(UIView *)parent
{
    _currFrame =  CGRectMake(_left, _top, _width, _height);
}

- (void) reCountWithBlock:(UIView *)parent
{
    // block 排版参照最后一个block类型的view下面排列
    ALView * lastBlockView = [self getLastALView:parent displayModel:ALDisplayBlock];
    CGFloat y = 0;
    CGFloat width = _width;
    
    // block 如果没有设置width的情况，系统默认为父view的宽度
    if ( _isFullWidth ) {
        width = self.superview.frame.size.width;
    }
    
    // 存在最后一个block view，且非自己
    if ( lastBlockView && lastBlockView != self ) {
        y = lastBlockView.top + lastBlockView.height;
    }
    
    self.top = y;
    self.width = width;
}

- (void) reCountWithInlineBlock:(UIView *)parent
{
    ALView * lastInlineBlockView = [self getLastALView:parent displayModel:ALDisplayInlineBlock];
    // 非nil，参照最后一个inline-block类型view右侧排列
    if ( lastInlineBlockView ) {
        CGFloat x = lastInlineBlockView.left + lastInlineBlockView.width;
        // 默认取UIView的宽度
        CGFloat parentWidth = parent.frame.size.width;
        CGFloat parentHeight = parent.frame.size.height;
        // 如果是ALView类，那就取ALView的宽度
        if ( [parent isKindOfClass:[ALView class]] ) {
            parentWidth = ((ALView*)parent).width;
            parentHeight = ((ALView*)parent).height;
        }
        // 检查是否需要断行
        if ( parentWidth < (x + self.width) ) { // 断行
            self.top = parentHeight;
            _isInNewLine = YES;
        } else { // 不断行
            self.left = lastInlineBlockView.left + lastInlineBlockView.width;
            self.top = lastInlineBlockView.top;
        }
    } else {
        // 否则参照最后一个block类型的view下面排列
        ALView * lastBlockView = [self getLastALView:parent displayModel:ALDisplayBlock];
        if ( lastBlockView ) {
            self.top = lastBlockView.top + lastBlockView.height;
        }
        _isInNewLine = YES;
    }
}

- (void) reCountHeightIfNeed
{
    CGFloat h = _height;
    // 如果没设置高度，那就是系统自动设置（根据子view来算自身高度）
    if ( _isAutoHeight && self.subviews.count > 0 ) {
        UIView * lastView = self.subviews.lastObject;
        h = lastView.frame.size.height + lastView.frame.origin.y;
        // 加上底部外边距
        if ( [lastView isKindOfClass:[ALView class]] ) {
            h += ((ALView*)lastView).marginBottom;
        }
        // 取子view中最高的
        if ( h < _height ) {
            h = _height;
        }
    }
    self.height = h;
}

- (void) reCountWithMargin: (UIView*) parent
{
    CGFloat top = _top;
    CGFloat left = _left + _marginLeft;
    // 默认100%宽的情况
    if ( _isFullWidth ) {
        self.width = _width - _marginLeft - _marginRight;
    }
    
    if ( _display == ALDisplayBlock ) { // block
        ALView * lastBlockView = [self getLastALView:parent displayModel:ALDisplayBlock];
        top = _top + _marginTop + lastBlockView.marginBottom;
//        left = _left + _marginLeft;
    } else { // inline-block
        NSInteger len = self.superview.subviews.count;
        // 避开自己
        if ( len > 1 ) {
            // 取上一相邻view
            UIView * lastView = [self.superview.subviews objectAtIndex:len - 2];
            if ( [lastView isKindOfClass:[ALView class]] ) {
                // 上一相邻view是block
                if ( ((ALView*)lastView).display == ALDisplayBlock ) {
                    top = _top + _marginTop + ((ALView*)lastView).marginBottom;
                } else {
                    // 只有当前view不是断行view，才需加上上一相邻view的右边距
                    if ( !_isInNewLine ) {
                        left += ((ALView*)lastView).marginRight;
                    }
                }
            }
        }
    }
    self.top = top;
    self.left = left;
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
