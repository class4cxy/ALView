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
 * 指定view在Y轴方向的属性（marginTop/marginBottom/height都属于Y轴方向的属性）发生变更时需触发重排
 * 涉及到的重排：
 * 1、重排当前view的top(只有marginTop变更是需要重排当前行的，因为会影响当前view的排版)
 * 2、递归重排下一行的top
 * 3、递归重排父view的height
 */
- (void) reflowWhenYChange: (UIView *) subView need2reflowSelfTop: (BOOL) need2reflowSelfTop
{
    // 找到该view所属的行，由行去决定如何reflow该view
    ALRow * belongRow = subView.belongRow;
    
    if ( belongRow != nil ) {
        // 更新行数据
        [belongRow refreshSize];
        
        if ( need2reflowSelfTop ) {
            [belongRow reflowTopWithView: subView];
        }
        ALRow * nextRow = belongRow.nextRow;
        // 重排下一行top值
        while ( nextRow ) {
            [nextRow reflowTop];
            nextRow = nextRow.nextRow;
        }
        
        // 递归重排父view的height
        if ( subView.superview && subView.superview.rowManager ) {
            [subView.superview.rowManager reflowOwnerViewHeight];
        }
    }
}

/*
 * 指定view在X轴方向的属性（marginLeft/marginRight/width都属于X轴方向的属性）发生变更时需触发重排
 * 涉及到的重排：
 * 1、如果是block类型
 *    (1) 更新行数据
 *    (2) 重排所属行
 * 2、如果是inline类型
 *    (1) 检查是否需要断行，如果需要，执行crush2NextRow
 *    (2) 如果不需要，执行crush2PreviousRow
 * 3、重排父view的size(执行reflowOwnerViewSizeWithReflowInner)
 * 4、如果need2ReflowSubView=YES（只有width变更时），重排自己内部子view
 */
- (void) reflowWhenXChange:(UIView *)subView need2ReflowSubView:(BOOL)need2ReflowSubView
{
    // 找到该view所属的行，由行去决定如何reflow该view
    ALRow * belongRow = subView.belongRow;
    
    if ( belongRow != nil ) {
        if ( belongRow.display == ALDisplayBlock ) { // block
            [belongRow refreshSize];
            [belongRow layout];
        } else { // inline
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
        // 递归重排父view的size
        // 注：因为重排宽度有可能导致断行，会改变父view的高度
        // 注：如果是block类型的view，而且父view是autowidth，那也需要触发父view reflow
        if ( subView.superview && subView.superview.rowManager ) {
            if ( subView.superview.style.isAutoWidth || subView.superview.style.isAutoHeight ) {
                [subView.superview.rowManager reflowOwnerViewSizeWithReflowInner: NO];
            }
        }
        
        // 重排自己内部子view
        if ( need2ReflowSubView && subView.rowManager ) {
            [subView.rowManager reflowSubView];
            [subView.rowManager reflowOwnerViewHeight];
        }
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
 * 操作（修改、插入、删除）行管理器中的子view而有可能导致了父view的size发生变化，从而触发重排父view
 * 1、如果ownerView.isALEngine=NO，不需操作，因为原生view都有给固定的height与width
 * 2、如果ownerView.isALEngine=YES：
 *    (1) 重排ownerView的size(调用reflowSizeWhenAutoSizeWithSize)
 *    (2) 如果是relative布局
 *        - 如果hasChange.width=YES，重排X轴（执行reflowWhenXChange）
 *          - 如果contentAlign != ALContentAlignLeft，重排所有行
 *        - 如果hasChange.height=YES，排版父view的高度（执行recurReflowParentHeight）
 *    (3) 如果是absolute布局
 *        - 如果hasChange.width=YES或者hasChange.height=YES，重排origin（执行reflowOriginWhenAbsolute）
 *    (4) 重排子view中使用absolute排版的
 */
- (ALSizeIsChange) reflowOwnerViewSizeWithReflowInner: (BOOL) need2ReflowInnerView
{
    ALSizeIsChange hasChange;
    if ( self.ownerView.isALEngine ) {
        // 更新ownerView的size
        hasChange = [self.ownerView reflowSizeWhenAutoSizeWithSize: (CGSize){[self getOnwerViewInnerWidth], [self getOnwerViewInnerHeight]}];
        
        if ( self.ownerView.style.position == ALPositionRelative ) {
            if ( hasChange.width ) {
                // 存在所属行，重排所属行
                if ( self.ownerView.belongRow ) {
                    [self.ownerView.superview.rowManager reflowWhenXChange: self.ownerView need2ReflowSubView: NO];
                }
            }
            // 更新top值即可
            if ( hasChange.height ) {
                [self recurReflowNextSiblingTopAndParentHeight: self.ownerView];
            }
        // ownerView是absolute方式布局，而且isAutoHeight=YES，那也需要更新ownerView的origin
        } else {
            if ( hasChange.height || hasChange.width ) {
                [self.ownerView reflowOriginWhenAbsolute];
            }
        }
        
        // 如果ownerView不是左对齐，那还是需要重刷一遍所有行
        if ( self.ownerView.style.contentAlign != ALContentAlignLeft && hasChange.width ) {
            [self reflowAllRow];
        }
        
        // 重排子view中使用absolute排版的
        if ( hasChange.height || hasChange.width ) {
            [self.ownerView reflowSubviewWhichISAbsolute];
        }
    }
    return hasChange;
}

/*
 * 重排当前行管理器中所有子view
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

/*
 * 重排行管理器ownerView的height
 * 场景：由子view发生变更而触发autoHeight的父view高度发生变化，从而触发相关联的重排
 * 1、通过getOnwerViewInnerHeight获取子view最新高度，并交给reflowHeightWhenAutoHeightWithHeight决定是否要重排height
 *    (1) 如果更新了height且ownerView的排版类型是absolute，重排ownerView的origin（执行reflowOriginWhenAbsolute）
 *    (2) 如果更新了height且ownerView的排版类型是relative，递归触发重排高度（执行recurReflowParentHeight）
 */
- (void) reflowOwnerViewHeight
{
    if ( self.ownerView.isALEngine ) {
        // 重排ownerView的高度
        BOOL hasChange = [self.ownerView reflowHeightWhenAutoHeightWithHeight: [self getOnwerViewInnerHeight]];
        // 递归兄弟view以及superView
        if ( hasChange ) {
            // 如果是absolute类型，需要重排origin
            if ( self.ownerView.style.position == ALPositionAbsolute ) {
                [self.ownerView reflowOriginWhenAbsolute];
            // 如果是relative类型，需要递归触发重排高度
            } else {
                [self recurReflowNextSiblingTopAndParentHeight: self.ownerView];
            }
        }
    }
}

/*
 * 递归重排下一兄弟view的top直到最后一个兄弟节点，然后重排父view的高度
 */
- (void) recurReflowNextSiblingTopAndParentHeight: (UIView *) view
{
    ALRow * belongRow = view.belongRow;

    // 重排同级view
    while (belongRow.nextRow) {
        [belongRow.nextRow reflowTop];
        belongRow = belongRow.nextRow;
    }
    if ( view.superview ) {
        [view.superview.rowManager reflowOwnerViewHeight];
    }
}

#pragma mark - 行操作逻辑
/*
 * 在行管理器最后一行尾部插入指定view
 * 1 如果当前view存在rowManager(子view)，检查是否需要重排子view而且contentAlign != ALContentAlignLeft（主要的场景是：父view只被初始化，但没add到任何view中）
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
//    if ( !view.style.hidden && [self checkNeed2ReflowInnerView: view] && view.style.contentAlign != ALContentAlignLeft ) {
    if ( !view.style.hidden && view.style.display == ALDisplayBlock && view.style.contentAlign != ALContentAlignLeft ) {
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
    if ( !view.style.hidden ) {
        // 触发ownerView reflow
        ALSizeIsChange hasChange = [self reflowOwnerViewSizeWithReflowInner: NO];
        // 如果ownerView左对齐或者isAutoWidth=NO，才需要重刷当前行，否则reflowOwnerViewSizeWithReflowInner会执行了重排
        if ( self.ownerView.style.contentAlign == ALContentAlignLeft || !hasChange.width ) {
            [row layout];
        }
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
    CGFloat maxWidth = self.ownerView.style.maxWidth;
    if ( maxWidth && width > maxWidth ) {
        width = maxWidth;
    }
    return width;
}

- (CGFloat) getOnwerViewInnerHeight
{
    CGFloat height = _rowsArr.lastObject.height + _rowsArr.lastObject.top;
    CGFloat maxHeight = self.ownerView.style.maxHeight;
    if ( maxHeight && height > maxHeight ) {
        height = maxHeight;
    }
    return height;
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
