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

@implementation ALRowManager

#pragma mark - 初始化
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

#pragma mark - 行排版逻辑


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
- (void) reflowRow: (UIView *) subView reflowInnerView: (BOOL) isReflow
{
    // 找到该view所属的行，由行去决定如何reflow该view
    ALRow * belongRow = subView.belongRow;
    
    BOOL need2reflowNextViewTop = NO;
    // 当前在行管理器中
    // hidden=YES
    if ( belongRow != nil ) { //当前view如果是absolute布局，那就不存在belongRow
        // 如果是block行可以简单点处理
        if ( belongRow.display == ALDisplayBlock ) {
            // 如果subView已经隐藏，需要从管理器中移除该view
            if ( subView.style.hidden ) {
                [belongRow popView];
                [self removeRow:belongRow];
            } else {
                [belongRow refreshSize];
                [belongRow layout];
            }
            // 需要更新下行top值
            need2reflowNextViewTop = YES;
        } else {
            // 移除view
            if ( subView.style.hidden ) {
                [belongRow removeView: subView];
            }
            // 如果该行为空，则移除
            if ( [belongRow count] == 0 ) {
                [self removeRow:belongRow];
                // 需要更新下行top值
                need2reflowNextViewTop = YES;
            } else {
                if ( [belongRow need2break] ) {
                    [self crush2NextRow: belongRow];
                } else {
                    ALRow * startRow = nil;
                    if ( subView == belongRow.firstView && belongRow.previousRow ) {
                        startRow = belongRow.previousRow;
                    } else {
                        startRow = belongRow;
                    }
                    
                    [self crush2PreviousRow: startRow];
                }
            }
        }
    // 不在行管理器中：
    // 1、hidden=YES
    } else {
        if ( !subView.style.hidden ) {
            // 如果是block行可以简单点处理
            if ( subView.style.display == ALDisplayBlock ) {
                // 存在下一行的情况
                if ( subView.nextSibling && subView.nextSibling.belongRow ) {
                    belongRow = [self insertNewRowWithView:subView beforeRow:subView.nextSibling.belongRow];
                    // 需要更新下行top值
                    need2reflowNextViewTop = YES;
                } else {
                    belongRow = [self appendNewRowWithView: subView previousRow:subView.previousSibling.belongRow];
                }
            } else {
                UIView * nextView = subView.nextSibling;
                if ( nextView && nextView.belongRow ) {
                    belongRow = nextView.belongRow;
                    // 插入到nextSibling之前
                    [belongRow insertView: subView beforeView: nextView];
                    // 更新当前行
                    if ( [belongRow need2break] ) {
                        [self crush2NextRow: belongRow];
                    } else {
                        ALRow * startRow = nil;
                        if ( subView == belongRow.firstView && belongRow.previousRow ) {
                            startRow = belongRow.previousRow;
                        } else {
                            startRow = belongRow;
                        }
                        
                        [self crush2PreviousRow: startRow];
                    }
                } else {
                    belongRow = [self appendNewRowWithView: subView previousRow:subView.previousSibling.belongRow];
                }
            }
        }
    }
    // 重排nextSibline top
    if ( need2reflowNextViewTop ) {
        while ( belongRow.nextRow ) {
            [belongRow.nextRow reflowTop];
            belongRow = belongRow.nextRow;
        }
    }
    
    // 递归重排父view的size
    if ( subView.superview && subView.superview.rowManager ) {
        [subView.superview.rowManager reflowOwnerViewSizeWithReflowInner: NO];
    }
    // 重排自己内部子view
    if ( isReflow && subView.rowManager ) {
        [subView.rowManager reflowSubView];
        [subView.rowManager reflowOwnerViewHeight];
    }
}

/*
 * 检查[指定行]是否需要断行，如果需要就把多余的view往下一行挤
 */
- (void) crush2NextRow: (ALRow *) row
{
    if ( row && row.display == ALDisplayInline ) {
        if ( [row need2break] ) {
            do
            {
                UIView * lastView = [row popView];
                // 如果不存在下一行，那新建并append到行管理器尾部
                if ( !row.nextRow ) {
                    [self appendNewRowWithView:lastView previousRow: row];
                // 如果下一行是block类型，那新建并插入到当前行之前
                } else if ( row.nextRow.display == ALDisplayBlock ) {
                    [self insertNewRowWithView:lastView beforeRow:row.nextRow];
                } else {
                    [row.nextRow addView: lastView];
                }
            }
            while ([row need2break]);
        }
        // 触发行重排
        [row layout];
        // 递归下一行
        if ( row.nextRow ) {
            // 如果下一行是inline类型，递归执行该函数
            if ( row.nextRow.display == ALDisplayInline ) {
                [self crush2NextRow: row.nextRow];
            // 如果下一行是block类型，那就停止递归，并触发下面所有兄弟行reflowTop
            } else {
                do
                {
                    [row.nextRow reflowTop];
                    row = row.nextRow;
                } while (row);
            }
        }
    } else {
        // 排版当前行
        [row layout];
    }
}
/*
 * 检查[指定行]是否允许下一行的view往上挤
 * 执行条件： 如果[指定行]存在下一行
 *   1 如果下一行为空，移除下一行，并递归执行该检查
 *   2 去除下一行的第一个view(firstView)，检查是否能往[指定行]后面挤：
 *   3 如果能：
 *     (1) 移除下一行的第一个view(firstView)，在[指定行]最后插入；
 *     (2) 移除之后检查下一行是否为空：
 *       [1] 如果下一行为空，那移除下一行并检查下下一行是否符合条件，如果符合：重新指定firstView，递归2逻辑；如果不符合：跳出2逻辑
 *       [2] 如果下一行不空，重新指定firstView，递归2逻辑
 *   4 重排[指定行]
 *   5 如果存在nextRow，检查nextRow是否为ALDisplayInline类型；
 *     (1) 如果是：递归执行本函数，指定行为nextRow
 *     (2) 如果不是：递归重排下一行的高度(reflowTop)
 */
- (void) crush2PreviousRow: (ALRow *) row
{
    if ( row.nextRow ) {
        // 特殊逻辑：对下一行为空时的处理
        if ([row.nextRow count] == 0) {
            [self removeRow: row.nextRow];
            return [self crush2PreviousRow: row];
        }
        
        UIView * firstView = [row.nextRow firstView];
        while ( [row canAddView: firstView] ) {
            // 移除当前行的第一个view，插入到上一行尾部
            [row pushView: [row.nextRow shiftView]];
            
            // 如果当前行已经移除空
            if ( [row.nextRow count] == 0 ) {
                [self removeRow: row.nextRow];
                if ( row.nextRow && row.nextRow.display == ALDisplayInline ) {
                    firstView = [row.nextRow firstView];
                } else {
                    break;
                }
            } else {
                firstView = [row.nextRow firstView];
            }
        }
        // 排版当前行
        [row layout];
        // 检查下一行是否需要执行
        if ( row.nextRow ) {
            // 递归下一行
            if ( row.nextRow.display == ALDisplayInline ) {
                [self crush2PreviousRow: row.nextRow];
            } else {
                // 重排后面的top
                do
                {
                    [row.nextRow reflowTop];
                    row = row.nextRow;
                } while ( row );
            }
        }
    } else {
        // 排版当前行
        [row layout];
    }
}

/*
 * 操作（修改、插入、删除）子view而触发的重排父view，也就是行管理器的ownerView
 * 1、如果ownerView.isALEngine=NO，不需操作，因为原生view都有给固定的height与width
 * 2、如果ownerView.isALEngine=YES：
 *    - 重排ownerView的size(调用reflowSelfSizeWhenAutoSize)
 *    - 如果ownerView.style.isAutoWidth=YES，触发重排ownerView所在的当前行（调用reflowRow:stopRecur）
 */
- (BOOL) reflowOwnerViewSizeWithReflowInner: (BOOL) need2ReflowInnerView
{
    BOOL hasUpdateWidth = NO;
    if ( self.ownerView.isALEngine ) {
        // 更新ownerView的size
        hasUpdateWidth = [self.ownerView reflowSizeWhenAutoSizeWithSize: (CGSize){[self getOnwerViewInnerWidth], [self getOnwerViewInnerHeight]}];
        
        if ( self.ownerView.style.position == ALPositionRelative ) {
            if ( self.ownerView.style.isAutoWidth && hasUpdateWidth ) {
                // 存在所属行，重排所属行
                if ( self.ownerView.belongRow ) {
                    [self.ownerView.superview.rowManager reflowRow: self.ownerView reflowInnerView:need2ReflowInnerView];
                }
            // 单独更新top值即可
            } else if ( self.ownerView.style.isAutoHeight ) {
                [self recurReflowParentHeight: self.ownerView];
            }
        // ownerView是absolute方式布局，而且isAutoHeight=YES，那也需要更新ownerView的origin
        } else {
            if ( self.ownerView.style.isAutoHeight || self.ownerView.style.isAutoWidth ) {
                [self.ownerView reflowOriginWhenAbsolute];
            }
        }
        
        // 如果ownerView不是左对齐，那还是需要重刷一遍所有行
        if ( self.ownerView.style.contentAlign != ALContentAlignLeft && self.ownerView.style.isAutoWidth && hasUpdateWidth ) {
            [self reflowAllRow];
        }
        
        // 重排子view中使用absolute排版的
        [self.ownerView reflowSubviewWhichISAbsolute];
    }
    return hasUpdateWidth;
}

/*
 * 重排ownerview的subview
 * 遍历rowManager中的rowArr；
 * 1、如果当前行是block行：
 *    - 重排当前block view的size，因为有可能block view使用了isAutoWidth或者isAutoHeight
 *    - 触发当前行位置重排
 *    - 检查是否有子view，如果有则递归执行该方法
 * 2、如果当前行是inline行：
 *    - 重当前行的第一个view开始重排后面的view（调用reflowRow即可），直到遇到下一个block行为止，不在执行该行为
 */
- (void) reflowOwnerViewInnerView
{
    ALRow * row = [self firstRow];
    
    // TODO这里重排inline类型的子view有待优化：递归重排逐个子view
    BOOL isBlockRow = YES;
    while ( row ) {
        if ( [row count] > 0 ) {
            if ( row.display == ALDisplayBlock ) {
                UIView * view = [row firstView];
                // 重排当前block的size，因为父view有可能改变了宽度
                [view reflowSize];
                // 重排行
                [row layout];
                // 递归触发subview重排
                if ( view.rowManager ) {
                    [view.rowManager reflowOwnerViewInnerView];
                }
                isBlockRow = YES;
            } else if ( row.display == ALDisplayInline && isBlockRow ) {
                UIView * view = [row firstView];
                [self reflowRow: view reflowInnerView: NO];
                isBlockRow = NO;
            }
        }
        row = row.nextRow;
    }
    
}
/*
 * 重排当前行管理器中所有view
 * 1 取出第一行；
 * 2 检查当前行中有没有使用autoWidth布局的view
 */
- (void) reflowSubView
{
    ALRow * row = [self firstRow];
    BOOL isBlockRow = YES;
    
    while (row) {
        if ( row.display == ALDisplayBlock ) {
            UIView * view = [row firstView];
            // 重排当前block的size，因为父view有可能改变了宽度
            [view reflowSize];
            [row refreshSize];
            // 重排行
            [row layout];
            // 递归触发subview重排
            if ( view.rowManager && view.style.isAutoWidth ) {
                [view.rowManager reflowSubView];
                [view.rowManager reflowOwnerViewSizeWithReflowInner: NO];
            }
            isBlockRow = YES;
        } else if ( row.display == ALDisplayInline && isBlockRow ) {
            for (UIView * view in row.viewsArr) {
                // 如果有需要重排子view，先重排
                if ( [self checkNeed2ReflowInnerView: view] ) {
                    [view.rowManager reflowSubView];
                }
            }
            if ( [row need2break] ) {
                [self crush2NextRow: row];
            } else {
                [self crush2PreviousRow: row];
            }
            isBlockRow = YES;
        }
        // 递归
        row = row.nextRow;
    }
}
/*
 * 重排当前行管理器中所有行，只是重排，并不会检查断行逻辑
 */
- (void) reflowAllRow
{
    ALRow * row = [self firstRow];
    while (row) {
        // 更新block行
        if ( row.display == ALDisplayBlock && row.firstView && row.firstView.style.isAutoWidth ) {
            [row.firstView reflowSize];
            [row refreshSize];
            // 递归触发subview重排
            if ( row.firstView.rowManager ) {
                [row.firstView.rowManager reflowSubView];
//                [row.firstView.rowManager reflowOwnerViewSizeWithReflowInner: NO];
            }
        }
        
        [row layout];
        // 递归
        row = row.nextRow;
    }
}

// 重排ownerView的height，并重排兄弟view的top，以及递归父view的height
- (void) reflowOwnerViewHeight
{
    if ( self.ownerView.isALEngine ) {
        // 重排ownerView的高度
        [self.ownerView reflowHeightWhenAutoHeightWithHeight: [self getOnwerViewInnerHeight]];
        // 递归兄弟view以及superView
        if ( self.ownerView.style.isAutoHeight ) {
            [self recurReflowParentHeight: self.ownerView];
            // 如果是absolute类型，还需要触发重排高度
            if ( self.ownerView.style.position == ALPositionAbsolute ) {
                [self.ownerView reflowOriginWhenAbsolute];
            }
        }
    }
}

- (void) recurReflowParentHeight: (UIView *) parent
{
    ALRow * belongRow = parent.belongRow;
    
    [belongRow refreshSize];
    // 重排同级view
    while (belongRow.nextRow) {
        [belongRow.nextRow reflowTop];
        belongRow = belongRow.nextRow;
    }
    if ( parent.superview ) {
        [parent.superview.rowManager reflowOwnerViewHeight];
    }
}

#pragma mark - 行操作逻辑
/*
 * 在行管理器最后一行尾部插入指定view
 * 1 如果当前view存在rowManager(子view)，检查是否需要重排子view（主要的场景是：父view只被初始化，但没add到任何view中）
 * 2 如果当前管理器还没有row，那新建一个Row，top=0；
 * 3 如果最后的Row为block类型的，那新建一个Row，top=previousRow.top+previousRow.height
 * 4 如果最后的Row为inline类型的，调用canAddView检查是否能插入：
 *   - 如果能插入，那在尾部插入
 *   - 如果不能插入，那新建一个Row，top=previousRow.top+previousRow.height
 * 5 触发父view重排
 * 6 触发当前行重排
 */

- (void) appendView: (UIView *) view
{
    // 如果存在子view，检查是否需要重排子view
    if ( [self checkNeed2ReflowInnerView: view] ) {
        [view.rowManager reflowSubView];
    }
    // 当前inline view在该容器作为第一行展示
    ALRow * row = nil;
    if ( [_rowsArr count] == 0 ) {
        row = [self appendNewRowWithView: view previousRow:nil];
    } else {
        row = _rowsArr.lastObject;
        if ( [row canAddView: view] ) {
            [row pushView: view];
        } else {
            row = [self appendNewRowWithView: view previousRow:row];
        }
    }
    // 触发ownerView reflow
    BOOL hasUpdateWidth = [self reflowOwnerViewSizeWithReflowInner: NO];
    // 如果ownerView左对齐或者isAutoWidth=NO，才需要重刷当前行，否则reflowOwnerViewSizeWithReflowInner会执行了重排
    if ( self.ownerView.style.contentAlign == ALContentAlignLeft || !self.ownerView.style.isAutoWidth || !hasUpdateWidth ) {
        [row layout];
    }
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
        // TODO
        // Notification row to destory
        // 移除
        [_rowsArr removeObject: row];
    }
}

- (ALRow *) firstRow
{
    if ( [_rowsArr count] > 0 ) {
        return [_rowsArr objectAtIndex: 0];
    }
    return nil;
}

- (ALRow *) lastRow
{
    return [_rowsArr lastObject];
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
    newRow.maxWidth = self.maxWidth;
    newRow.parent = self.ownerView;
    return newRow;
}

#pragma mark - 行管理器相关信息

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

// 重载setMaxWidth
- (void) setMaxWidth: (CGFloat) maxWidth
{
    // 更新行管理器的maxWidth时，要同步更新当前所有行的maxWidth值
    for (ALRow * row in _rowsArr) {
        row.maxWidth = maxWidth;
    }
    _maxWidth = maxWidth;
}

/*
 * 检查是否需要重排[指定view]的内部子view
 * 1 isAutoWidth=YES
 * 2 display == ALDisplayInline 或 position == ALPositionAbsolute
 */
- (BOOL) checkNeed2ReflowInnerView: (UIView *) view
{
    return view.rowManager && view.style.isAutoWidth && (view.style.display == ALDisplayInline || view.style.position == ALPositionAbsolute);
}

@end
