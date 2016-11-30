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
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr addObject: view];
        }
        // 更新height值
        [self refreshMaxHeight];
    }
}

- (void) refreshMaxHeight
{
    if ( [self.viewArr count] > 0 ) {
        // reset height
        _height = 0;
        
        NSUInteger i = 0;
        NSUInteger len = [self.viewArr count];
        
        for (; i < len; i++) {
            UIView * view = [self.viewArr objectAtIndex:i];
            CGFloat h = view.marginTop +
                        view.marginBottom +
                        view.frame.size.height;
            if ( _height < h ) {
                _height = h;
            }
        }
    }
}

@end
