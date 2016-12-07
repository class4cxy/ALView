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
    NSMutableArray<ALRow *> * _rowsArr;
}

@end

@implementation ALRowManager

/*
 * 初始化
 */
- (instancetype)initWithView: (UIView *) view
{
    self = [super init];
    if (self) {
        self.ownerView = view;
        _rowsArr = [[NSMutableArray alloc] init];
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
    if ( [_rowsArr count] == 0 ) {
        [self appendNewRowWithView: view previousRow:nil];
    } else {
        ALRow * lastRow = _rowsArr.lastObject;
        if ( [lastRow canAddView: view] ) {
            [lastRow pushView: view];
        } else {
            [self appendNewRowWithView: view previousRow:lastRow];
        }
    }
    // 触发父view reflow
    [self reflowSelfHeight];
}

- (void) hide: (UIView *) view
{
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 0, 0);
    [self reflowChildView: view];
}

- (void) show: (UIView *) view
{
    
}

// 将一个inline view从指定的一行开始位置插入
// 如果造成指定Row溢出（宽度超过最大宽度），那会将溢出的内容递归的插入下一个Row
- (void) crushView2NextRow: (UIView *) view
{
    ALRow * belongRow = view.alBelongRow;
    // 存在下一行的情况
    if ( belongRow.nextRow ) {
        ALRow * toRow = belongRow.nextRow;
        // 如果下一行是block类型，新建一行并在block行之前插入
        if ( toRow.display == ALDisplayBlock ) {
            ALRow * newRow = [self insertNewRowWithView:view beforeRow:toRow];
            while (newRow.nextRow) {
                [newRow.nextRow reflowTop];
                newRow = newRow.nextRow;
            }
        } else {
            while ( ![toRow canAddView: view] ) {
                // 移除溢出的view
                UIView * overflow = [toRow popView];
                // 递归咯
                [self crushView2NextRow:overflow];
            }
            [toRow addView: view];
        }
    } else {
        [self appendNewRowWithView: view previousRow:view.alBelongRow];
    }
}
/*
 * 将inline行的view往上一行迁移
 * [检查previous行是否存在]：
 * 1、如果存在，检查当前行的头一个view是否能插入到previous行：
 *    + 如果能插入到上一行：
 *      - 移除当前行的头一个view，插入到previous行的最后面，如果当前行([row count]=0)：
 *        - 检查next行是否存在，且display=ALDisplayInline
 *          - 如果符合，递归next行执行迁移
 *          - 如果不符合，移除当前行，完成！
 *      - 如果当前行([row count] > 0)，递归检查当前行的头一个view是否能插入到previous行
 *    + 如果不能插入：
 *      - 检查next行是否存在，且display=ALDisplayInline ？如果符合，递归next行执行迁移。
 */
- (BOOL) crushView2PreviousRow: (ALRow *) row
{
    // 存在上一行的情况
    if ( row.previousRow ) {
        // 如果当前行已经移除完
        UIView * firstView = [row firstView];
        
        if ( [row.previousRow canAddView: firstView] ) {
            // 移除当前行的第一个view，插入到上一行尾部
            [row.previousRow pushView: [row shiftView]];
            
            if ( [row count] == 0 ) {
                if ( row.nextRow && row.nextRow.display == ALDisplayInline ) {
                    [self crushView2PreviousRow: row.nextRow];
                } else {
                    [self removeRow: row];
                    // 重排下一行的top
                    while (row.nextRow) {
                        [row.nextRow reflowTop];
                        row = row.nextRow;
                    }
                }
            } else {
                // 递归
                [self crushView2PreviousRow: row];
            }
            return YES;
        } else if ( row.nextRow && row.nextRow.display == ALDisplayInline ) {
            [self crushView2PreviousRow: row.nextRow];
        }
        return NO;
    }
    return NO;
}

/*
 * 重排当前行管理器中的某一view
 * 注：该方法主要用于刷新自己，并触发兄弟view、父view重排，通常由父view的行管理器调用；
 *    对于父view的行管理器来说，自己就是子view，所以命名为reflowChildView
 * 1、找到该view所属的行
 * 2、检查view重排后会不会导致当前行断行？
 * 3、如果需要断行，那递归移除当前行尾部的view，并插入到下一行，执行crushView2NextRow即可，
 * 4、如果不需要断行，那直接重排当前行，检查修改的view是否当前行中第一个view？
 * 5、如果是：从当前行开始递归检查是否有需要将view往上一行挤，执行crushView2PreviousRow即可
 * 6、如果不是：从下一行开始递归检查是否有需要将view往上一行挤，执行crushView2PreviousRow即可
 * 7、重排自身的高度（self.ownerView）
 */
- (void) reflowChildView: (UIView *) view
{
    // 找到该view所属的行，由行去决定如何reflow该view
    ALRow * belongRow = view.alBelongRow;
    
    // 检查是否需要断行：
    // 1、如果需要断行，那移除尾部的一个view，将它插到下一行的头部，需触发相应重排
    // 2、如果不需要断行，那直接重排当前行，不需要触发ownerView重排
    if ( [belongRow need2break] ) {
        while ( [belongRow need2break] ) {
            UIView * overflow = [belongRow popView];
            [self crushView2NextRow: overflow];
        }
    } else {
        [belongRow layout];
        // 如果下一行存在，那检查下一行view能否往上挤
        if ( view == belongRow.firstView ) {
            [self crushView2PreviousRow: belongRow];
        } else {
            [self crushView2PreviousRow: belongRow.nextRow];
        }
    }
    // TODO 这里有待优化一下
    // 还是要重刷一遍下级兄弟view的top
    while (belongRow.nextRow) {
        [belongRow.nextRow reflowTop];
        belongRow = belongRow.nextRow;
    }
    // 重排自己的高度
    [self reflowSelfHeight];
}
// 重排父view的高
- (void) reflowSelfHeight
{
    // 当ownerView是ALEngine情况才执行
    if ( self.ownerView.isALEngine ) {
        // 如果是relative类型，且isAutoHeight=YES
        if ( self.ownerView.style.position == ALPositionRelative ) {
            
            // 当父view是ALScrollView，需更新scrollView的contentSize
            if ( [self.ownerView isKindOfClass: [ALScrollView class]] ) {
                [((ALScrollView *) self.ownerView) reflowInnerFrame];
            }
            // 如果isAutoHeight=YES，reflow Height
            if ( self.ownerView.style.isAutoHeight ) {
                ALRow * belongRow = self.ownerView.alBelongRow;
                
                self.ownerView.frame = CGRectMake(self.ownerView.frame.origin.x, self.ownerView.frame.origin.y, self.ownerView.frame.size.width, _rowsArr.lastObject.height + _rowsArr.lastObject.top);
                
                [belongRow refreshSize];
                // 重排同级view
                while (belongRow.nextRow) {
                    [belongRow.nextRow reflowTop];
                    belongRow = belongRow.nextRow;
                }
                if ( self.ownerView.superview ) {
                    [self.ownerView.superview.alRowManager reflowSelfHeight];
                }
            }
        // 如果是absolute类型，且isAutoHeight=YES或isAutoWidth=YES
        } else if ( self.ownerView.style.position == ALPositionAbsolute && (self.ownerView.style.isAutoHeight || self.ownerView.style.isAutoWidth) ) {
            // 如果ownerView是absolute类型，那需触发自己size和origin重排
            [self.ownerView.alRowManager reflowSelfSizeOfAbsolute];
            [self.ownerView reflowOriginWhenAbsolute];
        }
    }
}
// 重排自己的Size，主要给absolute方式的view使用
- (void) reflowSelfSizeOfAbsolute
{
    if ( self.ownerView.style.isAutoWidth ) {
        self.ownerView.frame = CGRectMake(self.ownerView.frame.origin.x, self.ownerView.frame.origin.y, [self getOnwerViewInnerWidth], self.ownerView.frame.size.height);
    }
    
    if ( self.ownerView.style.isAutoHeight ) {
        self.ownerView.frame = CGRectMake(self.ownerView.frame.origin.x, self.ownerView.frame.origin.y, self.ownerView.frame.size.width, [self getOnwerViewInnerHeight]);
    }
}

- (CGFloat) getOnwerViewInnerWidth
{
    CGFloat width = 0;
    for (ALRow * row in _rowsArr) {
        if ( width < row.width ) {
            width = row.width;
        }
    }
    return width;
}

- (CGFloat) getOnwerViewInnerHeight
{
    return _rowsArr.lastObject.height + _rowsArr.lastObject.top;
}

// 新建一行，初始化，并在当前管理器尾部插入
- (ALRow *) appendNewRowWithView: (UIView *) view previousRow: (ALRow *) previousRow
{
    ALRow * newRow = [self createRowWithView: view];
    // link row
    if ( previousRow ) {
        newRow.previousRow = previousRow;
        previousRow.nextRow = newRow;
    }
    [newRow pushView: view];
    [_rowsArr addObject:newRow];
    return newRow;
}

// 移除指定的一行
- (void) removeRow: (ALRow *) row
{
    if ( row ) {
        ALRow * previousRow = row.previousRow;
        ALRow * nextRow = row.nextRow;
        // 移除关系：
        // 如果存在上一行
        if ( previousRow ) {
            previousRow.nextRow = nil;
        }
        // 如果存在下一行
        if ( nextRow ) {
            nextRow.previousRow = nil;
        }
        // 如果存在上一行，下一行，那需重新建立它们的联系
        if ( previousRow && nextRow ) {
            previousRow.nextRow = nextRow;
            nextRow.previousRow = previousRow;
        }
        // 移除
        [_rowsArr removeObject: row];
    }
}

// 在指定行之前插入新的一行
- (ALRow *) insertNewRowWithView: (UIView *) view beforeRow: (ALRow *) beforeRow
{
    if ( view && beforeRow ) {
        ALRow * newRow = [self createRowWithView: view];
        
        ALRow * beforeRowPreviousRow = beforeRow.previousRow;
        // 更新指定行与新增行的关系
        beforeRow.previousRow = newRow;
        newRow.nextRow = beforeRow;
        // 如果指定行的previousRow存在，那需指定previousRow与新增行的关系
        if ( beforeRowPreviousRow ) {
            beforeRowPreviousRow.nextRow = newRow;
            newRow.previousRow = beforeRowPreviousRow;
        }
        [newRow pushView: view];
        // 插入
        NSUInteger index = [_rowsArr indexOfObject: beforeRow];
        [_rowsArr insertObject: newRow atIndex: index];
        
        return newRow;
    }
    return nil;
}

// 新建行，但不插入到行管理器
- (ALRow *) createRowWithView: (UIView *) view
{
    ALRow * newRow = [[ALRow alloc] init];
    newRow.contentAlign = self.ownerView.style.contentAlign;
    newRow.display = view.style.display;
    newRow.maxWidth = [view getParentWidth];
    return newRow;
}

@end
