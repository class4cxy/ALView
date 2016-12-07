//
//  UIView+ALEngine.h
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALStyle.h"
#import "ALRow.h"
#import "ALRowManager.h"
#import "ALView.h"
#import "ALScrollView.h"
#import "ALLabel.h"

/*
 * reflow自己时会用到递归去reflow相邻view
 */
//typedef NS_ENUM(NSInteger, ALRecursionType) {
//    // 不递归
//    ALRecursionNone,
//    // 递归父view
//    ALRecursionParentView,
//    // 递归上一个兄弟view
//    ALRecursionPreviousView,
//    // 递归下一个兄弟view
//    ALRecursionNextView,
//};


@interface UIView (ALEngine)

@property (nonatomic, assign, readonly) BOOL isALEngine; // 是否为ALEngine布局的view

/*
 * 样式属性
 */
@property (nonatomic, strong) ALStyle * style;

// 下一个兄弟view
@property (nonatomic, retain, readonly) ALView * alNextSibling;
// 上一个兄弟view
@property (nonatomic, retain, readonly) ALView * alPreviousSibling;
// 行管理器
@property (nonatomic, retain) ALRowManager * alRowManager;
// 所属的行实例
@property (nonatomic, retain) ALRow * alBelongRow;

// 初始化AL实体view【提供给子类初始化用，实例不要调用该方法】
- (instancetype) initWithALEngine;
// 初始化AL虚拟view【提供给子类初始化用，实例不要调用该方法】
//- (instancetype) initWithALVirtuALEngine;
// 开放给实例使用，插入到父view，开始渲染
- (void) addTo: (UIView *) parent;
// 获取当前view的父view宽度
- (CGFloat) getParentWidth;

/*
 * 私有
 */
// 提供给子类重新布局当前view用的，实例不要调用该方法
- (void) reflow;
// 提供给子类重排自身的size
- (void) reflowSelfSize;
// 提供给子类重新排版absolute方式布局的view
- (void) reflowOriginWhenAbsolute;

@end
