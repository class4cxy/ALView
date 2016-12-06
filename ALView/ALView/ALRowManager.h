//
//  ALRowManager.h
//  ALView
//
//  Created by jdochen on 2016/12/3.
//  Copyright © 2016年 jdochen. All rights reserved.
//

@interface ALRowManager : NSObject

@property (nonatomic, retain) UIView * ownerView;

- (instancetype)initWithView: (UIView *) view;
// 在最后一行的最后个位置插入一个view
- (void) appendView: (UIView *) view;
// 重排子view
- (void) reflowChildView: (UIView *) view;
// 获取当前onwerView的宽度
- (CGFloat) getOnwerViewInnerWidth;
// 获取当前onwerView的高度
- (CGFloat) getOnwerViewInnerHeight;

@end
