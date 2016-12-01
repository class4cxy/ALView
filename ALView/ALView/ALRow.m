//
//  ALRow.m
//  ALView
//
//  Created by jdochen on 2016/11/28.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALRow.h"

@implementation ALRow

- (instancetype) initWithTop: (CGFloat) top
{
    if ( self = [super init] ) {
        _height = 0;
        _width = 0;
        _maxWidth = 0;
        _top = top;
        self.viewArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BOOL) canAddView: (UIView *) view
{
    return _maxWidth < _width + view.frame.size.width + view.marginLeft + view.marginRight;
}

- (void) addView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr addObject: view];
        }
        // 更新height值
        [self refreshSize];
    }
}

// 从结尾移除一个view
// 并返回最后一个view
- (UIView *) popView
{
    if ( [self.viewArr count] > 0 ) {
        UIView * lastView = [self.viewArr lastObject];
        [self.viewArr removeLastObject];
        [self refreshSize];
        return lastView;
    }
    return nil;
}

- (void) refreshSize
{
    if ( [self.viewArr count] > 0 ) {
        // reset height
        _height = 0;
        _width = 0;
        
        NSUInteger i = 0;
        NSUInteger len = [self.viewArr count];
        
        for (; i < len; i++) {
            UIView * view = [self.viewArr objectAtIndex:i];
            CGFloat h = view.marginTop +
                        view.marginBottom +
                        view.frame.size.height;
            CGFloat w = view.marginLeft +
                        view.marginRight +
                        view.frame.size.width;
            
            if ( _height < h ) {
                _height = h;
            }
            _width += w;
        }
    }
}
// 触发row内部的view进行layout，仅重排left值
- (void) reflow
{
    if ( [self.viewArr count] > 0 ) {
        
    }
}

@end
