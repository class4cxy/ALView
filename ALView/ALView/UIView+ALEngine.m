//
//  UIView+ALEngine.m
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "UIView+ALEngine.h"
#import <objc/runtime.h>

@implementation UIView (ALEngine)

#pragma mark - dynamic property

@dynamic isALEngine;
- (BOOL) isALEngine
{
    return [objc_getAssociatedObject(self, @"isALEngine") boolValue];
}
- (void) setIsALEngine:(BOOL)isALEngine
{
    objc_setAssociatedObject(self, @"isALEngine", [NSNumber numberWithBool:isALEngine], OBJC_ASSOCIATION_RETAIN);
}

@dynamic position;
- (ALPosition) position
{
    return (ALPosition)[objc_getAssociatedObject(self, @"position") intValue];
}
-(void)setPosition:(ALPosition)position
{
    objc_setAssociatedObject(self, @"position", [NSNumber numberWithInt:position], OBJC_ASSOCIATION_RETAIN);
}

@dynamic contentAlign;
- (ALContentAlign) contentAlign
{
    return (ALContentAlign)[objc_getAssociatedObject(self, @"contentAlign") intValue];
}
-(void)setContentAlign:(ALContentAlign)contentAlign
{
    objc_setAssociatedObject(self, @"contentAlign", [NSNumber numberWithInt:contentAlign], OBJC_ASSOCIATION_RETAIN);
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
    self.isAutoWidth = NO;
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

@dynamic centerX;
- (CGFloat) centerX
{
    return [objc_getAssociatedObject(self, @"centerX") floatValue];
}
-(void)setCenterX:(CGFloat)centerX
{
    self.hasSettedCenterX = YES;
    objc_setAssociatedObject(self, @"centerX", [NSNumber numberWithFloat:centerX], OBJC_ASSOCIATION_RETAIN);
}

@dynamic centerY;
- (CGFloat) centerY
{
    return [objc_getAssociatedObject(self, @"centerY") floatValue];
}
-(void)setCenterY:(CGFloat)centerY
{
    self.hasSettedCenterY = YES;
    objc_setAssociatedObject(self, @"centerY", [NSNumber numberWithFloat:centerY], OBJC_ASSOCIATION_RETAIN);
}

@dynamic margin;
- (CGFloat) margin
{
    return [objc_getAssociatedObject(self, @"margin") floatValue];
}
-(void)setMargin:(CGFloat)margin
{
    objc_setAssociatedObject(self, @"margin", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginTop", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginLeft", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginBottom", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginRight", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
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


@dynamic isAutoWidth;
- (BOOL) isAutoWidth
{
    return [objc_getAssociatedObject(self, @"isAutoWidth") boolValue];
}
- (void) setIsAutoWidth:(BOOL)isAutoWidth
{
    objc_setAssociatedObject(self, @"isAutoWidth", [NSNumber numberWithBool:isAutoWidth], OBJC_ASSOCIATION_RETAIN);
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

@dynamic hasSettedCenterX;
- (BOOL) hasSettedCenterX
{
    return [objc_getAssociatedObject(self, @"hasSettedCenterX") boolValue];
}
- (void) setHasSettedCenterX:(BOOL)hasSettedCenterX
{
    objc_setAssociatedObject(self, @"hasSettedCenterX", [NSNumber numberWithBool:hasSettedCenterX], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedCenterY;
- (BOOL) hasSettedCenterY
{
    return [objc_getAssociatedObject(self, @"hasSettedCenterY") boolValue];
}
- (void) setHasSettedCenterY:(BOOL)hasSettedCenterY
{
    objc_setAssociatedObject(self, @"hasSettedCenterY", [NSNumber numberWithBool:hasSettedCenterY], OBJC_ASSOCIATION_RETAIN);
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

@dynamic nextSibling;
- (ALView *) nextSibling
{
    return objc_getAssociatedObject(self, @"nextSibling");
}
- (void) setNextSibling:(ALView *)nextSibling
{
    objc_setAssociatedObject(self, @"nextSibling", nextSibling, OBJC_ASSOCIATION_RETAIN);
}

@dynamic previousSibling;
- (ALView *) previousSibling
{
    return objc_getAssociatedObject(self, @"previousSibling");
}
- (void) setPreviousSibling:(ALView *)previousSibling
{
    objc_setAssociatedObject(self, @"previousSibling", previousSibling, OBJC_ASSOCIATION_RETAIN);
}

@dynamic belongRow;
- (ALRow *) belongRow
{
    return objc_getAssociatedObject(self, @"belongRow");
}
- (void) setBelongRow:(ALRow *)belongRow
{
    objc_setAssociatedObject(self, @"belongRow", belongRow, OBJC_ASSOCIATION_RETAIN);
}

@dynamic rowManager;
- (ALRowManager *) rowManager
{
    return objc_getAssociatedObject(self, @"rowManager");
}
- (void) setRowManager:(ALRowManager *)rowManager
{
    objc_setAssociatedObject(self, @"rowManager", rowManager, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - init
// 继承类需重载该方法，用于初始化对应的配置文件
- (instancetype) initWithALEngine
{
    if ( self = [self initWithFrame:CGRectZero] ) {
        self.isALEngine = YES;
        
        self.isAutoHeight = YES;
        self.isAutoWidth = YES;
        
        self.hasSettedTop = NO;
        self.hasSettedLeft = NO;
        self.hasSettedRight = NO;
        self.hasSettedBottom = NO;
        self.hasSettedCenterX = NO;
        self.hasSettedCenterY = NO;
        
        self.isInNewLine = NO;
        
        self.currInnerWidth = 0;
        self.currInnerHeight = 0;
        
        self.nextSibling = nil;
        self.previousSibling = nil;

    }
    return self;
}
#pragma mark - 节点操作方法
/*
 * 往父view底部插入新的view
 */
- (void) addTo: (UIView *) parent
{
    // 将view add到树中
    [parent addSubview: self];
    if ( !parent.rowManager ) {
        // 初始化行管理器
        parent.rowManager = [[ALRowManager alloc] initWithView: parent];
    }
    // 生成兄弟view关系
    [self linkSiblingView];
    // 排版size
    [self reflowSelfSize];
    // 排版origin
    if ( self.position == ALPositionRelative ) {
        [parent.rowManager appendView: self];
    } else {
        [self reflowOriginWhenAbsolute];
    }
}
/*
 * 移除该view
 * 1、先执行自身的移除逻辑
 * 2、再调用UIView的removeFromSuperview方法移除
 */
- (void) remove
{
    // TODO
    [self removeFromSuperview];
}

/*
 * 在指定view之前插入新的view
 */
- (void) insertView:(UIView *)view beforeView:(UIView *)siblingView
{
    // TODO
}

#pragma mark - 排版逻辑

// 重排自己
- (void) reflow
{
    // 防止未知错误
    if ( self.superview && self.superview.rowManager ) {
        [self reflowSelfSize];
        [self.superview.rowManager reflowChildView: self];
    }
}

/*
 * link view by nextSibling & previousSibling
 */

- (void) linkSiblingView
{
    UIView * parent = self.superview;
    
    UIView * lastSubView = [self getLastALEngineSubview: parent displayModel:-1];
    
    if ( lastSubView != nil ) {
        self.previousSibling = (ALView*)lastSubView;
        lastSubView.nextSibling = (ALView*)self;
    }
}

/*
 * 排版自身尺寸
 */
- (void) reflowSelfSize
{
    UIView * parent = self.superview;
    // ALLabel的计算内部size方法比较特殊，由ALLabel自己实现
    if ( [self isKindOfClass:[ALLabel class]] ) {
        [((ALLabel *) self) reflowWithInnerText: parent];
    } else {
        CGFloat width = self.width;
        CGFloat height = self.height;
        // 相对定位时
        if ( self.position == ALPositionRelative ) {
            // 如果是block，且自动宽度布局，那默认宽度是父view的宽度
            if ( self.display == ALDisplayBlock && self.isAutoWidth ) {
                width = self.superview.frame.size.width - self.marginLeft - self.marginRight;
            }
        // 绝对定位时
        } else {
            // 如果使用了isAutoWidth或者isAutoHeight，直接使用现有的宽高，因为子view被插入时，会更新内部的size
            if ( self.isAutoWidth ) {
                width = self.frame.size.width;
            }
            if ( self.isAutoHeight ) {
                height = self.frame.size.height;
            }
        }
        
        // reflow
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    }
}

/*
 * 排版absolute类型的view的origin
 */
- (void) reflowOriginWhenAbsolute
{
    UIView * parent = self.superview;
    
    CGFloat top = self.top;
    CGFloat left = self.left;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
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
    // 优先级：top > centerY > bottom
    if ( !self.hasSettedTop ) {
        if ( self.hasSettedCenterY ) {
            top = (parentHeight - height) / 2 + self.centerY;
        } else if ( self.hasSettedBottom ) {
            top = parentHeight - self.bottom - height;
        }
    }
    // 优先级：left > centerX > right
    if ( !self.hasSettedLeft ) {
        if ( self.hasSettedCenterX ) {
            left = (parentWidth - width) / 2 + self.centerX;
        } else if ( self.hasSettedRight ) {
            left = parentWidth - self.right - width;
        }
    }
    
    self.frame = CGRectMake(left, top, width, height);
}

#pragma mark - 私有方法
/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (UIView *) getLastALEngineSubview: (UIView *)parent displayModel: (NSUInteger) index
{
    UIView * lastView = nil;
    NSInteger i = parent.subviews.count - 2; // 跳过自己
    
    for (; i >= 0; i--) {
        lastView = [parent.subviews objectAtIndex:i];
        if ( lastView.isALEngine && (index == -1 || lastView.display == (ALDisplay)index) ) {
            return lastView;
        }
    }
    return nil;
}

/*
 * 获取父view的宽度
 * 特殊：使用absolute布局且isAutoWidth=YES的父view，需递归一直往上查找
 */
- (CGFloat) getParentWidth
{
    if ( self.superview ) {
        if ( self.superview.isALEngine && self.superview.position == ALPositionAbsolute && self.superview.isAutoWidth ) {
            return [self.superview getParentWidth];
        }
        return self.superview.frame.size.width;
    }
    return [[UIScreen mainScreen] bounds].size.width;
}

@end
