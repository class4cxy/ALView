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

@dynamic ALEX;
- (CGFloat) ALEX
{
    return [objc_getAssociatedObject(self, @"ALEX") floatValue];
}
-(void)setALEX:(CGFloat)ALEX
{
    objc_setAssociatedObject(self, @"ALEX", [NSNumber numberWithFloat:ALEX], OBJC_ASSOCIATION_RETAIN);
}
@dynamic ALEY;
- (CGFloat) ALEY
{
    return [objc_getAssociatedObject(self, @"ALEY") floatValue];
}
-(void)setALEY:(CGFloat)ALEY
{
    objc_setAssociatedObject(self, @"ALEY", [NSNumber numberWithFloat:ALEY], OBJC_ASSOCIATION_RETAIN);
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
        
        self.nextSibling = nil;
        self.previousSibling = nil;
        
        self.style = [[ALStyle alloc] init];
        self.style.view = self;
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
    // 如果当前view并不是ALEngine，那默认把它转成
    [self translate2ALView];
    // 生成兄弟view关系
    [self linkSiblingView];
    // 排版size
    [self reflowSize];
    // 如果自己存在行管理器而且isAutoWidth==YES，那就需要重新更新行管理器的数据
    if ( self.rowManager && self.style.isAutoWidth ) {
        self.rowManager.maxWidth = [self getRowMaxWidthOf: self];
    }
    // 排版origin
    if ( self.style.position == ALPositionRelative ) {
        // 初始化父view的行管理器
        if ( !parent.rowManager ) {
            parent.rowManager = [[ALRowManager alloc] initWithView: parent];
            parent.rowManager.maxWidth = [self getRowMaxWidthOf: parent];
        }
        [parent.rowManager appendView: self];
    } else {
        [self reflowOriginWhenAbsolute];
        // 如果存在子view，检查是否需要重排子view
        if ( !self.style.hidden && self.rowManager && !self.style.isAutoWidth && self.style.contentAlign != ALContentAlignLeft ) {
            [self.rowManager reflowAllRow];
        }
    }
}

/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (UIView *) getPreviousSiblingALEngineView
{
    UIView * parent = self.superview;
    if ( parent ) {
        UIView * lastView = nil;
        NSInteger i = parent.subviews.count - 2; // 跳过自己
        
        for (; i >= 0; i--) {
            lastView = [parent.subviews objectAtIndex:i];
            if ( lastView.isALEngine ) {
                return lastView;
            }
        }
    }
    return nil;
}

/*
 * 提供给一个普通UIView转为ALView布局
 * 1、初始化size
 */
- (instancetype) translate2ALView
{
    // 避免开发者乱玩
    if ( !self.isALEngine ) {
        self.isALEngine = YES;
        self.nextSibling = nil;
        self.previousSibling = nil;
        self.style = [[ALStyle alloc] init];
        self.style.view = self;
        
        CGSize size = self.frame.size;
        
        if ( size.width ) {
            self.style.width = size.width;
        }
        if ( size.height ) {
            self.style.height = size.height;
        }
    }
    return self;
}
- (instancetype) translate2InlineALView
{
    [self translate2ALView];
    self.style.display = ALDisplayInline;
    return self;
}
- (instancetype) translate2AbsoluteALView
{
    [self translate2ALView];
    self.style.position = ALPositionAbsolute;
    return self;
}

/*
 * link view by nextSibling & previousSibling
 */

- (void) linkSiblingView
{
    UIView * lastSubView = [self getPreviousSiblingALEngineView];
    
    if ( lastSubView != nil ) {
        self.previousSibling = (ALView*)lastSubView;
        lastSubView.nextSibling = (ALView*)self;
    }
}


#pragma mark - 排版逻辑
// hidden改变，重排
- (void) reflowWhenHiddenChange
{
    if ( self.superview && self.isALEngine ) {
        if ( self.style.position == ALPositionRelative ) {
            // 满足这两条件需重刷size
            if ( self.style.hidden == NO && self.style.isAutoWidth ) {
                // 排版size
                [self reflowSize];
            }
            // 防止未知错误
            if ( self.superview.rowManager ) {
                [self.superview.rowManager reflowWhenYChange: self need2reflowSelfTop: NO];
                // 如果isAutoWidth=YES或者contentAlign != ALContentAlignLeft，需重排内部子view
                if ( (self.style.isAutoWidth || self.style.contentAlign != ALContentAlignLeft) && self.style.hidden == NO ) {
                    [self.superview.rowManager reflowWhenXChange: self need2ReflowSubView: YES];
                } else {
                    [self.superview.rowManager reflowWhenXChange: self need2ReflowSubView: NO];
                }
            }
        }
    }
}
// marginLeft/marginRight改变，重排
- (void) reflowWhenMarginXChange: (ALMarginType) marginType
{
    if ( self.superview && self.isALEngine ) {
        if ( self.style.position == ALPositionRelative ) {
            // 防止未知错误
            if ( self.superview.rowManager ) {
                [self.superview.rowManager reflowWhenXChange: self need2ReflowSubView: NO];
//                [self.superview.rowManager rowReflowWidthWithSubView: self reflowInnerView:YES];
            }
        }
    }
}
// marginTop/marginBottom改变，重排
- (void) reflowWhenMarginYChange: (ALMarginType) marginType
{
    if ( self.superview && self.isALEngine ) {
        // 重排row
        if ( self.style.position == ALPositionRelative ) { // relative
            // 防止未知错误
            if ( self.superview.rowManager ) {
                [self.superview.rowManager reflowWhenYChange:self need2reflowSelfTop: (marginType == ALMarginTop)];
//                [self.superview.rowManager rowReflowHeightWithSubView: self];
            }
        }
    }
}
// width改变，重排
- (void) reflowWhenWidthChange
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( self.superview && self.isALEngine ) {
        if ( self.style.position == ALPositionRelative ) {
            // 防止未知错误
            if ( self.superview.rowManager ) {
                [self.superview.rowManager reflowWhenXChange: self need2ReflowSubView: YES];
//                [self.superview.rowManager rowReflowWidthWithSubView: self reflowInnerView:YES];
            }
        } else {
            if ( self.rowManager ) {
                [self.rowManager reflowSubView];
                [self reflowSizeWhenAutoSizeWithSize];
            }
            [self reflowOriginWhenAbsolute];
        }
        
        [self reflowSubviewWhichISAbsolute];
    }
}

// height改变，重排
- (void) reflowWhenHeightChange
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( self.superview && self.isALEngine ) {
        // 重排row
        if ( self.style.position == ALPositionRelative ) { // relative
            // 防止未知错误
            if ( self.superview.rowManager ) {
                [self.superview.rowManager reflowWhenYChange: self need2reflowSelfTop: NO];
//                [self.superview.rowManager rowReflowHeightWithSubView: self];
            }
        } else { // absolute
//            [self reflowHeightWhenAutoHeightWithHeight];
            [self reflowOriginWhenAbsolute];
        }
        
        [self reflowSubviewWhichISAbsolute];
    }
}

// 重排子view中使用absolute排版的
- (void) reflowSubviewWhichISAbsolute
{
    for (UIView * subView in self.subviews) {
        if (
            subView.isALEngine &&
            subView.style.position == ALPositionAbsolute &&
            (subView.style.hasSettedRight ||
             subView.style.hasSettedBottom ||
             subView.style.hasSettedCenterX ||
             subView.style.hasSettedCenterY)
            ) {
            [subView reflowOriginWhenAbsolute];
        }
    }
}


/*
 * 重排当前view的width
 */
- (void) reflowWidth
{
    if ( self.superview && self.isALEngine ) {
        CGFloat width = self.style.width;
        if ( [self isKindOfClass:[ALLabel class]] ) {
            [((ALLabel *) self) reflowWithInnerText: self.superview];
        } else {
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
            }
            
            [self layoutWithWidth: width];
//            [self.style setWidthWithoutAutoWidth: width];
            
            // 更新自己的行管理器maxWidth值
            if ( self.rowManager ) {
                // isAutoWidth=NO时，需重设maxWidth
                // isAutoWidth=YES时且display=ALDisplayBlock，需重设maxWidth
                if (
                    !self.style.isAutoWidth ||
                    (self.style.isAutoWidth && self.style.display == ALDisplayBlock)
                    ) {
                    self.rowManager.maxWidth = self.style.width;
                }
            }
        }
    }
}

/*
 * 重排当前view的height
 */
- (void) reflowHeight
{
    if ( self.superview && self.isALEngine ) {
        CGFloat height = self.style.height;
        if ( [self isKindOfClass:[ALLabel class]] ) {
            [((ALLabel *) self) reflowWithInnerText: self.superview];
        } else {
            
            if ( self.style.position == ALPositionAbsolute && self.style.isAutoHeight ) {
                height = self.frame.size.height;
            }
            
            [self layoutWithHeight: height];
//            [self.style setHeightWithoutAutoHeight: height];
        }
    }
}

/*
 * 自动排版当前view尺寸
 */
- (void) reflowSize
{
    [self reflowHeight];
    [self reflowWidth];
}

/*
 * 排版absolute类型的view的origin
 */
- (void) reflowOriginWhenAbsolute
{
    if ( self.superview && self.isALEngine ) {
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
        
        [self layoutWithOrigin: CGPointMake(left, top)];
        NSLog(@"reflowOriginWhenAbsolute --- %@", NSStringFromCGRect(self.frame));
    }
}

/*
 * 如果当前view是auto size，那么根据指定的size排版当前view尺寸
 */
- (ALSizeIsChange) reflowSizeWhenAutoSizeWithSize
{
    // 是否有更新了宽度，如果没有更新宽度，其实不必要重排内部子view的origin
    ALSizeIsChange hasChange;
    if ( self.isALEngine ) {
        
        hasChange.width = [self reflowWidthWhenAutoWidth];
        hasChange.height = [self reflowHeightWhenAutoHeight];
        
        // 如果是ownerView是relative类型，需额外做以下逻辑：
        // 1、如果ownerView是ALScrollView类，需重排该view内部（reflowInnerFrame）
        // 2、更新ownerView所属行的size
        if ( hasChange.height || hasChange.width ) {
            
            // 当父view是ALScrollView，需更新scrollView的contentSize
            if ( [self isKindOfClass: [ALScrollView class]] ) {
                [((ALScrollView *) self) reflowInnerFrame];
            }
        }
    }
    return hasChange;
}
/*
 * 如果当前view是auto size，那么根据指定的size排版当前view尺寸
 */
- (BOOL) reflowWidthWhenAutoWidth
{
    // 是否有更新了宽度，如果没有更新宽度，其实不必要重排内部子view的origin
    BOOL hasChange = NO;
    // 取最新的宽度
    CGFloat width = -1;
    if ( self.rowManager ) {
        width = [self.rowManager getOnwerViewInnerWidth];
    } else if ( [self isKindOfClass:[ALLabel class]] ) {
        width = self.style.width;
    }
    if (
        width > -1 &&
        self.isALEngine &&
        self.style.isAutoWidth &&
        self.style.width != width &&
        ((self.style.display == ALDisplayBlock &&
          // TODO，这里对ALLabel有兼容问题
          self.style.width < width &&
          width <= self.rowManager.maxWidth) ||
         self.style.display == ALDisplayInline ||
         self.style.position == ALPositionAbsolute)
    ) {
        [self layoutWithWidth: width];
//        [self.style setWidthWithoutAutoWidth: width];
        // 更新行信息
        if ( self.style.position == ALPositionRelative ) {
            [self.belongRow refreshWidth];
        }
        hasChange = YES;
    }
    
    return hasChange;
}

/*
 * 如果当前view是auto height，那么根据指定的height排版当前view height
 */
- (BOOL) reflowHeightWhenAutoHeight
{
    BOOL hasChange = NO;
    // 取最新的高度
    CGFloat height = -1;
    if ( self.rowManager ) {
        height = [self.rowManager getOnwerViewInnerHeight];
    } else if ( [self isKindOfClass:[ALLabel class]] ) {
        height = self.style.height;
    }
    if (
        height > -1 &&
        self.isALEngine &&
        self.style.isAutoHeight &&
        height != self.style.height
    ) {
        // 当父view是ALScrollView，需更新scrollView的contentSize
        //        if ( [self isKindOfClass: [ALScrollView class]] ) {
        //            [((ALScrollView *) self) reflowInnerFrame];
        //        }
        
        [self layoutWithHeight: height];
//        [self.style setHeightWithoutAutoHeight: height];
        // 更新行信息
        if ( self.style.position == ALPositionRelative ) {
            [self.belongRow refreshHeight];
        }
        hasChange = YES;
    }
    
    return hasChange;
}

/*
 * 获取父view的宽度
 * 特殊：使用absolute布局且isAutoWidth=YES的父view，需递归一直往上查找
 */
- (CGFloat) getRowMaxWidthOf: (UIView *) ownerView
{
    CGFloat maxWidth = 0;
    if ( ownerView.isALEngine && ownerView.style.isAutoWidth ) {
        if ( ownerView.belongRow ) {
            maxWidth = ownerView.belongRow.maxWidth;
        } else if ( ownerView.superview ) {
            return [self getRowMaxWidthOf: ownerView.superview];
        } else {
            // 否则直接返回屏幕宽度
            maxWidth = [[UIScreen mainScreen] bounds].size.width;
        }
        // 不能超过指定的最大值
        if ( ownerView.style.maxWidth && ownerView.style.maxWidth < maxWidth ) {
            maxWidth = ownerView.style.maxWidth;
        }
        // isAutoWidth=YES的情况，需减去左右外边距才是正真的最大宽度
        if ( ownerView.style.position == ALPositionRelative ) {
            // 减去自身的外边距
            maxWidth -= (ownerView.style.marginRight + ownerView.style.marginLeft);
        }
    } else {
        if ( ownerView.isALEngine ) {
            maxWidth = ownerView.style.width;
        } else {
            maxWidth = ownerView.frame.size.width;
        }
    }
    
    return maxWidth;
}

#pragma mark - layout

- (void) layoutWithTop: (CGFloat) top
{
    CGRect f = self.frame;
    f.origin.y = top;
    self.ALEY = top;
    self.frame = f;
}

- (void) layoutWithLeft: (CGFloat) left
{
    CGRect f = self.frame;
    f.origin.x = left;
    self.ALEY = left;
    self.frame = f;
}

- (void) layoutWithOrigin: (CGPoint) origin
{
    CGRect f = self.frame;
    f.origin = origin;
    self.ALEX = origin.x;
    self.ALEY = origin.y;
    self.frame = f;
}

- (void) layoutWithWidth: (CGFloat) width
{
    CGRect f = self.frame;
    f.size.width = width;
    self.frame = f;
    [self.style setWidthWithoutAutoWidth: width];
}

- (void) layoutWithHeight: (CGFloat) height
{
    CGRect f = self.frame;
    f.size.height = height;
    self.frame = f;
    [self.style setHeightWithoutAutoHeight: height];
}

- (void) layoutWithSize: (CGSize) size
{
    CGRect f = self.frame;
    f.size = size;
    self.frame = f;
    [self.style setWidthWithoutAutoWidth: size.width];
    [self.style setHeightWithoutAutoHeight: size.height];
}

@end
