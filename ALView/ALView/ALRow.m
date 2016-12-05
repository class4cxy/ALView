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

#pragma mark - 行操作方法
/*
 * 在当前行头部插入一个view
 * 会触发当前行重排
 */
- (void) addView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr insertObject:view atIndex:0];
            view.belongRow = self;
        }
        [self layout];
    }
}

/*
 * 在当前行尾部插入一个view
 * 会触发当前行重排
 */
- (void) pushView:(UIView *)view
{
    if ( view != nil ) {
        if ( ![self.viewArr containsObject: view] ) {
            [self.viewArr addObject: view];
            view.belongRow = self;
        }
        // 更新height值
        [self layout];
    }
}

/*
 * 移除当前行的最后一个view，并返回该view
 * 会触发当前行重排
 */
- (UIView *) popView
{
    if ( [self.viewArr count] > 0 ) {
        UIView * lastView = [self.viewArr lastObject];
        [self.viewArr removeLastObject];
        [self layout];
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
    if ( [self.viewArr count] > 0 ) {
        UIView * firstView = [self.viewArr objectAtIndex: 0];
        [self.viewArr removeObjectAtIndex: 0];
        [self layout];
        return firstView;
    }
    return nil;
}

- (UIView *) firstView
{
    if ( [self.viewArr count] > 0 ) {
        return [self.viewArr objectAtIndex:0];
    }
    return nil;
}

- (UIView *) lastView
{
    return self.viewArr.lastObject;
}

- (NSUInteger) count
{
    return [self.viewArr count];
}

#pragma mark - Util method

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
    return _maxWidth >= _width + view.frame.size.width + view.marginLeft + view.marginRight;
}

- (BOOL) need2break
{
    [self reCountWidth];
    // 3、如果当前行已经没有子view，那直接返回YES
    if ( [self.viewArr count] == 1 ) {
        return NO;
    }
    return _width > _maxWidth;
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

#pragma mark - reCount and reflow

- (void) refreshSize
{
    [self reCountWidth];
    [self reCountHeight];
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

- (void) layout
{
    [self refreshSize];
    if ( _display == ALDisplayBlock ) {
        [self reflowWhenBlock];
    } else {
        [self reflowWhenInline];
    }
}

- (void) reflowWhenBlock
{
    UIView * view = [self.viewArr objectAtIndex: 0];
    CGFloat top = [self getCurrTop] + view.marginTop;
    CGFloat left = 0;
    
    if ( _contentAlign == ALContentAlignCenter ) {
        left = (_maxWidth - _width)/2 + view.marginLeft;
    } else if ( _contentAlign == ALContentAlignRight ) {
        left = _maxWidth - _width + view.marginLeft;
    } else {
        left = view.marginLeft;
    }
    
    view.frame = CGRectMake(left, top, view.frame.size.width, view.frame.size.height);
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
        CGFloat top = [self getCurrTop] + view.marginTop;
        
        if ( i == 0 ) {
            if ( _contentAlign == ALContentAlignCenter ) {
                left = (_maxWidth - _width)/2 + view.marginLeft;
            } else if ( _contentAlign == ALContentAlignRight ) {
                left = _maxWidth - _width + view.marginLeft;
            } else {
                left = view.marginLeft;
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

// 仅刷新top排版
- (void) reflowTop
{
    NSInteger i = 0;
    NSInteger len = [self.viewArr count];
    
    for ( ; i < len; i++ ) {
        UIView * view = [self.viewArr objectAtIndex: i];
        CGFloat top = [self getCurrTop] + view.marginTop;
        view.frame = CGRectMake(view.frame.origin.x, top, view.frame.size.width, view.frame.size.height);
    }
}

@end
