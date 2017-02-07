//
//  ALNode.h
//  ALView
//  注：节点层的逻辑（串联、转换）
//
//  Created by jdochen on 2017/1/29.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALNode : NSObject
{
    NSMutableArray * __subviews;
}

/*
 * 增加对所属view的引用，用于驱动view reflow
 */
@property(nonatomic, weak) UIView * view;
// 父view
@property (nonatomic, weak) UIView * parent;
// 下一个兄弟view
@property (nonatomic, weak) UIView * nextSibling;
// 上一个兄弟view
@property (nonatomic, weak) UIView * previousSibling;

/*
 * method
 */
- (instancetype) initWithView: (UIView *) view;
- (void) add2Parent: (UIView *) parent;
- (void) linkSiblingView;

@end
