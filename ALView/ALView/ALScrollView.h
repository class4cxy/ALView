//
//  ALScrollView.h
//  ALView
//
//  Created by jdochen on 2016/10/23.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALVirtualScrollView : UIScrollView

- (instancetype) init;

@end

@interface ALScrollView : UIView

// 內建虚拟view，scrollView
@property (nonatomic, retain) ALVirtualScrollView * scrollView;

- (instancetype) init;
// private method
- (void) reflowInnerFrame;

@end
