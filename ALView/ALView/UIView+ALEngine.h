//
//  UIView+ALEngine.h
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALView.h"
#import "ALStyle.h"
#import "ALRow.h"
#import "ALRowManager.h"
#import "ALScrollView.h"
#import "ALLabel.h"

@interface UIView (ALEngine)

@property (nonatomic, assign, readonly) BOOL isALEngine; // 是否为ALEngine布局的view

/*
 * 样式属性
 */
@property (nonatomic, strong) ALStyle * style;
// 私有x, y属性，外界只读
@property (nonatomic, assign, readonly) CGFloat ALEX;
@property (nonatomic, assign, readonly) CGFloat ALEY;
// 下一个兄弟view
@property (nonatomic, retain, readonly) ALView * nextSibling;
// 上一个兄弟view
@property (nonatomic, retain, readonly) ALView * previousSibling;
// 行管理器
@property (nonatomic, retain) ALRowManager * rowManager;
// 所属的行实例
@property (nonatomic, retain) ALRow * belongRow;

// 初始化AL实体view【提供给子类初始化用，实例不要调用该方法】
- (instancetype) initWithALEngine;
// 开放给实例使用，插入到父view，开始渲染
- (void) addTo: (UIView *) parent;
/*
 * 提供给一个普通UIView转为ALView布局
 * 1、初始化size
 */
- (instancetype) translate2ALView;
- (instancetype) translate2InlineALView;
- (instancetype) translate2AbsoluteALView;

#pragma mark - 私有方法，仅提供子类调用，实例不能使用
// 提供给子类重排自身的size
- (void) reflowSize;
// 提供给子类重新排版absolute方式布局的view
- (void) reflowOriginWhenAbsolute;

- (void) reflowSubviewWhichISAbsolute;
/*
 * 如果当前view是auto size，那么根据指定的size排版当前view尺寸
 */
- (ALSizeIsChange) reflowSizeWhenAutoSizeWithSize;
/*
 * 如果当前view是auto height，那么根据指定的height排版当前view height
 */
- (BOOL) reflowHeightWhenAutoHeight;
- (BOOL) reflowWidthWhenAutoWidth;

- (CGFloat) getRowMaxWidthOf: (UIView *) ownerView;



/*
 * 单向刷新逻辑
 */
// 重排height
- (void) reflowHeight;
// 重排width
- (void) reflowWidth;

// 当height改变时，触发相关重排
- (void) reflowWhenHeightChange;
// 当width改变时，触发相关重排
- (void) reflowWhenWidthChange;
// 当marginLeft或marginRight改变时，触发相关重排
- (void) reflowWhenMarginXChange: (ALMarginType) marginType;
// 当marginTop或marginBottom改变时，触发相关重排
- (void) reflowWhenMarginYChange: (ALMarginType) marginType;
// 当hidden改变时，触发相关重排
- (void) reflowWhenHiddenChange;

/*
 * 更新排版
 */
- (void) layoutWithTop: (CGFloat) top;
- (void) layoutWithLeft: (CGFloat) left;
- (void) layoutWithOrigin: (CGPoint) origin;
- (void) layoutWithWidth: (CGFloat) width;
- (void) layoutWithHeight: (CGFloat) height;
- (void) layoutWithSize: (CGSize) size;

@end
