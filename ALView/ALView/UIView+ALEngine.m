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

@dynamic style;
- (ALStyle *) style
{
    return objc_getAssociatedObject(self, @"style");
}
-(void)setStyle:(ALStyle *)style
{
    objc_setAssociatedObject(self, @"style", style, OBJC_ASSOCIATION_RETAIN);
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
        
        self.alNextSibling = nil;
        self.alPreviousSibling = nil;
        
        self.style = [[ALStyle alloc] init];
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
    if ( self.style.position == ALPositionRelative ) {
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
    [self reflowSelfSize];
    if ( self.style.position == ALPositionRelative ) {
        // 防止未知错误
        if ( self.superview && self.superview.alRowManager ) {
            [self.superview.alRowManager reflowRow: self stopRecur:NO];
        }
    } else {
        [self reflowOriginWhenAbsolute];
        if ( self.alRowManager ) {
            [self.alRowManager reflowOwnerViewInnerView];
        }
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
        CGFloat width = self.style.width;
        CGFloat height = self.style.height;
        // 相对定位时
        if ( self.style.position == ALPositionRelative ) {
            // 如果是block，且自动宽度布局，那默认宽度是父view的宽度
            if ( self.style.display == ALDisplayBlock && self.style.isAutoWidth ) {
                width = self.superview.frame.size.width - self.style.marginLeft - self.style.marginRight;
            }
        // 绝对定位时
        } else {
            // 如果使用了isAutoWidth或者isAutoHeight，直接使用现有的宽高，因为子view被插入时，会更新内部的size
            if ( self.style.isAutoWidth ) {
                width = self.frame.size.width;
            }
            if ( self.style.isAutoHeight ) {
                height = self.frame.size.height;
            }
        }
        
        // reflow
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
        self.hidden = self.style.hidden;
    }
}

/*
 * 排版absolute类型的view的origin
 */
- (void) reflowOriginWhenAbsolute
{
    UIView * parent = self.superview;
    
    CGFloat top = self.style.top;
    CGFloat left = self.style.left;
    
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
    if ( !self.style.hasSettedTop ) {
        if ( self.style.hasSettedCenterY ) {
            top = (parentHeight - height) / 2 + self.style.centerY;
        } else if ( self.style.hasSettedBottom ) {
            top = parentHeight - self.style.bottom - height;
        }
    }
    // 优先级：left > centerX > right
    if ( !self.style.hasSettedLeft ) {
        if ( self.style.hasSettedCenterX ) {
            left = (parentWidth - width) / 2 + self.style.centerX;
        } else if ( self.style.hasSettedRight ) {
            left = parentWidth - self.style.right - width;
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
        if ( lastView.isALEngine && (index == -1 || lastView.style.display == (ALDisplay)index) ) {
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
        if ( self.superview.isALEngine && self.superview.style.position == ALPositionAbsolute && self.superview.style.isAutoWidth ) {
            return [self.superview getParentWidth];
        }
        return self.superview.frame.size.width;
    }
    return [[UIScreen mainScreen] bounds].size.width;
}

@end
