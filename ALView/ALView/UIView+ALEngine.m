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
    [self translate2ALEngin];
    // 初始化父view的行管理器
    if ( self.style.position == ALPositionRelative ) {
        [self initParentRowManager];
    }
    // 如果自己存在行管理器，那就需要重新更新行管理器的数据
    // TODO: 获取maxWidth方法待改造
    if ( self.rowManager ) {
        if ( self.style.isAutoWidth ) {
            self.rowManager.maxWidth = self.superview.frame.size.width;
        } else {
            self.rowManager.maxWidth = self.frame.size.width;
        }
    }
    // 生成兄弟view关系
    [self linkSiblingView];
    // 排版size
    [self reflowSelfSize];
    // 排版origin
    if ( self.style.position == ALPositionRelative ) {
        [parent.rowManager appendView: self];
    } else {
        if ( self.rowManager && self.style.isAutoWidth ) {
            // 重排子view
            [self.rowManager reflowSubView];
            // 更新自己
            [self.rowManager reflowSelfSizeWhenAutoSize];
        }
        [self reflowOriginWhenAbsolute];
    }
}

- (void) initParentRowManager
{
    UIView * parent = self.superview;
    if ( parent ) {
        if ( !parent.rowManager ) {
            parent.rowManager = [[ALRowManager alloc] initWithView: parent];
        }

        if ( parent.isALEngine && parent.style.isAutoWidth ) {
            if ( parent.belongRow ) {
                parent.rowManager.maxWidth = parent.belongRow.maxWidth;
            } else {
                parent.rowManager.maxWidth = parent.superview.frame.size.width;
            }
        } else {
            parent.rowManager.maxWidth = parent.frame.size.width;
        }
    }
}

/*
 * 提供给一个普通UIView转为ALView布局
 * 1、初始化size
 */
- (instancetype) translate2ALEngin
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
- (instancetype) translate2ALEnginWithPosition: (ALPosition) position
{
    [self translate2ALEngin];
    self.style.position = position;
    return self;
}
- (instancetype) translate2ALEnginWithPosition: (ALPosition) position andDisplay: (ALDisplay) display
{
    [self translate2ALEngin];
    self.style.display = display;
    self.style.position = position;
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


#pragma mark - 排版逻辑

// 重排自己
- (void) reflow
{
    // SuperView不存在情况表明该view还没渲染出来
    if ( self.superview && self.isALEngine ) {
        [self reflowSelfSize];
        if ( self.style.position == ALPositionRelative ) {
            // 防止未知错误
            if ( self.superview && self.superview.rowManager ) {
                [self.superview.rowManager reflowRow: self reflowInnerView: YES];
            }
        } else {
            if ( self.rowManager ) {
                [self.rowManager reflowSubView];
                [self.rowManager reflowSelfSizeOfAbsolute];
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

/*
 * 排版自身尺寸
 */
- (void) reflowSelfSize
{
    if ( self.superview && self.isALEngine ) {
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
            // 更新内部值
            [self.style setWidthWithoutAutoWidth: width];
            [self.style setHeightWithoutAutoHeight: height];
            
            // 更新自己的行管理器maxWidth值
            if ( !self.style.isAutoWidth && self.rowManager ) {
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

#pragma mark - 私有方法
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
