//
//  ALRow.m
//  ALView
//
//  Created by jdochen on 2016/11/28.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALRow.h"
#import "UIView+ALEngine.h"

@implementation ALRow

- (instancetype) initWithTop: (CGFloat) top
{
    if ( self = [super init] ) {
        _height = 0;
        _top = top;
        self.viewArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addView:(UIView *)view
{
    if ( view != nil ) {
        CGFloat newHeight = view.frame.size.height +
                            view.marginTop +
                            view.marginBottom;
        // 更新height值
        if ( _height < newHeight ) {
            _height = newHeight;
        }
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr addObject: view];
        }
    }
}

@end
