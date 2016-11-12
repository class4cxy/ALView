//
//  ALScrollView.m
//  ALView
//
//  Created by jdochen on 2016/10/23.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALScrollView.h"
#import "UIView+ALBase.h"

//@implementation ALVirtualScrollView
//
//- (instancetype) init
//{
//    if ( self = [super initWithALVirtualBase] ) {
//        
//    }
//    return self;
//}
//
//@end

@implementation ALScrollView

- (instancetype)init
{
    if ( self = [super initWithALBase] ) {
        self.display  = ALDisplayBlock;
//        [self initInnerUI];
    }
    return self;
}

//- (void) initInnerUI
//{
//    self.scrollView = [[ALVirtualScrollView alloc] init];
//    self.scrollView.delegate = self;
//    [self.scrollView addTo: self];
//}

#pragma mark - 重载父类方法
// ALScrollView的排版方式默认为block类型，不允许修改
- (void)setDisplay:(ALDisplay)display
{
    [super setDisplay: ALDisplayBlock];
}

#pragma mark - 私有排版逻辑
// 触发內建UIScrollView进行layout
// 触发子view中使用了absolute方式布局的重新layout
- (void) reflowInnerFrame
{
    // 触发內建UIScrollView进行layout
//    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.contentSize = CGSizeMake(self.currInnerWidth, self.currInnerHeight);
    // 触发子view中使用了absolute布局且使用了bottom或者right方式定位的重新布局
    for (UIView * subView in self.subviews) {
        if (
            subView.isALBase &&
            subView.position == ALPositionAbsolute &&
            (subView.hasSettedBottom || subView.hasSettedRight)
        ) {
            [subView reflowWithAbsolute:self];
        }
    }
}

// 触发子view中使用了fixed方式布局的重新layout
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 触发子view中使用了fixed布局
//    for (UIView * subView in self.scrollView.subviews) {
//        if (
//            subView.isALBase &&
//            subView.position == ALPositionFixed
//            ) {
//            [subView reflow:self.scrollView];
//        }
//    }
//}

@end
