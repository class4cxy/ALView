//
//  ALRowManager.h
//  ALView
//
//  Created by jdochen on 2016/12/3.
//  Copyright © 2016年 jdochen. All rights reserved.
//

@interface ALRowManager : NSObject

@property (nonatomic, strong) UIView * ownerView;
@property (nonatomic, assign) CGFloat maxWidth;

- (instancetype)initWithView: (UIView *) view;
// 在最后一行的最后个位置插入一个view
- (void) appendView: (UIView *) view;
// 重排指定view的行
- (void) reflowRow: (UIView *) subView reflowInnerView: (BOOL) isReflow;
// 重排当前行管理器的subview
- (void) reflowSubView;
//- (void) reflowOwnerViewInnerView;
// 获取当前onwerView的宽度
- (CGFloat) getOnwerViewInnerWidth;
// 获取当前onwerView的高度
- (CGFloat) getOnwerViewInnerHeight;
// 更新onwerView的size
- (void) reflowSelfSizeWhenAutoSize;

- (void) reflowSelfSizeOfAbsolute;
@end
