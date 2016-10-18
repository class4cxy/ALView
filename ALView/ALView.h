//
//  ALView.h
//  autolayout
//
//  Created by 陈小雅 on 16/10/14.
//  Copyright © 2016年 陈小雅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALPosition)
{
    ALPositionRelative, // 相对定位，相对于父view
    ALPositionAbsolute, // 绝对定位，相对于父view
    ALPositionFixed, // 绝对定位，相对于window
};

typedef NS_ENUM(NSInteger, ALDisplay)
{
    ALDisplayBlock, // 块级
    ALDisplayInlineBlock, // 行内块级
};


@interface ALView : UIView

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

/*
 * 其他属性
 */

@property (nonatomic, assign, readonly) BOOL isAutoHeight; // 是否为系统自动设置高度
@property (nonatomic, assign, readonly) BOOL isFullWidth; // 是否为系统自动设置高度
@property (nonatomic, assign, readonly) BOOL isInNewLine; // inline-block节点会存在自动断行的逻辑，该属性用于标记当前节点是否是新的一行
//@property (nonatomic, assign) CGFloat parentMaxHeight;

- (instancetype) init;
- (void) addTo: (UIView *) parent;

@end
