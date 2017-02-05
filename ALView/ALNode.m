//
//  ALNode.m
//  ALView
//
//  Created by jdochen on 2017/1/29.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "ALNode.h"
#import "UIView+ALEngine.h"

@implementation ALNode

- (instancetype) initWithView: (UIView *) view
{
    if ( self = [super init] ) {
        self.view = view;
        self.parent = nil;
        self.nextSibling = nil;
        self.previousSibling = nil;
    }
    return self;
}


#pragma mark - 节点操作逻辑

- (void) add2Parent: (UIView *) parent
{
    if ( parent ) {
        [parent addSubview: _view];
        self.parent = parent;
    }
}
/*
 * link view by nextSibling & previousSibling
 */
- (void) linkSiblingView
{
    UIView * lastSubView = [self getPreviousSiblingALEngineView];
    
    if ( lastSubView != nil ) {
        lastSubView.node.nextSibling = _view;
        self.previousSibling = lastSubView;
    }
}


/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (UIView *) getPreviousSiblingALEngineView
{
    if ( _parent ) {
        id lastView = nil;
        NSInteger i = _parent.subviews.count - 2; // 跳过自己
        for (; i >= 0; i--) {
            lastView = [_parent.subviews objectAtIndex:i];
            if (
                [lastView isKindOfClass:[UIView class]] && ((UIView*)lastView).isALEngine
            ) {
                return lastView;
            }
        }
    }
    return nil;
}

@end
