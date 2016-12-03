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
// 重排自己高度
//- (void) reflowSelfHeight;
//// 重排子Row坐标
//- (void) reflowChildrenRowTop;
// 重排自己
- (void) reflowSelfView;

@end
