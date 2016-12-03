//
//  ALRowManager.m
//  ALView
//
//  Created by jdochen on 2016/12/3.
//  Copyright © 2016年 jdochen. All rights reserved.
//
#import "UIView+ALEngine.h"
#import "ALRowManager.h"
#import "ALRow.h"

@interface ALRowManager()
{
    NSMutableArray<ALRow *> * _rows;
}

@end

@implementation ALRowManager

- (instancetype)initWithView: (UIView *) view
{
    self = [super init];
    if (self) {
        self.ownerView = view;
        _rows = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 * 在最后的Row插入新的view
 * 1、如果当前管理器还没有row，那新建一个Row，top=0；
 * 2、如果最后的Row为block类型的，那新建一个Row，top=previousRow.top+previousRow.height
 * 3、如果最后的Row为inline类型的，调用canAddView检查是否能插入：
 *   - 如果能插入，那在尾部插入
 *   - 如果不能插入，那新建一个Row，top=previousRow.top+previousRow.height
 * 4、在尾部插入，完！
 */

- (void) appendView: (UIView *) view
{
    // 当前inline view在该容器作为第一行展示
    if ( [_rows count] == 0 ) {
        [self createNewRowWithView: view previousRow:nil];
        // 录入所在的行索引
        view.row = 0;
    } else {
        ALRow * lastRow = _rows.lastObject;
        NSInteger lastRowIndex = [_rows count]-1;
        if ( [lastRow canAddView: view] ) {
            [lastRow pushView: view];
            view.row = lastRowIndex;
        } else {
            [self createNewRowWithView: view previousRow:lastRow];
            view.row = lastRowIndex+1;
        }
    }
}

// 在某一行前面插入一行
- (void) insertRow: (ALRow *) row beforeRow: (ALRow *) beforeRow
{
    
}

// 将一个inline view从指定的一行开始位置插入
// 如果造成指定Row溢出（宽度超过最大宽度），那会将溢出的内容递归的插入下一个Row
- (void) crushView2NextRow: (UIView *) view belongRow: (ALRow *) belongRow
{
    NSInteger nextRowIndex = view.row+1;
    // 存在下一行的情况
    if ( [_rows count] > nextRowIndex ) {
        ALRow * toRow = [_rows objectAtIndex: nextRowIndex];
        // 如果下一行是block类型的Row
        if ( toRow.display == ALDisplayBlock ) {
            // TODO
        } else {
            while ( ![toRow canAddView: view] ) {
                // 移除溢出的view
                UIView * overflow = [toRow popView];
                // 递归咯
                [self crushView2NextRow:overflow belongRow:toRow];
            }
        }
        [toRow addView: view];
        // 更新Row的索引
        view.row = nextRowIndex;
    } else {
        [self createNewRowWithView: view previousRow: belongRow];
    }
}

/*
 * 重排自己
 * 重排自己与兄弟view、父view
 */
- (void) reflowSelfView
{
    if ( self.ownerView.superview ) {
        [self.ownerView.superview.rowManager reflowChildView: self.ownerView];
    } else {
        
    }
    
//    [self reflowInnerView];
}
// 重排
- (void) reflowChildView: (UIView *) view
{
    ALRow * belongRow = [self findTheRowOfView: view];
    
    // recurive here
    while ( [belongRow need2break] ) {
        UIView * overflow = [belongRow popView];
        [self crushView2NextRow: overflow belongRow:belongRow];
    }
    // 重排
//    if ( view.superview ) {
//        [view.superview.rowManager reflowSelfHeight];
//    }
}
// 重排父view的高
//- (void) reflowSelfHeight
//{
//    
//}
//
//// 重排子view高度
//- (void) reflowChildrenTop
//{
//    
//}
//
////
//
//- (void) reflowInnerView
//{
//    
//}

// 新建一个Row，并初始化
- (ALRow *) createNewRowWithView: (UIView *) view previousRow: (ALRow *) previousRow
{
    ALRow * newRow = [[ALRow alloc] init];
    newRow.contentAlign = self.ownerView.contentAlign;
    newRow.display = view.display;
    newRow.maxWidth = [view getParentWidth];
    // link row
    if ( previousRow ) {
        newRow.previousRow = previousRow;
        previousRow.nextRow = newRow;
    }
    [newRow pushView: view];
    [_rows addObject:newRow];
    return newRow;
}

/*
 * 查找该view所属的Row
 * 1、如果view不是isALEngine，返回nil
 * 2、如果superview不存在，返回nil
 * 3、如果superview不是isALEngine，返回nil
 * 4、如果superview.rows数量比view.row+1小，返回nil
 * 5、返回父view的Row管理器中所在的Row
 */
- (ALRow *) findTheRowOfView: (UIView *) view
{
    if ( view.superview && [view.superview.rows count] > (view.row + 1) ) {
        return [view.superview.rows objectAtIndex: view.row];
    }
    return nil;
}


@end
