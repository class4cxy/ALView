//
//  UIView+ALBase.h
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALPosition)
{
    // 相对父view，相对同级view布局，
    // 依赖于父view，
    // 依赖于同级view，
    // 不受top,left,right,bottom类影响
    ALPositionRelative,
    // 相对于父view绝对布局，
    // 依赖于父view，
    // 依赖于top,left,right,bottom，
    // 不受同级view影响，不会触发父view reflow
    ALPositionAbsolute,
    ALPositionFixed, // 绝对定位，相对于window
};

typedef NS_ENUM(NSInteger, ALDisplay)
{
    ALDisplayBlock, // 块级
    ALDisplayInline, // 行内块级
};


@interface UIView (ALBase)

@property (nonatomic, assign, readonly) BOOL isALBase; // 是否为ALBase布局的view

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

@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginRight;

// TODO
//@property (nonatomic, assign) CGFloat paddingTop;
//@property (nonatomic, assign) CGFloat paddingBottom;
//@property (nonatomic, assign) CGFloat paddingLeft;
//@property (nonatomic, assign) CGFloat paddingRight;

/*
 * 其他属性
 */

// 记录当前view的内部高度，该值表示子view最高高度值，未必与height值相等
@property (nonatomic, assign, readonly) CGFloat currInnerHeight;
@property (nonatomic, assign, readonly) BOOL isAutoHeight; // 是否为系统自动设置高度
@property (nonatomic, assign, readonly) BOOL isFullWidth; // 是否为系统自动设置高度
@property (nonatomic, assign, readonly) BOOL isInNewLine; // inline-block节点会存在自动断行的逻辑，该属性用于标记当前节点是否是新的一行
// 记录是否设置过left值
@property (nonatomic, assign, readonly) BOOL hasSettedLeft;
// 记录是否设置过top值
@property (nonatomic, assign, readonly) BOOL hasSettedTop;
// 记录是否设置过bottom值
@property (nonatomic, assign, readonly) BOOL hasSettedBottom;
// 记录是否设置过right值
@property (nonatomic, assign, readonly) BOOL hasSettedRight;

- (instancetype) initWithALBase;
- (void) addTo: (UIView *) parent;
// 私有
//- (void) reflowWithPositionFixed: (CGPoint) offset;

@end
