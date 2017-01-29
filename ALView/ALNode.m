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
        self.nextSibling = nil;
        self.previousSibling = nil;
    }
    return self;
}

#pragma mark - 节点操作逻辑

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
- (UIView *) getPreviousSiblingALEngineView
{
    UIView * parent = _view.superview;
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

@end
