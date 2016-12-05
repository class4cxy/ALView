//
//  UIView+ALEngine.h
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRow.h"
#import "ALRowManager.h"
#import "ALView.h"
#import "ALScrollView.h"
#import "ALLabel.h"
/*
 * AL引擎的排版方式
 * 默认：ALPositionRelative
 */
typedef NS_ENUM(NSInteger, ALPosition)
{
    /*
     * 布局计算方式：
     * 1、相对父view，相对同级view布局，
     * 2、依赖于同级view，
     * 3、不受top,left,right,bottom类影响
     */
    ALPositionRelative,
    /*
     * 【如果父view是ALView，则相对于父view的自身宽高（frame）绝对布局】
     * 布局计算依赖于：
     * 1、依赖于父view，
     * 2、依赖于top,left,right,bottom，
     * 3、不受同级view影响，不会触发父view reflow
     * 【如果父view是ALScrollView，则相对于父view的内容宽高（contentSize）绝对布局】
     * 布局计算依赖于：1、2、3
     * 4、会随着父view的contentOffset变化而变化（随着scrollView滚动）
     * 5、会随着父view的contentSize变化而变化（例如bottom或者right定位时，如果contentSize放生变化，为了保持bottom或者right不变，会重新计算该view的布局）
     */
    ALPositionAbsolute,
    
    /* 
     * 【如果父view是ALView，则相对于父view的自身宽高（frame）固定布局】
     * 注：这种情况fixed布局跟absolute布局并无差异
     * 布局计算依赖于：
     * 1、依赖于父view，
     * 2、依赖于top,left,right,bottom，
     * 3、不受同级view影响，不会触发父view reflow
     * 【如果父view是ALScrollView，同样相对于父view的自身宽高（frame）固定布局，这点跟absolute布局是不同的】
     * 布局计算依赖于：同上
     * 4、不会随着父view的contentOffset变化而变化（脱离scrollView的滚动，固定在父view的某个位置）
     */
//    ALPositionFixed,
};

/*
 * reflow自己时会用到递归去reflow相邻view
 */
typedef NS_ENUM(NSInteger, ALRecursionType) {
    // 不递归
    ALRecursionNone,
    // 递归父view
    ALRecursionParentView,
    // 递归上一个兄弟view
    ALRecursionPreviousView,
    // 递归下一个兄弟view
    ALRecursionNextView,
};


@interface UIView (ALEngine)

@property (nonatomic, assign, readonly) BOOL isALEngine; // 是否为ALEngine布局的view
/*
 * 虚拟ALView，主要用于辅助常规的ALView去实现某些能力而创建
 * 1、虚拟view的子类layout应当由使用者去定义
 * 2、虚拟view的子类应该透传所有方法、协议、变量给所继承的父类
 */
//@property (nonatomic, assign, readonly) BOOL isVirtual; // 是否为ALEngine的虚拟view

/*
 * 样式属性
 */

@property (nonatomic, assign) ALPosition position;
@property (nonatomic, assign) ALDisplay display;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
/*
 * 0表示居中，允许负值
 */
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginRight;

@property (nonatomic, assign) ALContentAlign contentAlign;

/*
 * 其他属性
 */

// 记录当前view的内部高度，该值表示子view最高高度值，未必与height值相等，例如scrollView的情况
@property (nonatomic, assign, readonly) CGFloat currInnerHeight;
// 记录当前view的内部高度，该值表示子view最高高度值，未必与width值相等，例如scrollView的情况
@property (nonatomic, assign, readonly) CGFloat currInnerWidth;
@property (nonatomic, assign, readonly) BOOL isAutoHeight; // 是否为系统自动设置高度
// 注：考虑到排版的复杂度，inline类型的view不允许不设置width值
@property (nonatomic, assign, readonly) BOOL isAutoWidth; // 是否为系统自动设置高度
@property (nonatomic, assign, readonly) BOOL isInNewLine; // inline-block节点会存在自动断行的逻辑，该属性用于标记当前节点是否是新的一行
// 记录是否设置过left值
@property (nonatomic, assign, readonly) BOOL hasSettedLeft;
// 记录是否设置过top值
@property (nonatomic, assign, readonly) BOOL hasSettedTop;
// 记录是否设置过centerX值
@property (nonatomic, assign, readonly) BOOL hasSettedCenterX;
// 记录是否设置过centerY值
@property (nonatomic, assign, readonly) BOOL hasSettedCenterY;
// 记录是否设置过bottom值
@property (nonatomic, assign, readonly) BOOL hasSettedBottom;
// 记录是否设置过right值
@property (nonatomic, assign, readonly) BOOL hasSettedRight;

// 下一个兄弟view
@property (nonatomic, retain, readonly) ALView * nextSibling;
// 上一个兄弟view
@property (nonatomic, retain, readonly) ALView * previousSibling;
// 下一个兄弟Row管理器，block类型的view才会用，为了方便递归
//@property (nonatomic, retain, readonly) ALRow * nextRow;
// 上一个兄弟Row管理器，block类型的view才会用，为了方便递归
//@property (nonatomic, retain, readonly) ALRow * previousRow;
// 管理的行数
//@property (nonatomic, assign, readonly) NSInteger rowNum;
// 所属行数
//@property (nonatomic, assign) NSInteger row;
// rows，以row为单位管理子view
//@property (nonatomic, retain) NSMutableArray<ALRow *> * rows;
// rowManager
@property (nonatomic, retain) ALRowManager * rowManager;
// 所属的行实例
@property (nonatomic, retain) ALRow * belongRow;

// 初始化AL实体view【提供给子类初始化用，实例不要调用该方法】
- (instancetype) initWithALEngine;
// 初始化AL虚拟view【提供给子类初始化用，实例不要调用该方法】
//- (instancetype) initWithALVirtuALEngine;
// 开放给实例使用，插入到父view，开始渲染
- (void) addTo: (UIView *) parent;
// 开放给实例使用，当改变样式属性时，用于刷新UI用
//- (void) refreshView;

//- (void) rowReflowWithView: (UIView *) view;
// 获取当前view的父view宽度
- (CGFloat) getParentWidth;

/*
 * 私有
 */
// 提供给子类重新布局当前view用的，实例不要调用该方法
- (void) reflow;
// 提供给子类重新排版absolute方式布局的view
//- (void) reflowWithAbsolute:(UIView *)parent;
//- (void) reflowOriginAndSizeWhenAbsolute;
- (void) reflowOriginWhenAbsolute;

@end
