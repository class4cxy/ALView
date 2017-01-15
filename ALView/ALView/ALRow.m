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
        _viewsArr = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#pragma mark - 行操作方法
/*
 * 在当前行头部插入一个view
 * 会触发当前行重排
 */
- (void) addView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![_viewsArr containsObject: view] ) {
            [_viewsArr insertObject:view atIndex:0];
            view.belongRow = self;
        }
        [self refreshSize];
    }
}

/*
 * 在当前行尾部插入一个view
 * 会触发当前行重排
 */
- (void) pushView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![_viewsArr containsObject: view] ) {
            [_viewsArr addObject: view];
            view.belongRow = self;
        }
        // 更新height值
        [self refreshSize];
    }
}

/*
 * 移除当前行的最后一个view，并返回该view
 * 会触发当前行重排
 */
- (UIView *) popView
{
    if ( [_viewsArr count] > 0 ) {
        UIView * lastView = [_viewsArr lastObject];
        [_viewsArr removeLastObject];
        lastView.belongRow = nil;
        [self refreshSize];
        return lastView;
    }
    return nil;
}

/*
 * 移除当前行的第一个view，并返回该view
 * 会触发当前行重排
 */
- (UIView *) shiftView
{
    if ( [_viewsArr count] > 0 ) {
        UIView * firstView = [_viewsArr objectAtIndex: 0];
        [_viewsArr removeObjectAtIndex: 0];
        [self refreshSize];
        return firstView;
    }
    return nil;
}

/*
 * 移除指定view
 */
- (void) removeView: (UIView *) view
{
    if ( [_viewsArr count] > 0 ) {
        [_viewsArr removeObject: view];
        view.belongRow = nil;
        [self refreshSize];
    }
}

/*
 * 在指定位置插入新的view
 */
- (void) insertView: (UIView *) view beforeView: (UIView *) beforeView
{
    if ( [_viewsArr count] > 0 && view ) {
        NSUInteger beforeIndex = [_viewsArr indexOfObject: beforeView];
        // 存在beforeView才操作
        if ( beforeIndex != NSNotFound ) {
            [_viewsArr insertObject: view atIndex: beforeIndex];
            view.belongRow = self;
            [self refreshSize];
        }
    }
}

// 过滤hidden类型的view
- (NSMutableArray *) filterHiddenView
{
    NSMutableArray * result = [NSMutableArray array];
    NSInteger i = 0;
    NSInteger len = [_viewsArr count];
    
    for (; i < len; i++) {
        UIView * view = [_viewsArr objectAtIndex: i];
        if ( !view.style.hidden ) {
            [result addObject: view];
        }
    }
    
    return  result;
}

- (BOOL) canAddView: (UIView *) view
{
    [self refreshWidth];
    // 特殊逻辑：
    // 1、如果当前行是block行，那直接返回NO
    // 2、如果插入的view是block类型，那直接返回NO
    // 3、如果上一个节点存在且isEndOFLine=YES，那直接返回NO
    // 4、如果当前节点isFirstOFLine=YES，那直接返回NO
    if (
        self.display == ALDisplayBlock ||
        view.style.display == ALDisplayBlock ||
        (view.previousSibling && view.previousSibling.style.isEndOFLine) ||
        view.style.isFirstOFLine
        ) {
        return NO;
    }
    // 1、如果当前行已经没有子view，那直接返回YES
    // 2、view是隐藏的，那直接返回YES
    if ( [_viewsArr count] == 0 || view.style.hidden ) {
        return YES;
    }
    
    return _maxWidth >= _width + view.frame.size.width + view.style.marginLeft + view.style.marginRight;
}

- (BOOL) need2break
{
    [self refreshWidth];
    // 3、如果当前行已经没有子view，那直接返回YES
    if ( [_viewsArr count] == 1 ) {
        return NO;
    }
    return _width > _maxWidth;
}

#pragma mark - reCount and reflow

- (void) refreshSize
{
    [self refreshWidth];
    [self refreshHeight];
    [self getCurrTop];
}

- (void) refreshWidth
{
    if ( [_viewsArr count] > 0 ) {
        _width = 0;
        
        NSUInteger i = 0;
        NSUInteger len = [_viewsArr count];
        
        for (; i < len; i++) {
            UIView * view = [_viewsArr objectAtIndex:i];
            if ( !view.style.hidden ) {
                CGFloat w = view.style.marginLeft +
                        view.style.marginRight +
                        view.frame.size.width;
                
                _width += w;
            }
        }
    }
}

- (void) refreshHeight
{
    if ( [_viewsArr count] > 0 ) {
        _height = 0;
        
        NSUInteger i = 0;
        NSUInteger len = [_viewsArr count];
        
        for (; i < len; i++) {
            UIView * view = [_viewsArr objectAtIndex:i];
            if ( !view.style.hidden ) {
                CGFloat h = view.style.marginTop +
                        view.style.marginBottom +
                        view.frame.size.height;
                
                if ( _height < h ) {
                    _height = h;
                }
            }
        }
    }
}

- (CGFloat) getCurrTop
{
    CGFloat currTop = 0;
    if ( self.previousRow ) {
        currTop = self.previousRow.height + self.previousRow.top;
    }
    _top = currTop;
    return currTop;
}

- (void) layout
{
//    [self refreshSize];
    if ( _display == ALDisplayBlock ) {
        [self reflowWhenBlock];
    } else {
        [self reflowWhenInline];
    }
}

- (void) reflowWhenBlock
{
    UIView * view = [_viewsArr objectAtIndex: 0];
    if ( !view.style.hidden ) {
        CGFloat top = [self getCurrTop] + view.style.marginTop;
        CGFloat left = 0;
        CGFloat parentWidth = _parent.frame.size.width;
        
        if ( _contentAlign == ALContentAlignCenter ) {
            left = (parentWidth - _width)/2 + view.style.marginLeft;
        } else if ( _contentAlign == ALContentAlignRight ) {
            left = parentWidth - _width + view.style.marginLeft;
        } else {
            left = view.style.marginLeft;
        }
        [view layoutWithOrigin:CGPointMake(left, top)];
        NSLog(@"[ALEnging] reflowWhenBlock --- %@", NSStringFromCGRect(view.frame));
    }
}
// 触发row内部的view进行layout，仅重排left值
- (void) reflowWhenInline
{
    NSMutableArray * views = [self filterHiddenView];
    NSInteger i = 0;
    NSInteger len = [views count];
    
    for ( ; i < len; i++ ) {
        UIView * view = [views objectAtIndex: i];
        CGFloat left = 0;
        CGFloat top = [self getCurrTop] + view.style.marginTop;
        CGFloat parentWidth = _parent.frame.size.width;
        
        if ( i == 0 ) {
            if ( _contentAlign == ALContentAlignCenter ) {
                left = (parentWidth - _width)/2 + view.style.marginLeft;
            } else if ( _contentAlign == ALContentAlignRight ) {
                left = parentWidth - _width + view.style.marginLeft;
            } else {
                left = view.style.marginLeft;
            }
        } else {
            UIView * prevView = [views objectAtIndex: i-1];
            left =  view.style.marginLeft +
                    prevView.frame.origin.x +
                    prevView.frame.size.width +
                    prevView.style.marginRight;
        }
        [view layoutWithOrigin:CGPointMake(left, top)];
        NSLog(@"[ALEnging] reflowWhenInline --- %@", NSStringFromCGRect(view.frame));
    }
}

// 重排当前行所有view的top
- (void) reflowTop
{
    NSInteger i = 0;
    NSInteger len = [_viewsArr count];
    
    for ( ; i < len; i++ ) {
        UIView * view = [_viewsArr objectAtIndex: i];
        CGFloat top = [self getCurrTop] + view.style.marginTop;
        [view layoutWithTop: top];
        NSLog(@"[ALEnging] reflowTop --- %@", NSStringFromCGRect(view.frame));
    }
}
// 重排指定view的top
- (void) reflowTopWithView: (UIView *) view
{
    if ( [_viewsArr count] > 0 && view ) {
        NSUInteger beforeIndex = [_viewsArr indexOfObject: view];
        // 存在beforeView才操作
        if ( beforeIndex != NSNotFound ) {
            CGFloat top = [self getCurrTop] + view.style.marginTop;
            [view layoutWithTop: top];
            NSLog(@"[ALEnging] reflowTop --- %@", NSStringFromCGRect(view.frame));
        }
    }
}

// 重写更新maxWidth逻辑，如果view存在行管理器（存在子view），需要更新行管理器的maxWidth
- (void) setMaxWidth:(CGFloat)maxWidth
{
    for (UIView * view in _viewsArr) {
        if ( view.rowManager && view.style.isAutoWidth ) {
            view.rowManager.maxWidth = maxWidth - view.style.marginLeft - view.style.marginRight;
        }
    }
    _maxWidth = maxWidth;
}

@end
