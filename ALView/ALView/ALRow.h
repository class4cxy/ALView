//
//  ALRow.h
//  ALRow 是ALView布局的基本行信息，主要用于保存该行的相关信息，譬如行高，Y轴坐标，这将大大简化动态计算的复杂度
//  ALRow 不属于view，适用于管理view
//  ALView
//
//  Created by jdochen on 2016/11/28.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ALEngine.h"

@interface ALRow : NSObject

// 行高，会随着view被add进来而自动更新到最大高度
@property (nonatomic, assign, readonly) CGFloat height;
// 宽度，会随着view被add进来而自动更新到最大宽度
@property (nonatomic, assign, readonly) CGFloat width;
// 当前行的最大宽度
@property (nonatomic, assign, readonly) CGFloat maxWidth;
// 当前行的排版方式
@property (nonatomic, assign) ALContentAlign contentAlign;
// 行坐标
@property (nonatomic, assign, readonly) CGFloat top;
// 存储的子view，该属性不允许实例手动去维护，务必要通过addView方法添加view
@property (nonatomic, retain) NSMutableArray * viewArr;

- (instancetype) initWithTop: (CGFloat) top;
// 检查是否能插入该view
- (BOOL) canAddView: (UIView *) view;
// 插入该view
- (void) addView: (UIView *) view;
// 弹出最后一个view
- (UIView *) popView;
// 重排该row里面的所有view
- (void) reflow;

@end