//
//  ALStyle.h
//  ALView
//
//  Created by 陈小雅 on 2016/12/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
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

/*
 * margin的枚举类型
 */
typedef NS_ENUM(NSInteger, ALMarginType)
{
    ALMarginTop,
    ALMarginLeft,
    ALMarginRight,
    ALMarginBottom,
};

/* ALRect. */
struct ALSizeIsChange {
    BOOL width;
    BOOL height;
};
typedef struct ALSizeIsChange ALSizeIsChange;

/* ALRect. */
struct ALRect {
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
    CGFloat left;
};
typedef struct ALRect ALRect;

@interface ALStyle : NSObject

/*
 * 增加对所属view的引用，用于驱动view reflow
 */
@property (nonatomic, strong) UIView * view;

/*
 * 样式属性
 */
@property (nonatomic, assign) ALPosition position;
@property (nonatomic, assign) ALDisplay display;

/*
 * 说明：控制view是否展示，如果不展示：
 * 1、自动设置height=0
 * 2、自动设置width=0
 * 3、自动设置hidden=YES
 */
@property (nonatomic, assign) BOOL hidden;

// 聚合width, height
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/** maxWidth 只能应用于inline类型的view上，因为block类型的view如果是自动宽度时，宽度也是由父view决定 **/
@property (nonatomic, assign) CGFloat maxWidth;
/** maxHeight 目前在iOS中只应用于scrollView，iOS不像web一样，任何view都可以是scrollView，后续补齐该能力 **/
@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) ALRect origin;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
// 对外只读，用于记录view的真实位置信息
@property (nonatomic, assign, readonly) CGFloat x;
@property (nonatomic, assign, readonly) CGFloat y;

/*
 * 0表示居中，允许负值
 */
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


@property (nonatomic, assign) ALRect margin;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginRight;

/*
 * padding是ALLabel特有的属性，用于撑开文字与边框的距离
 */
@property (nonatomic, assign) ALRect padding;
@property (nonatomic, assign) CGFloat paddingTop;
@property (nonatomic, assign) CGFloat paddingBottom;
@property (nonatomic, assign) CGFloat paddingLeft;
@property (nonatomic, assign) CGFloat paddingRight;

@property (nonatomic, assign) ALContentAlign contentAlign;

// 指定是否结束行，用于inline类型的view，希望在某个节点主动断行
@property (nonatomic, assign) BOOL isEndOFLine;
// 指定是否启用新的一行，用于inline类型的view，希望在某个节点在新的一行排版
@property (nonatomic, assign) BOOL isFirstOFLine;

/*
 * 其他属性
 */
@property (nonatomic, assign, readonly) BOOL isAutoHeight; // 是否为系统自动设置高度
// 注：考虑到排版的复杂度，inline类型的view不允许不设置width值
@property (nonatomic, assign, readonly) BOOL isAutoWidth; // 是否为系统自动设置高度
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

/*
 * 私有方法
 */
// 用于更新width/height值，但不改变isAutoWidth/isAutoHeight
- (void) setHeightWithoutAutoHeight:(CGFloat)height;
- (void) setWidthWithoutAutoWidth:(CGFloat)width;

// 提供给ALEngine更新x,y值用的
- (void) updateX: (CGFloat) x;
- (void) updateY: (CGFloat) y;
@end
