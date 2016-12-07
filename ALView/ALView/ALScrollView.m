//
//  ALScrollView.m
//  ALView
//
//  Created by jdochen on 2016/10/23.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALScrollView.h"
#import "UIView+ALEngine.h"

@implementation ALScrollView

- (instancetype)init
{
    if ( self = [super initWithALEngine] ) {
        self.style.display  = ALDisplayBlock;
    }
    return self;
}

#pragma mark - 私有排版逻辑
// 触发內建UIScrollView进行layout
// 触发子view中使用了absolute方式布局的重新layout
- (void) reflowInnerFrame
{
    // 触发內建UIScrollView进行layout
    self.contentSize = CGSizeMake([self.alRowManager getOnwerViewInnerWidth], [self.alRowManager getOnwerViewInnerHeight]);
    // 触发子view中使用了absolute布局且使用了bottom或者right方式定位的重新布局
    for (UIView * subView in self.subviews) {
        if (
            subView.isALEngine &&
            subView.style.position== ALPositionAbsolute &&
            (subView.style.hasSettedBottom || subView.style.hasSettedRight)
        ) {
            [subView reflowOriginWhenAbsolute];
        }
    }
}

@end
