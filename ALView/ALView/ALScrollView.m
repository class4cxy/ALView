//
//  ALScrollView.m
//  ALView
//
//  Created by jdochen on 2016/10/23.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALScrollView.h"
#import "UIView+ALBase.h"

@interface ALScrollView() <UIScrollViewDelegate>

@end

@implementation ALScrollView

- (instancetype)init
{
    if ( self = [super initWithALBase] ) {
        self.position = ALPositionRelative;
        self.display  = ALDisplayBlock;
    }
    return self;
}
// ALScrollView的排版方式默认为block类型，不允许修改
- (void)setDisplay:(ALDisplay)display
{
    [super setDisplay: ALDisplayBlock];
}


//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSInteger i = 0;
//    NSInteger len = scrollView.subviews.count;
//    
//    for (; i < len; i++) {
//        UIView * subView = [scrollView.subviews objectAtIndex:i];
//        if ( subView.isALBase ) {
//            [subView reflowWithPositionFixed:scrollView.contentOffset];
//        }
//    }
//}

@end
