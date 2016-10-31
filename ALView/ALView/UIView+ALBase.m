//
//  UIView+ALBase.m
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "UIView+ALBase.h"
#import <objc/runtime.h>

@implementation UIView (ALBase)

#pragma mark - dynamic property

@dynamic isALBase;
- (BOOL) isALBase
{
    return [objc_getAssociatedObject(self, @"isALBase") boolValue];
}
- (void) setIsALBase:(BOOL)isALBase
{
    objc_setAssociatedObject(self, @"isALBase", [NSNumber numberWithBool:isALBase], OBJC_ASSOCIATION_RETAIN);
}

@dynamic position;
- (ALPosition) position
{
    return (ALPosition)[objc_getAssociatedObject(self, @"position") intValue];
}
-(void)setPosition:(ALPosition)position
{
    // absolute, fixed 时，isFullWidth要设置为NO
    if ( position == ALPositionAbsolute || position == ALPositionFixed ) {
        self.isFullWidth = NO;
    }
    objc_setAssociatedObject(self, @"position", [NSNumber numberWithInt:position], OBJC_ASSOCIATION_RETAIN);
}

@dynamic display;
- (ALDisplay) display
{
    return (ALDisplay)[objc_getAssociatedObject(self, @"display") intValue];
}
-(void)setDisplay:(ALDisplay)display
{
    objc_setAssociatedObject(self, @"display", [NSNumber numberWithInteger:display], OBJC_ASSOCIATION_RETAIN);
}

@dynamic width;
- (CGFloat) width
{
    return [objc_getAssociatedObject(self, @"width") floatValue];
}
-(void)setWidth:(CGFloat)width
{
    self.isFullWidth = NO;
    objc_setAssociatedObject(self, @"width", [NSNumber numberWithFloat:width], OBJC_ASSOCIATION_RETAIN);
}

@dynamic height;
- (CGFloat) height
{
    return [objc_getAssociatedObject(self, @"height") floatValue];
}
-(void)setHeight:(CGFloat)height
{
    self.isAutoHeight = NO;
    objc_setAssociatedObject(self, @"height", [NSNumber numberWithFloat:height], OBJC_ASSOCIATION_RETAIN);
}


@dynamic top;
- (CGFloat) top
{
    return [objc_getAssociatedObject(self, @"top") floatValue];
}
-(void)setTop:(CGFloat)top
{
    self.hasSettedTop = YES;
    objc_setAssociatedObject(self, @"top", [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN);
}

@dynamic bottom;
- (CGFloat) bottom
{
    return [objc_getAssociatedObject(self, @"bottom") floatValue];
}
-(void)setBottom:(CGFloat)bottom
{
    self.hasSettedBottom = YES;
    objc_setAssociatedObject(self, @"bottom", [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic left;
- (CGFloat) left
{
    return [objc_getAssociatedObject(self, @"left") floatValue];
}
-(void)setLeft:(CGFloat)left
{
    self.hasSettedLeft = YES;
    objc_setAssociatedObject(self, @"left", [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN);
}

@dynamic right;
- (CGFloat) right
{
    return [objc_getAssociatedObject(self, @"right") floatValue];
}
-(void)setRight:(CGFloat)right
{
    self.hasSettedRight = YES;
    objc_setAssociatedObject(self, @"right", [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginTop;
- (CGFloat) marginTop
{
    return [objc_getAssociatedObject(self, @"marginTop") floatValue];
}
-(void)setMarginTop:(CGFloat)marginTop
{
    objc_setAssociatedObject(self, @"marginTop", [NSNumber numberWithFloat:marginTop], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginBottom;
- (CGFloat) marginBottom
{
    return [objc_getAssociatedObject(self, @"marginBottom") floatValue];
}
-(void)setMarginBottom:(CGFloat)marginBottom
{
    objc_setAssociatedObject(self, @"marginBottom", [NSNumber numberWithFloat:marginBottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginLeft;
- (CGFloat) marginLeft
{
    return [objc_getAssociatedObject(self, @"marginLeft") floatValue];
}
-(void)setMarginLeft:(CGFloat)marginLeft
{
    objc_setAssociatedObject(self, @"marginLeft", [NSNumber numberWithFloat:marginLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginRight;
- (CGFloat) marginRight
{
    return [objc_getAssociatedObject(self, @"marginRight") floatValue];
}
-(void)setMarginRight:(CGFloat)marginRight
{
    objc_setAssociatedObject(self, @"marginRight", [NSNumber numberWithFloat:marginRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic currInnerHeight;
- (CGFloat) currInnerHeight
{
    return [objc_getAssociatedObject(self, @"currInnerHeight") floatValue];
}
-(void)setCurrInnerHeight:(CGFloat)currInnerHeight
{
    objc_setAssociatedObject(self, @"currInnerHeight", [NSNumber numberWithFloat:currInnerHeight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic currInnerWidth;
- (CGFloat) currInnerWidth
{
    return [objc_getAssociatedObject(self, @"currInnerWidth") floatValue];
}
-(void)setCurrInnerWidth:(CGFloat)currInnerWidth
{
    objc_setAssociatedObject(self, @"currInnerWidth", [NSNumber numberWithFloat:currInnerWidth], OBJC_ASSOCIATION_RETAIN);
}

@dynamic isAutoHeight;
- (BOOL) isAutoHeight
{
    return [objc_getAssociatedObject(self, @"isAutoHeight") boolValue];
}
- (void) setIsAutoHeight:(BOOL)isAutoHeight
{
    objc_setAssociatedObject(self, @"isAutoHeight", [NSNumber numberWithBool:isAutoHeight], OBJC_ASSOCIATION_RETAIN);
}


@dynamic isFullWidth;
- (BOOL) isFullWidth
{
    return [objc_getAssociatedObject(self, @"isFullWidth") boolValue];
}
- (void) setIsFullWidth:(BOOL)isFullWidth
{
    objc_setAssociatedObject(self, @"isFullWidth", [NSNumber numberWithBool:isFullWidth], OBJC_ASSOCIATION_RETAIN);
}


@dynamic isInNewLine;
- (BOOL) isInNewLine
{
    return [objc_getAssociatedObject(self, @"isInNewLine") boolValue];
}
- (void) setIsInNewLine:(BOOL)isInNewLine
{
    objc_setAssociatedObject(self, @"isInNewLine", [NSNumber numberWithBool:isInNewLine], OBJC_ASSOCIATION_RETAIN);
}


@dynamic hasSettedTop;
- (BOOL) hasSettedTop
{
    return [objc_getAssociatedObject(self, @"hasSettedTop") boolValue];
}
- (void) setHasSettedTop:(BOOL)hasSettedTop
{
    objc_setAssociatedObject(self, @"hasSettedTop", [NSNumber numberWithBool:hasSettedTop], OBJC_ASSOCIATION_RETAIN);
}


@dynamic hasSettedLeft;
- (BOOL) hasSettedLeft
{
    return [objc_getAssociatedObject(self, @"hasSettedLeft") boolValue];
}
- (void) setHasSettedLeft:(BOOL)hasSettedLeft
{
    objc_setAssociatedObject(self, @"hasSettedLeft", [NSNumber numberWithBool:hasSettedLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedRight;
- (BOOL) hasSettedRight
{
    return [objc_getAssociatedObject(self, @"hasSettedRight") boolValue];
}
- (void) setHasSettedRight:(BOOL)hasSettedRight
{
    objc_setAssociatedObject(self, @"hasSettedRight", [NSNumber numberWithBool:hasSettedRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedBottom;
- (BOOL) hasSettedBottom
{
    return [objc_getAssociatedObject(self, @"hasSettedBottom") boolValue];
}
- (void) setHasSettedBottom:(BOOL)hasSettedBottom
{
    objc_setAssociatedObject(self, @"hasSettedBottom", [NSNumber numberWithBool:hasSettedBottom], OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - init
// 继承类需重载该方法，用于初始化对应的配置文件
- (instancetype) initWithALBase
{
    if ( self = [self initWithFrame:CGRectZero] ) {
        self.isALBase = YES;
        
        self.isAutoHeight = YES;
        self.isFullWidth = YES;
        
        self.hasSettedTop = NO;
        self.hasSettedLeft = NO;
        self.hasSettedRight = NO;
        self.hasSettedBottom = NO;
        
        self.isInNewLine = NO;
        
        self.currInnerWidth = 0;
        self.currInnerHeight = 0;
    }
    return self;
}

- (void) addTo: (UIView *) parent
{
    [parent addSubview: self];
    [self reflow: parent];
}


#pragma mark - reflow & reCount
- (void) reflow:(UIView *)parent
{
    // 检查父view
    if ( parent == nil ) {
        return;
    }
    // 重置frame
    CGRect reflowFrame = CGRectMake(self.left, self.top, self.width, self.height);
    
    switch (self.position) {
        case ALPositionRelative:
        {
            reflowFrame = [self reCountWithRelative: parent withFrame: reflowFrame];
        }
            break;
            
        case ALPositionAbsolute:
        {
            reflowFrame = [self reCountWithAbsolute: parent withFrame: reflowFrame];
        }
            break;
            
        case ALPositionFixed:
        {
            reflowFrame = [self reCountWithFixed: parent withFrame: reflowFrame];
        }
            break;
            
        default:
            break;
    }
    // 重算自己的高度，可能由子view改变而触发的reflow
    reflowFrame = [self reCountHeightIfNeed: reflowFrame];
    // reflow ALScrollView's contentSize
    if ([self isKindOfClass:[ALScrollView class]]) {
        [((ALScrollView*)self) reflowContentFrame];
    }
    // draw
    self.frame = reflowFrame;
    // 父view是ALView的实例且当前view是relative布局时，触发父view reflow
    if ( parent.isALBase && self.position == ALPositionRelative ) {
        [parent reflow:parent.superview];
    }
}

// fixed方式布局的私有重排方法
- (void) reflowWithPositionFixed: (CGPoint) offset withFrame: (CGRect) reflowFrame
{
    if ( self.position == ALPositionFixed ) {
        CGFloat top = reflowFrame.origin.y;
        CGFloat left = reflowFrame.origin.x;
        
        reflowFrame.origin.y = top + offset.y;
        reflowFrame.origin.x = left + offset.x;
    }
}

- (CGRect) reCountWithRelative:(UIView *)parent withFrame: (CGRect) reflowFrame
{
    CGFloat top = self.top;
    CGFloat left = self.left;
    CGFloat width = self.width;
    
    // block 的排版
    if ( self.display == ALDisplayBlock ) {
        // block 如果没有设置width的情况，系统默认为父view的宽度
        if ( self.isFullWidth ) {
            width = self.superview.frame.size.width - self.marginLeft - self.marginRight;
        }
        
        // 根据外边距计算left, top
        left += self.marginLeft;
        top += self.marginTop;
        
        UIView * lastBlockView = [self getLastALBaseView:parent displayModel:ALDisplayBlock];
        
        // 存在最后一个block view且非自己
        if ( lastBlockView && lastBlockView != self ) {
            top +=  lastBlockView.marginBottom +
                    lastBlockView.frame.origin.y +
                    lastBlockView.frame.size.height;
        }
    } else if ( self.display == ALDisplayInline ) { // inline-block
        UIView * lastInlineView = [self getLastALBaseView:parent displayModel:ALDisplayInline];
        // 非nil，参照最后一个inline-block类型view右侧排列
        if ( lastInlineView ) {
            CGFloat x = lastInlineView.frame.origin.x +
                        lastInlineView.frame.size.width +
                        lastInlineView.marginRight;
            // 默认取父View的宽高
            CGFloat parentWidth = parent.frame.size.width;
            //            CGFloat parentHeight = parent.frame.size.height;
            // 检查是否需要断行
            if ( parentWidth < (x + self.marginLeft + self.marginRight + self.width) ) { // 断行
                // TODO 如果父view不是ALView实例，则无法读取 currInnerHeight，降级处理方案是排在上面view的下面
                if ( parent.isALBase ) {
                    top +=  self.marginTop +
                            lastInlineView.frame.origin.y +
                            lastInlineView.frame.size.height +
                            lastInlineView.marginBottom;
                } else {
                    top += parent.currInnerHeight;
                }
                left += self.marginLeft;
                self.isInNewLine = YES;
            } else { // 不断行
                left += self.marginLeft +
                        lastInlineView.frame.origin.x +
                        lastInlineView.frame.size.width +
                        lastInlineView.marginRight;
                // top要以上一节点的y坐标减去顶部外边距为准
                top +=  self.marginTop +
                        lastInlineView.frame.origin.y -
                        lastInlineView.marginTop;
            }
        } else {
            // 否则参照最后一个block类型的view下面排列
            UIView * lastBlockView = [self getLastALBaseView:parent displayModel:ALDisplayBlock];
            if ( lastBlockView ) {
                left += self.marginLeft;
                top +=  self.marginTop +
                        lastBlockView.frame.origin.y +
                        lastBlockView.frame.size.height +
                        lastBlockView.marginBottom;
            } else { // 自己就是开始的节点
                left += self.marginLeft;
                top += self.marginTop;
            }
            self.isInNewLine = YES;
        }
    }
    reflowFrame.origin.y = top;
    reflowFrame.origin.x = left;
    reflowFrame.size.width = width;
    
    return reflowFrame;
}

// absolute方式的排版：相对父view绝对位置排版
// 宽高：没有自动宽，高度可由子view撑高，但不能撑开父view，不能触发父view reflow
// 位置：通过top,left,bottom,right相对于父view来定位
// 注：如果父view为ALScrollView，排版应该是相对于父view的滚动区
// 注：1、位置不受margin影响；2、不受同级view排版影响。
// TODO: 兼容父view为ALScrollView的情况
- (CGRect) reCountWithAbsolute:(UIView *)parent withFrame: (CGRect) reflowFrame
{
    CGFloat top = self.top;
    CGFloat left = self.left;
    
    CGFloat parentHeight = parent.frame.size.height;
    CGFloat parentWidth = parent.frame.size.width;
    
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
    
    // 底部定位优先
    if ( self.hasSettedBottom && !self.hasSettedTop ) {
        top = parentHeight - self.bottom - self.height;
    } // 顶部定位优先直接为top值
    
    // 右边定位优先
    if ( self.hasSettedRight && !self.hasSettedLeft ) {
        left = parentWidth - self.right - self.width;
    }
    
    reflowFrame.origin.y = top;
    reflowFrame.origin.x = left;
    
    return reflowFrame;
}

// fixed方式的排版：相对父view固定位置排版
// 宽高：没有自动宽，高度可由子view撑高，但不能撑开父view，不能触发父view reflow
// 位置：通过top,left,bottom,right相对于父view来定位
// 注：1、位置不受margin影响；2、不受同级view影响；3、不受父view滚动区域影响。
- (CGRect) reCountWithFixed:(UIView *)parent withFrame: (CGRect) reflowFrame
{
    CGFloat top = self.top;
    CGFloat left = self.left;
    
    CGFloat parentHeight = parent.frame.size.height;
    CGFloat parentWidth = parent.frame.size.width;
    
    // 底部定位优先
    if ( self.hasSettedBottom && !self.hasSettedTop ) {
        top = parentHeight - self.bottom - self.height;
    } // 顶部定位优先直接为top值
    
    // 右边定位优先
    if ( self.hasSettedRight && !self.hasSettedLeft ) {
        left = parentWidth - self.right - self.width;
    }
    
    reflowFrame.origin.y = top;
    reflowFrame.origin.x = left;
    
    return reflowFrame; 
}

/*
 * 如果isAutoHeight=YES时，每次子view操作都应当重新计算view的高度
 */
- (CGRect) reCountHeightIfNeed: (CGRect) reflowFrame
{
    CGFloat innerHeight = 0;
    CGFloat innerWidth = 0;
    // 计算最高的 currInnerHeight
    if ( self.subviews.count > 0 ) {
        UIView * lastView = self.subviews.lastObject;
        // calc inner height
        innerHeight = lastView.frame.size.height + lastView.frame.origin.y;
        // 加上底部外边距
        if ( lastView.isALBase ) {
            innerHeight += lastView.marginBottom;
        }
        // 取子view中最高的
        if ( self.currInnerHeight < innerHeight ) {
            self.currInnerHeight = innerHeight;
        } else {
            innerHeight = self.currInnerHeight;
        }
        
        // calc inner width - only block view can overflow parent view's width
        if ( lastView.isALBase && lastView.display == ALDisplayBlock ) {
            innerWidth = lastView.frame.size.width + lastView.frame.origin.x + lastView.marginRight;
            
            if ( self.currInnerWidth < innerWidth ) {
                self.currInnerWidth = innerWidth;
            } else {
                innerWidth = self.currInnerWidth;
            }
        }
    }
    // 如果没设置高度，那就是系统自动设置（根据子view来算自身高度）
    if ( self.isAutoHeight ) {
        reflowFrame.size.height = innerHeight;
    }
    
    return reflowFrame;
}

#pragma mark - 私有方法
/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (UIView *) getLastALBaseView: (UIView *)parent displayModel: (ALDisplay) displayModel
{
    UIView * lastView = nil;
    NSInteger i = parent.subviews.count - 2; // 跳过自己
    
    for (; i >= 0; i--) {
        lastView = [parent.subviews objectAtIndex:i];
        if ( lastView.isALBase && lastView.display == displayModel ) {
            return lastView;
        }
    }
    return nil;
}

@end
