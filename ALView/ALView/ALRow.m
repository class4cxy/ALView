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

- (instancetype) initWithTop: (CGFloat) top contentAlign: (ALContentAlign) contentAlign
{
    if ( self = [super init] ) {
        _height = 0;
        _width = 0;
        _maxWidth = 0;
        _top = top;
        _contentAlign = contentAlign;
        self.viewArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}
// TODO, 考虑单行业超过maxWidth的情况
- (BOOL) canAddView: (UIView *) view
{
    // 特殊逻辑，如果当前行已经没有子view，那直接返回YES
    if ( [self.viewArr count] == 0 ) {
        return YES;
    }
    return _maxWidth < _width + view.frame.size.width + view.marginLeft + view.marginRight;
}

- (void) addView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr insertObject:view atIndex:0];
        }
        // 更新height值
        [self refreshSize];
        [self reflow];
    }
}

- (void) pushView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr addObject: view];
        }
        // 更新height值
        [self refreshSize];
        [self reflow];
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
    NSInteger i = 0;
    NSInteger len = [self.viewArr count];
    
    for ( ; i < len; i++ ) {
        UIView * view = [self.viewArr objectAtIndex: 0];
        UIView * prevView = view.previousSibling;
        CGFloat left = 0;
        CGFloat top = _top + view.marginTop;
        
        if ( i == 0 ) {
            if ( _contentAlign == ALContentAlignCenter ) {
                left = (_maxWidth - _width)/2 + view.marginLeft;
            } else if ( _contentAlign == ALContentAlignRight ) {
                left = _maxWidth - _width + view.marginLeft;
            } else {
                left = 0;
            }
        } else {
            left =  view.marginLeft +
                    prevView.frame.origin.x +
                    prevView.frame.size.width +
                    prevView.marginRight;
        }
        
        view.frame = CGRectMake(left, top, view.frame.size.width, view.frame.size.height);
    }
}

@end
