//
//  ALNode.m
//  ALView
//
//  Created by jdochen on 2017/1/29.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "ALNode.h"
#import "UIView+ALEngine.h"
#import "ALVirtualView.h"

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

- (NSArray *) subviews
{
    // UIView
    if ( [_parent isKindOfClass:[UIView class]] ) {
        return ((UIView *) _parent).subviews;
    }
    // Virtual view
    return _subviews;
}

#pragma mark - 节点操作逻辑

- (void) add2ParentView: (id) parent
{
    if ( parent ) {
        // UIView
        if ( [parent isKindOfClass:[UIView class]] ) {
            [parent addSubview: _view];
        // Virtual view
        } else if ( [parent isKindOfClass:[ALVirtualView class]] ) {
            
        }
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
        self.previousSibling = lastSubView;
        lastSubView.node.nextSibling = _view;
    }
}


/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
//- (UIView *) getPreviousSiblingALEngineView
//{
//    UIView * parent = _view.superview;
//    if ( parent ) {
//        UIView * lastView = nil;
//        NSInteger i = parent.subviews.count - 2; // 跳过自己
//        
//        for (; i >= 0; i--) {
//            lastView = [parent.subviews objectAtIndex:i];
//            if ( lastView.isALEngine ) {
//                return lastView;
//            }
//        }
//    }
//    return nil;
//}

- (UIView *) getPreviousSiblingALEngineView
{
    if ( _parent ) {
        id lastView = nil;
        NSInteger i = _subviews.count - 2; // 跳过自己
        for (; i >= 0; i--) {
            lastView = [_subviews objectAtIndex:i];
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
