//
//  ALRowManager.h
//  ALView
//
//  Created by jdochen on 2016/12/3.
//  Copyright © 2016年 jdochen. All rights reserved.
//

@interface ALRowManager : NSObject
{
    NSMutableArray<ALRow *> * _rowsArr;
}

// 行管理器所属的view，换个说法：每个view都有一个ALRowManager用于管理该view的所有subView（absolute类型除外）
@property (nonatomic, weak) UIView * ownerView;
// 行管理的最大宽度，给到行布局时候用
@property (nonatomic, assign) CGFloat maxWidth;
// 当前行的最大高度，用于过滤没必要的重排
@property (nonatomic, assign) CGFloat maxHeight;

- (instancetype)initWithView: (UIView *) view;
// 在最后一行的最后个位置插入一个view
- (void) appendView: (UIView *) view;
// 指定view的Y轴值（marginTop/marginBottom/height）发生变更时需触发重排
- (void) reflowWhenYChange: (UIView *) subView need2reflowSelfTop: (BOOL) need2reflowSelfTop;
// 指定view的X轴值（marginLeft/marginRight/width）发生变更时需触发重排
- (void) reflowWhenXChange:(UIView *)subView need2ReflowSubView:(BOOL)need2ReflowSubView;
// 重排当前行管理器的subview
- (void) reflowSubView;
// 重排当前行管理器中所有行，只是重排，并不会检查断行逻辑
- (void) reflowAllRow;
// 获取当前onwerView的宽度
- (CGFloat) getOnwerViewInnerWidth;
// 获取当前onwerView的高度
- (CGFloat) getOnwerViewInnerHeight;
// 计算所属行最大宽度
- (void) calcMaxWidth;
@end
