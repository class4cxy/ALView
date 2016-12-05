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

/*
 * 内容对齐方式，适用于所有使用AL引擎布局的的view
 * 注：
 * 1、该属性有继承性，父view设置了该属性，子view也拥有同样的属性
 * 2、该属性只适用于relative方式布局的子view
 * 默认：ALContentAlignLeft
 * 注：inline类型的view支持ALContentAlignRight 与 ALContentAlignCenter，但是需设置固定宽度的前提，否则会出现布局错乱
 */
typedef NS_ENUM(NSInteger, ALContentAlign) {
    // 内容左对齐
    ALContentAlignLeft,
    // 内容右对齐
    ALContentAlignRight,
    // 内容居中
    ALContentAlignCenter,
};

/*
 * AL引擎的排版类型
 * 默认：ALDisplayBlock
 */
typedef NS_ENUM(NSInteger, ALDisplay)
{
    /*
     * 说明：块级view
     * 布局计算方式：
     * 1、紧接着上一个block类型的view，并以新的一行开始布局（x = 0; y = preBlockView.frame.origin.y + preBlockView.frame.size.height）
     */
    ALDisplayBlock,
    /*
     * 说明：行内view
     * 布局方式：
     * 【如果上一个view是block类型】
     * 1、紧接着上一个view，并以新的一行开始布局（x = 0; y = preView.frame.origin.y + preView.frame.size.height）
     * 【如果上一个view是inline类型】
     * 2、紧接着上一个view，在上一个view的右侧开始布局（x = preView.frame.origin.x + preView.frame.size.width; y = preView.frame.origin.y）
     */
    ALDisplayInline,
};

@interface ALRow : NSObject

// 行高，会随着view被add进来而自动更新到最大高度
@property (nonatomic, assign, readonly) CGFloat height;
// 宽度，会随着view被add进来而自动更新到最大宽度
@property (nonatomic, assign, readonly) CGFloat width;
// 当前行的最大宽度
@property (nonatomic, assign) CGFloat maxWidth;
// 当前行的排版方式
@property (nonatomic, assign) ALContentAlign contentAlign;
// 当前行插入的view类型
@property (nonatomic, assign) ALDisplay display;
// 行坐标
@property (nonatomic, assign, readonly) CGFloat top;
// 存储的子view，该属性不允许实例手动去维护，务必要通过addView方法添加view
@property (nonatomic, retain) NSMutableArray * viewArr;
// 下一个兄弟Row
@property (nonatomic, retain) ALRow * nextRow;
// 上一个兄弟Row
@property (nonatomic, retain) ALRow * previousRow;

- (instancetype) init;
//- (instancetype) initWithTop: (CGFloat) top contentAlign: (ALContentAlign) contentAlign display: (ALDisplay) display;
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
// 更新制定view的frame，并触发该行所有view进行重排
//- (void) updateSize: (CGRect) frame view: (UIView *) view;
// 更新制定view的frame，并重算该行高度
//- (void) updateHeight: (CGRect) frame view: (UIView *) view;
@end
