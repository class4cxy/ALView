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
        if ( self.rowManager && self.style.isAutoWidth ) {
            // 重排子view
            [self.rowManager reflowSubView];
            // 更新自己
            [self reflowSizeWhenAutoSizeWithSize: (CGSize){[self.rowManager getOnwerViewInnerWidth], [self.rowManager getOnwerViewInnerHeight]}];
        }
        [self reflowOriginWhenAbsolute];
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

// 重排自己
- (void) reflow
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( self.superview && self.isALEngine ) {
        [self reflowSize];
        if ( self.style.position == ALPositionRelative ) {
            // 防止未知错误
            if ( self.superview && self.superview.rowManager ) {
                [self.superview.rowManager reflowRow: self reflowInnerView: YES];
            }
        } else {
            if ( self.rowManager ) {
                [self.rowManager reflowSubView];
                [self reflowSizeWhenAutoSizeWithSize: (CGSize){[self.rowManager getOnwerViewInnerWidth], [self.rowManager getOnwerViewInnerHeight]}];
            }
            [self reflowOriginWhenAbsolute];
        }
        
        // 重排子view中使用absolute排版的
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
}

/*
 * 自动排版当前view尺寸
 */
- (void) reflowSize
{
    if ( self.superview && self.isALEngine ) {
        UIView * parent = self.superview;
        // ALLabel的计算内部size方法比较特殊，由ALLabel自己实现
        if ( [self isKindOfClass:[ALLabel class]] ) {
            [((ALLabel *) self) reflowWithInnerText: parent];
            self.hidden = self.style.hidden;
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
            // 更新内部值
            [self.style setWidthWithoutAutoWidth: width];
            [self.style setHeightWithoutAutoHeight: height];
            
            // 更新自己的行管理器maxWidth值
//            if ( !self.style.isAutoWidth && self.rowManager ) {
            if ( self.rowManager ) {
                self.rowManager.maxWidth = self.style.width;
            }
        }
    }
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
        
        self.frame = CGRectMake(left, top, width, height);
    }
}

/*
 * 如果当前view是auto size，那么根据指定的size排版当前view尺寸
 */
- (void) reflowSizeWhenAutoSizeWithSize: (CGSize) size
{
    if ( self.isALEngine ) {
        if ( self.style.isAutoHeight ) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, size.height);
            [self.style setHeightWithoutAutoHeight:size.height];
        }
        
        if ( self.style.isAutoWidth && (self.style.display != ALDisplayBlock || self.style.position == ALPositionAbsolute) ) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, self.frame.size.height);
            [self.style setWidthWithoutAutoWidth:size.width];
        }
        // 如果是ownerView是relative类型，需额外做以下逻辑：
        // 1、如果ownerView是ALScrollView类，需重排该view内部（reflowInnerFrame）
        // 2、更新ownerView所属行的size
        if ( self.style.isAutoHeight || self.style.isAutoWidth ) {
            
            // 当父view是ALScrollView，需更新scrollView的contentSize
            if ( [self isKindOfClass: [ALScrollView class]] ) {
                [((ALScrollView *) self) reflowInnerFrame];
            }
            if ( self.style.position == ALPositionRelative ) {
                [self.belongRow refreshSize];
            }
        }
    }
}

/*
 * 如果当前view是auto height，那么根据指定的height排版当前view height
 */
- (void) reflowHeightWhenAutoHeightWithHeight: (CGFloat) height
{
    if ( self.isALEngine ) {
        // 当父view是ALScrollView，需更新scrollView的contentSize
        if ( [self isKindOfClass: [ALScrollView class]] ) {
            [((ALScrollView *) self) reflowInnerFrame];
        }

        if ( self.style.isAutoHeight ) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
            [self.style setHeightWithoutAutoHeight: height];
        }
    }
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
        }
    } else {
        maxWidth = ownerView.frame.size.width;
    }
    return maxWidth;
}

@end
