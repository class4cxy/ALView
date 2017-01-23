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
    if ( self = [super initALEngine] ) {
        self.style.display  = ALDisplayBlock;
    }
    return self;
}

- (instancetype) initAbsolute
{
    if ( self = [super initALEngine] ) {
        self.style.position  = ALPositionAbsolute;
        self.style.display  = ALDisplayBlock;
    }
    return self;
}

#pragma mark - 私有排版逻辑
// 触发內建UIScrollView进行layout
// 触发子view中使用了absolute方式布局的重新layout
- (void) reflowInnerFrame
{
    CGFloat innerWidth = [self.rowManager getOnwerViewInnerWidth];
    CGFloat innerHeight = [self.rowManager getOnwerViewInnerHeight];
    CGSize cz = self.contentSize;
    
    if ( innerWidth != self.contentSize.width ) {
        cz.width = innerWidth;
        self.contentSize = cz;
        // 内部宽度改变，触发子view中使用了absolute布局且使用了right方式定位的重新布局
        // TODO 重排有待优化
        for (UIView * subView in self.subviews) {
            if (
                subView.isALEngine &&
                subView.style.position== ALPositionAbsolute &&
                subView.style.hasSettedRight
            ) {
                [subView reflowOriginWhenAbsolute];
            }
        }
    }
    
    if ( innerHeight != self.contentSize.width ) {
        cz.height = innerHeight;
        self.contentSize = cz;
        // 内部高度改变，触发子view中使用了absolute布局且使用了bottom方式定位的重新布局
        // TODO 重排有待优化
        for (UIView * subView in self.subviews) {
            if (
                subView.isALEngine &&
                subView.style.position== ALPositionAbsolute &&
                subView.style.hasSettedBottom
            ) {
                [subView reflowOriginWhenAbsolute];
            }
        }
    }
}

@end
