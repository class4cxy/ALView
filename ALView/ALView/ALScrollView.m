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
        self.alDisplay  = ALDisplayBlock;
    }
    return self;
}

#pragma mark - 重载父类方法
// ALScrollView的排版方式默认为block类型，不允许修改
- (void)setAlDisplay:(ALDisplay)alDisplay
{
    [super setAlDisplay: ALDisplayBlock];
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
            subView.alPosition== ALPositionAbsolute &&
            (subView.alHasSettedBottom || subView.alHasSettedRight)
        ) {
            [subView reflowOriginWhenAbsolute];
        }
    }
}

@end
