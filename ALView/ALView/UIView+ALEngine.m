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

@dynamic alPosition;
- (ALPosition) alPosition
{
    return (ALPosition)[objc_getAssociatedObject(self, @"alPosition") intValue];
}
-(void)setAlPosition:(ALPosition)alPosition
{
    objc_setAssociatedObject(self, @"alPosition", [NSNumber numberWithInt:alPosition], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alContentAlign;
- (ALContentAlign) alContentAlign
{
    return (ALContentAlign)[objc_getAssociatedObject(self, @"alContentAlign") intValue];
}
-(void)setAlContentAlign:(ALContentAlign)alContentAlign
{
    objc_setAssociatedObject(self, @"alContentAlign", [NSNumber numberWithInt:alContentAlign], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alDisplay;
- (ALDisplay) alDisplay
{
    return (ALDisplay)[objc_getAssociatedObject(self, @"alDisplay") intValue];
}
-(void)setAlDisplay:(ALDisplay)alDisplay
{
    objc_setAssociatedObject(self, @"alDisplay", [NSNumber numberWithInteger:alDisplay], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alWidth;
- (CGFloat) alWidth
{
    return [objc_getAssociatedObject(self, @"alWidth") floatValue];
}
-(void)setAlWidth:(CGFloat)alWidth
{
    self.alIsAutoWidth = NO;
    if ( alWidth > 0 ) {
        objc_setAssociatedObject(self, @"alWidth", [NSNumber numberWithFloat:alWidth], OBJC_ASSOCIATION_RETAIN);
    }
}

@dynamic alHeight;
- (CGFloat) alHeight
{
    return [objc_getAssociatedObject(self, @"alHeight") floatValue];
}
-(void)setAlHeight:(CGFloat)alHeight
{
    self.alIsAutoHeight = NO;
    if ( alHeight > 0 ) {
        objc_setAssociatedObject(self, @"alHeight", [NSNumber numberWithFloat:alHeight], OBJC_ASSOCIATION_RETAIN);
    }
}


@dynamic alTop;
- (CGFloat) alTop
{
    return [objc_getAssociatedObject(self, @"alTop") floatValue];
}
-(void)setAlTop:(CGFloat)alTop
{
    self.alHasSettedTop = YES;
    objc_setAssociatedObject(self, @"alTop", [NSNumber numberWithFloat:alTop], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alBottom;
- (CGFloat) alBottom
{
    return [objc_getAssociatedObject(self, @"alBottom") floatValue];
}
-(void)setAlBottom:(CGFloat)alBottom
{
    self.alHasSettedBottom = YES;
    objc_setAssociatedObject(self, @"alBottom", [NSNumber numberWithFloat:alBottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alLeft;
- (CGFloat) alLeft
{
    return [objc_getAssociatedObject(self, @"alLeft") floatValue];
}
-(void)setAlLeft:(CGFloat)alLeft
{
    self.alHasSettedLeft = YES;
    objc_setAssociatedObject(self, @"alLeft", [NSNumber numberWithFloat:alLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alRight;
- (CGFloat) alRight
{
    return [objc_getAssociatedObject(self, @"alRight") floatValue];
}
-(void)setAlRight:(CGFloat)alRight
{
    self.alHasSettedRight = YES;
    objc_setAssociatedObject(self, @"alRight", [NSNumber numberWithFloat:alRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alCenterX;
- (CGFloat) alCenterX
{
    return [objc_getAssociatedObject(self, @"alCenterX") floatValue];
}
-(void)setAlCenterX:(CGFloat)alCenterX
{
    self.alHasSettedCenterX = YES;
    objc_setAssociatedObject(self, @"alCenterX", [NSNumber numberWithFloat:alCenterX], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alCenterY;
- (CGFloat) alCenterY
{
    return [objc_getAssociatedObject(self, @"alCenterY") floatValue];
}
-(void)setAlCenterY:(CGFloat)alCenterY
{
    self.alHasSettedCenterY = YES;
    objc_setAssociatedObject(self, @"alCenterY", [NSNumber numberWithFloat:alCenterY], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alMargin;
- (CGFloat) alMargin
{
    return [objc_getAssociatedObject(self, @"margin") floatValue];
}
-(void)setAlMargin:(CGFloat)alMargin
{
    objc_setAssociatedObject(self, @"alMargin", [NSNumber numberWithFloat:alMargin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"alMarginTop", [NSNumber numberWithFloat:alMargin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"alMarginLeft", [NSNumber numberWithFloat:alMargin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"alMarginBottom", [NSNumber numberWithFloat:alMargin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"alMarginRight", [NSNumber numberWithFloat:alMargin], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alMarginTop;
- (CGFloat) alMarginTop
{
    return [objc_getAssociatedObject(self, @"alMarginTop") floatValue];
}
-(void)setAlMarginTop:(CGFloat)alMarginTop
{
    objc_setAssociatedObject(self, @"alMarginTop", [NSNumber numberWithFloat:alMarginTop], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alMarginBottom;
- (CGFloat) alMarginBottom
{
    return [objc_getAssociatedObject(self, @"alMarginBottom") floatValue];
}
-(void)setAlMarginBottom:(CGFloat)alMarginBottom
{
    objc_setAssociatedObject(self, @"alMarginBottom", [NSNumber numberWithFloat:alMarginBottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alMarginLeft;
- (CGFloat) alMarginLeft
{
    return [objc_getAssociatedObject(self, @"alMarginLeft") floatValue];
}
-(void)setAlMarginLeft:(CGFloat)alMarginLeft
{
    objc_setAssociatedObject(self, @"alMarginLeft", [NSNumber numberWithFloat:alMarginLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alMarginRight;
- (CGFloat) alMarginRight
{
    return [objc_getAssociatedObject(self, @"alMarginRight") floatValue];
}
-(void)setAlMarginRight:(CGFloat)alMarginRight
{
    objc_setAssociatedObject(self, @"alMarginRight", [NSNumber numberWithFloat:alMarginRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alIsAutoHeight;
- (BOOL) alIsAutoHeight
{
    return [objc_getAssociatedObject(self, @"alIsAutoHeight") boolValue];
}
- (void) setAlIsAutoHeight:(BOOL)alIsAutoHeight
{
    objc_setAssociatedObject(self, @"alIsAutoHeight", [NSNumber numberWithBool:alIsAutoHeight], OBJC_ASSOCIATION_RETAIN);
}


@dynamic alIsAutoWidth;
- (BOOL) alIsAutoWidth
{
    return [objc_getAssociatedObject(self, @"alIsAutoWidth") boolValue];
}
- (void) setAlIsAutoWidth:(BOOL)alIsAutoWidth
{
    objc_setAssociatedObject(self, @"alIsAutoWidth", [NSNumber numberWithBool:alIsAutoWidth], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alHasSettedTop;
- (BOOL) alHasSettedTop
{
    return [objc_getAssociatedObject(self, @"alHasSettedTop") boolValue];
}
- (void) setAlHasSettedTop:(BOOL)alHasSettedTop
{
    objc_setAssociatedObject(self, @"alHasSettedTop", [NSNumber numberWithBool:alHasSettedTop], OBJC_ASSOCIATION_RETAIN);
}


@dynamic alHasSettedLeft;
- (BOOL) alHasSettedLeft
{
    return [objc_getAssociatedObject(self, @"alHasSettedLeft") boolValue];
}
- (void) setAlHasSettedLeft:(BOOL)alHasSettedLeft
{
    objc_setAssociatedObject(self, @"alHasSettedLeft", [NSNumber numberWithBool:alHasSettedLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alHasSettedCenterX;
- (BOOL) alHasSettedCenterX
{
    return [objc_getAssociatedObject(self, @"alHasSettedCenterX") boolValue];
}
- (void) setAlHasSettedCenterX:(BOOL)alHasSettedCenterX
{
    objc_setAssociatedObject(self, @"alHasSettedCenterX", [NSNumber numberWithBool:alHasSettedCenterX], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alHasSettedCenterY;
- (BOOL) alHasSettedCenterY
{
    return [objc_getAssociatedObject(self, @"alHasSettedCenterY") boolValue];
}
- (void) setAlHasSettedCenterY:(BOOL)alHasSettedCenterY
{
    objc_setAssociatedObject(self, @"alHasSettedCenterY", [NSNumber numberWithBool:alHasSettedCenterY], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alHasSettedRight;
- (BOOL) alHasSettedRight
{
    return [objc_getAssociatedObject(self, @"alHasSettedRight") boolValue];
}
- (void) setAlHasSettedRight:(BOOL)alHasSettedRight
{
    objc_setAssociatedObject(self, @"alHasSettedRight", [NSNumber numberWithBool:alHasSettedRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alHasSettedBottom;
- (BOOL) alHasSettedBottom
{
    return [objc_getAssociatedObject(self, @"alHasSettedBottom") boolValue];
}
- (void) setAlHasSettedBottom:(BOOL)alHasSettedBottom
{
    objc_setAssociatedObject(self, @"alHasSettedBottom", [NSNumber numberWithBool:alHasSettedBottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic alNextSibling;
- (ALView *) alNextSibling
{
    return objc_getAssociatedObject(self, @"alNextSibling");
}
- (void) setAlNextSibling:(ALView *)alNextSibling
{
    objc_setAssociatedObject(self, @"alNextSibling", alNextSibling, OBJC_ASSOCIATION_RETAIN);
}

@dynamic alPreviousSibling;
- (ALView *) alPreviousSibling
{
    return objc_getAssociatedObject(self, @"alPreviousSibling");
}
- (void) setAlPreviousSibling:(ALView *)alPreviousSibling
{
    objc_setAssociatedObject(self, @"alPreviousSibling", alPreviousSibling, OBJC_ASSOCIATION_RETAIN);
}

@dynamic alBelongRow;
- (ALRow *) alBelongRow
{
    return objc_getAssociatedObject(self, @"alBelongRow");
}
- (void) setAlBelongRow:(ALRow *)alBelongRow
{
    objc_setAssociatedObject(self, @"alBelongRow", alBelongRow, OBJC_ASSOCIATION_RETAIN);
}

@dynamic alRowManager;
- (ALRowManager *) alRowManager
{
    return objc_getAssociatedObject(self, @"alRowManager");
}
- (void) setAlRowManager:(ALRowManager *)alRowManager
{
    objc_setAssociatedObject(self, @"alRowManager", alRowManager, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - init
// 继承类需重载该方法，用于初始化对应的配置文件
- (instancetype) initWithALEngine
{
    if ( self = [self initWithFrame:CGRectZero] ) {
        self.isALEngine = YES;
        
        self.alIsAutoHeight = YES;
        self.alIsAutoWidth = YES;
        
        self.alHasSettedTop = NO;
        self.alHasSettedLeft = NO;
        self.alHasSettedRight = NO;
        self.alHasSettedBottom = NO;
        self.alHasSettedCenterX = NO;
        self.alHasSettedCenterY = NO;
        
        self.alNextSibling = nil;
        self.alPreviousSibling = nil;

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
    if ( !parent.alRowManager ) {
        // 初始化行管理器
        parent.alRowManager = [[ALRowManager alloc] initWithView: parent];
    }
    // 生成兄弟view关系
    [self linkSiblingView];
    // 排版size
    [self reflowSelfSize];
    // 排版origin
    if ( self.alPosition == ALPositionRelative ) {
        [parent.alRowManager appendView: self];
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
    if ( self.superview && self.superview.alRowManager ) {
        [self reflowSelfSize];
        [self.superview.alRowManager reflowChildView: self];
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
        self.alPreviousSibling = (ALView*)lastSubView;
        lastSubView.alNextSibling = (ALView*)self;
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
        CGFloat width = self.alWidth;
        CGFloat height = self.alHeight;
        // 相对定位时
        if ( self.alPosition == ALPositionRelative ) {
            // 如果是block，且自动宽度布局，那默认宽度是父view的宽度
            if ( self.alDisplay == ALDisplayBlock && self.alIsAutoWidth ) {
                width = self.superview.frame.size.width - self.alMarginLeft - self.alMarginRight;
            }
        // 绝对定位时
        } else {
            // 如果使用了isAutoWidth或者isAutoHeight，直接使用现有的宽高，因为子view被插入时，会更新内部的size
            if ( self.alIsAutoWidth ) {
                width = self.frame.size.width;
            }
            if ( self.alIsAutoHeight ) {
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
    
    CGFloat top = self.alTop;
    CGFloat left = self.alLeft;
    
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
    if ( !self.alHasSettedTop ) {
        if ( self.alHasSettedCenterY ) {
            top = (parentHeight - height) / 2 + self.alCenterY;
        } else if ( self.alHasSettedBottom ) {
            top = parentHeight - self.alBottom - height;
        }
    }
    // 优先级：left > centerX > right
    if ( !self.alHasSettedLeft ) {
        if ( self.alHasSettedCenterX ) {
            left = (parentWidth - width) / 2 + self.alCenterX;
        } else if ( self.alHasSettedRight ) {
            left = parentWidth - self.alRight - width;
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
        if ( lastView.isALEngine && (index == -1 || lastView.alDisplay == (ALDisplay)index) ) {
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
        if ( self.superview.isALEngine && self.superview.alPosition == ALPositionAbsolute && self.superview.alIsAutoWidth ) {
            return [self.superview getParentWidth];
        }
        return self.superview.frame.size.width;
    }
    return [[UIScreen mainScreen] bounds].size.width;
}

@end
