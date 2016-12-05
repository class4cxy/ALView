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

/*
 * 初始化
 */
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
    } else {
        ALRow * lastRow = _rows.lastObject;
        if ( [lastRow canAddView: view] ) {
            [lastRow pushView: view];
        } else {
            [self createNewRowWithView: view previousRow:lastRow];
        }
    }
    // 触发父view reflow
    if ( view.superview ) {
        if ( view.superview.position == ALPositionRelative ) {
            [view.superview.rowManager reflowSelfHeight];
        } else {
            [view.superview.rowManager reflowSelfSizeOfAbsolute];
            [view.superview reflowOriginWhenAbsolute];
        }
    }
}

// 在某一行前面插入一行
- (void) insertRow: (ALRow *) row beforeRow: (ALRow *) beforeRow
{
    
}

// 将一个inline view从指定的一行开始位置插入
// 如果造成指定Row溢出（宽度超过最大宽度），那会将溢出的内容递归的插入下一个Row
- (void) crushView2NextRow: (UIView *) view
{
    ALRow * belongRow = view.belongRow;
    // 存在下一行的情况
    if ( belongRow.nextRow ) {
        ALRow * toRow = belongRow.nextRow;
        // 如果下一行是block类型的Row
        if ( toRow.display == ALDisplayBlock ) {
            // TODO
        } else {
            while ( ![toRow canAddView: view] ) {
                // 移除溢出的view
                UIView * overflow = [toRow popView];
                // 递归咯
                [self crushView2NextRow:overflow];
            }
        }
        [toRow addView: view];
    } else {
        [self createNewRowWithView: view previousRow:view.belongRow];
    }
}
// 将一个inline view从指定的一行结束位置插入
// 如果当前行有空隙，那递归下一行的view继续往上一行插入
//- (void) crushView2PreviousRow: (UIView *) view
//{
//    ALRow * belongRow = view.belongRow;
//    // 存在上一行的情况
//    if ( belongRow.previousRow ) {
//        ALRow * toRow = belongRow.previousRow;
//        // 如果下一行是block类型的Row
//        if ( toRow.display == ALDisplayBlock ) {
//            // 往上一行尾部插入一个view不存在该情况
//        } else {
//            while ( ![toRow canAddView: view] ) {
//                // 移除溢出的view
//                UIView * overflow = [toRow shiftView];
//                // 递归咯
//                [self crushView2PreviousRow:overflow];
//            }
//        }
//        [toRow pushView: view];
//    }
//    // 不存在上一行的情况是不存在的
//}

- (void) crushView2PreviousRow: (ALRow *) row
{
    // 存在上一行的情况
    if ( row.previousRow ) {
        // 如果当前行已经移除完
        if ( [row count] == 0 ) {
            if ( row.nextRow && row.nextRow.display == ALDisplayInline ) {
                [self crushView2PreviousRow: row.nextRow];
            } else {
                return [_rows removeObject: row];
            }
        } else {
            UIView * firstView = [row fisrtView];
            
            if ( [row.previousRow canAddView: firstView] ) {
                // 移除当前行的第一个view，插入到上一行尾部
                [row.previousRow pushView: [row shiftView]];
                // 递归
                [self crushView2PreviousRow: row];
            } else if ( row.nextRow && row.nextRow.display == ALDisplayInline ) {
                [self crushView2PreviousRow: row.nextRow];
            }
        }
    }
}

/*
 * 重排自己
 * 重排自己与兄弟view、父view
 */
//- (void) reflowSelfView
//{
//    if ( self.ownerView.superview ) {
//        [self.ownerView.superview.rowManager reflowChildView: self.ownerView];
//    } else {
//        
//    }
//}

/*
 * 重排Row Manager中的某个子view
 */
//- (void) reflowSubView: (UIView *) view
//{
//    ALRow * belongRow = [self findTheRowInCurrentManager: view];
//}

// 重排
- (void) reflowChildView: (UIView *) view
{
    // 找到该view所属的行，由行去决定如何reflow该view
    ALRow * belongRow = view.belongRow;
    
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
//        if ( belongRow.nextRow ) {
            [self crushView2PreviousRow: belongRow];
//        }
    }
    // 重排自己的高度
    [self reflowSelfHeight];
}
// 重排父view的高
- (void) reflowSelfHeight
{
    if ( self.ownerView.isAutoHeight ) {
        ALRow * belongRow = self.ownerView.belongRow;
        
        self.ownerView.frame = CGRectMake(self.ownerView.frame.origin.x, self.ownerView.frame.origin.y, self.ownerView.frame.size.width, _rows.lastObject.height + _rows.lastObject.top);
        
        [belongRow refreshSize];
        
        if ( self.ownerView.position == ALPositionRelative ) {
            while (belongRow.nextRow) {
                [belongRow.nextRow reflowTop];
                belongRow = belongRow.nextRow;
            }
            if ( self.ownerView.superview ) {
                [self.ownerView.superview.rowManager reflowSelfHeight];
            }
        }
    }
}
// 重排自己的Size，主要给absolute方式的view使用
- (void) reflowSelfSizeOfAbsolute
{
    if ( self.ownerView.isAutoWidth ) {
        CGFloat width = 0;
        for (ALRow * row in _rows) {
            if ( width < row.width ) {
                width = row.width;
            }
        }
        self.ownerView.frame = CGRectMake(self.ownerView.frame.origin.x, self.ownerView.frame.origin.y, width, self.ownerView.frame.size.height);
    }
    
    if ( self.ownerView.isAutoHeight ) {
        self.ownerView.frame = CGRectMake(self.ownerView.frame.origin.x, self.ownerView.frame.origin.y, self.ownerView.frame.size.width, _rows.lastObject.height + _rows.lastObject.top);
    }
}

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
//- (ALRow *) findTheRowOfView: (UIView *) view
//{
//    if ( view.superview && view.superview.rowManager ) {
//        return [view.superview.rowManager findTheRowInCurrentManager: view];
//    }
//    return nil;
//}
//
//- (ALRow *) findTheRowInCurrentManager: (UIView *) view
//{
//    if ( [_rows count] > view.row ) {
//        return [_rows objectAtIndex: view.row];
//    }
//    return nil;
//
//}


@end
