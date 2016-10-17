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
        self.isAutoHeight = NO;
        // 私有
        _currParentView = nil;
        _currFrame = CGRectZero;
    }
    return self;
}

- (void) initConfig: (UIView*) parent
{
    // 设置自动高度
    if (_height == 0) {
        self.isAutoHeight = YES;
    }
    
    _currParentView = parent;
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

- (void) setDisplay: (ALDisplay)display
{
    // 默认值
    if ( display == ALDisplayBlock && _width == 0 ) {
        self.width = SCREEN_WIDTH;
    }
    _display = display;
}

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
    UIView * lastBlockView = [self getLastView:parent displayModel:ALDisplayBlock];
    CGFloat y = 0;
    CGFloat height = _height;
    
    // 存在最后一个block view，且非自己
    if ( lastBlockView && lastBlockView != self ) {
        y = lastBlockView.frame.origin.y + lastBlockView.frame.size.height;
    }
    // block 如果没设置高度，那就是系统自动设置（根据子view来算自身高度）
    if ( _isAutoHeight && self.subviews.count > 0 ) {
        CGRect lastViewFrame = self.subviews.lastObject.frame;
        height = lastViewFrame.size.height + lastViewFrame.origin.y;
        // 取子view中最高的
        if ( height < _height ) {
            height = _height;
        }
    }
    
    self.top = y;
    self.height = height;
}

- (void) reCountWithInlineBlock:(UIView *)parent
{
    UIView * lastInlineBlockView = [self getLastView:parent displayModel:ALDisplayInlineBlock];
    // 非nil，参照最后一个inline-block类型view右侧排列
    if ( lastInlineBlockView ) {
        CGFloat x = lastInlineBlockView.frame.origin.x + lastInlineBlockView.frame.size.width;
        // 默认取UIView的宽度
        CGFloat parentWidth = parent.frame.size.width;
        // 如果是ALView类，那就取ALView的宽度
        if ( [parent isKindOfClass:[ALView class]] ) {
            parentWidth = ((ALView*)parent).width;
        }
        // 检查是需要断行
        if ( parentWidth < (x + self.width) ) {
            self.top = lastInlineBlockView.frame.origin.y + lastInlineBlockView.frame.size.height;
        } else {
            self.left = lastInlineBlockView.frame.origin.x + lastInlineBlockView.frame.size.width;
            self.top = lastInlineBlockView.frame.origin.y;
        }
    } else {
        // 否则参照最后一个block类型的view下面排列
        UIView * lastBlockView = [self getLastView:parent displayModel:ALDisplayBlock];
        if ( lastBlockView ) {
            self.top = lastBlockView.frame.origin.y + lastBlockView.frame.size.height;
        }
    }
}

#pragma mark - 私有方法
/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (UIView *) getLastView: (UIView *)parent displayModel: (ALDisplay) displayModel
{
    UIView * lastView = nil;
    NSInteger i = parent.subviews.count - 2;
    
    for (; i >= 0; i--) {
        lastView = [parent.subviews objectAtIndex:i];
        if ( [lastView isKindOfClass:[ALView class]] && ((ALView*)lastView).display == displayModel ) {
            return lastView;
        }
    }
    return nil;
}

@end
