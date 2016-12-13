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
#import "ALStyle.h"

@interface ALRow : NSObject

// 行高，会随着view被add进来而自动更新到最大高度
@property (nonatomic, assign, readonly) CGFloat height;
// 宽度，会随着view被add进来而自动更新到最大宽度
@property (nonatomic, assign, readonly) CGFloat width;
// 当前行的最大宽度
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, assign) BOOL isAutoWidth;
// 当前行的父view
@property (nonatomic, strong) UIView * parent;
// 当前行的排版方式
@property (nonatomic, assign) ALContentAlign contentAlign;
// 当前行插入的view类型
@property (nonatomic, assign) ALDisplay display;
// 行坐标
@property (nonatomic, assign, readonly) CGFloat top;
// 下一个兄弟Row
@property (nonatomic, retain) ALRow * nextRow;
// 上一个兄弟Row
@property (nonatomic, retain) ALRow * previousRow;

- (instancetype) init;
// 检查是否能插入该view
- (BOOL) canAddView: (UIView *) view;
// 当该Row中某个view更新的布局，重新检查是否需要断行
- (BOOL) need2break;
// 在Row头部插入一个view
- (void) addView: (UIView *) view;
// 在Row尾部插入一个view
- (void) pushView:(UIView *)view;
// 移除当前行最后一个view，并返回该view
- (UIView *) popView;
// 移除当前行的第一个view，并返回该view
- (UIView *) shiftView;
//
- (UIView *) firstView;
//
- (UIView *) lastView;
//
- (NSUInteger) count;

// 重排全部
- (void) layout;
// 仅重排origin.top值
- (void) reflowTop;
// 更新row的size
- (void) refreshSize;
@end
