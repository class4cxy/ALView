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

- (instancetype) init
{
    if ( self = [super init] ) {
        _height = 0;
        _width = 0;
        _maxWidth = 0;
        _top = 0;
        _contentAlign = ALContentAlignLeft;
        _display = ALDisplayBlock;
        self.viewArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (BOOL) canAddView: (UIView *) view
{
    // 特殊逻辑：
    // 1、如果当前行是block行，那直接返回NO
    // 2、如果插入的view是block类型，那直接返回NO
    if ( self.display == ALDisplayBlock || view.display == ALDisplayBlock ) {
        return NO;
    }
    // 3、如果当前行已经没有子view，那直接返回YES
    if ( [self.viewArr count] == 0 ) {
        return YES;
    }
    return _maxWidth > _width + view.frame.size.width + view.marginLeft + view.marginRight;
}

- (void) addView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr insertObject:view atIndex:0];
        }
        [self layout];
        // 更新height值
//        [self refreshSize];
//        [self reflow];
    }
}

- (void) pushView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr addObject: view];
        }
        // 更新height值
        [self layout];
    }
}
// 更新所有尺寸可以调该接口，会触发行内所有view重排
- (void) updateSize: (CGRect) frame view: (UIView *) view
{
    view.frame = frame;
    [self refreshSize];
    [self layout];
}

// 仅更新高度值可以调该接口，可以减少计算
- (void) updateHeight: (CGRect) frame view: (UIView *) view
{
    view.frame = frame;
    [self reCountHeight];
}

- (void) layout
{
    [self refreshSize];
    if ( _display == ALDisplayBlock ) {
        [self reflowWhenBlock];
    } else {
        [self reflowWhenInline];
    }
    [self reflowTop];
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

- (void) reCountHeight
{
    if ( [self.viewArr count] > 0 ) {
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

- (void) reCountWidth
{
    if ( [self.viewArr count] > 0 ) {
        _width = 0;
        
        NSUInteger i = 0;
        NSUInteger len = [self.viewArr count];
        
        for (; i < len; i++) {
            UIView * view = [self.viewArr objectAtIndex:i];
            CGFloat w = view.marginLeft +
                        view.marginRight +
                        view.frame.size.width;
            
            _width += w;
        }
    }
}

- (void) refreshSize
{
    [self reCountWidth];
    [self reCountHeight];
}
// 仅刷新top排版
- (void) reflowTop
{
    NSInteger i = 0;
    NSInteger len = [self.viewArr count];
    
    for ( ; i < len; i++ ) {
        UIView * view = [self.viewArr objectAtIndex: i];
        CGFloat top = _top + view.marginTop;
        view.frame = CGRectMake(view.frame.size.width, top, view.frame.size.width, view.frame.size.height);
    }
    // recurive reflow origin or next row
//    if ( _nextRow ) {
//        [_nextRow reflowTop];
//    } else {
//        [_parentView.superview rowReflowWithView:_parentView];
//    }
}

- (void) reflowWhenBlock
{
    UIView * view = [self.viewArr objectAtIndex: 0];
    CGFloat top = _top + view.marginTop;
    CGFloat left = 0;
    
    if ( _contentAlign == ALContentAlignCenter ) {
        left = (_maxWidth - _width)/2 + view.marginLeft;
    } else if ( _contentAlign == ALContentAlignRight ) {
        left = _maxWidth - _width + view.marginLeft;
    } else {
        left = 0;
    }
    
    view.frame = CGRectMake(left, top, view.frame.size.width, view.frame.size.height);
    // recurive reflow origin or next row
//    if ( _nextRow ) {
//        [_nextRow layoutTop];
//    } else {
////        _parentView
//    }
}
// 触发row内部的view进行layout，仅重排left值
- (void) reflowWhenInline
{
    NSInteger i = 0;
    NSInteger len = [self.viewArr count];
    
    for ( ; i < len; i++ ) {
        UIView * view = [self.viewArr objectAtIndex: i];
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
    // recurive reflow origin or next row
//    if ( _nextRow ) {
//        [_nextRow layoutTop];
//    }
}

@end
