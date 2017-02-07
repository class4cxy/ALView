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

@dynamic node;
- (ALNode *) node
{
    return objc_getAssociatedObject(self, @"node");
}
-(void)setNode:(ALNode *)node
{
    objc_setAssociatedObject(self, @"node", node, OBJC_ASSOCIATION_RETAIN);
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
- (instancetype) initALEngine
{
    if ( self = [self initWithFrame:CGRectZero] ) {
        
        self.isALEngine = YES;
        
        self.style = [[ALStyle alloc] initWithView: self];
        
        self.node = [[ALNode alloc] initWithView: self];
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
//    [parent addSubview: self];
    [self.node add2Parent: parent];
    // 如果当前view并不是ALEngine，那默认把它转成
    [self translate2ALView];
    // 生成兄弟view关系
    [self.node linkSiblingView];
    // 排版size
    [self.style layoutSize];
    // 如果自己存在行管理器而且isAutoWidth==YES，那就需要重新更新行管理器的数据
    if ( self.rowManager && self.style.isAutoWidth ) {
        [self.rowManager calcMaxWidth];
    }
    // 排版origin
    if ( self.style.position == ALPositionRelative ) {
        // 初始化父view的行管理器
        if ( !parent.rowManager ) {
            parent.rowManager = [[ALRowManager alloc] initWithView: parent];
        }
        [parent.rowManager appendView: self];
    } else {
        [self.style layoutOriginWhenAbsolute];
        // 如果存在子view，检查是否需要重排子view
        if ( !self.style.hidden && self.rowManager && !self.style.isAutoWidth && self.style.contentAlign != ALContentAlignLeft ) {
            [self.rowManager reflowAllRow];
        }
    }
}

#pragma mark - translate
/*
 * 提供给一个普通UIView转为ALView布局
 * 1、初始化size
 */
- (instancetype) translate2ALView
{
    // 避免开发者乱玩
    if ( !self.isALEngine ) {
        self.isALEngine = YES;
        self.style = [[ALStyle alloc] initWithView: self];
        self.node = [[ALNode alloc] initWithView: self];
        
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

@end
