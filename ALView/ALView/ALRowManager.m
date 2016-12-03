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
        self.view = view;
    }
    return self;
}

- (void) pushView: (UIView *) view
{
    // 当前inline view在该容器作为第一行展示
    if ( [_rows count] == 0 ) {
        [self createNewRowWithView: view previousRow:nil top: 0];
    } else {
        ALRow * lastRow = _rows.lastObject;
        if ( [lastRow canAddView: view] ) {
            [lastRow pushView: view];
        } else {
            [self createNewRowWithView: view previousRow:lastRow top: lastRow.top + lastRow.height];
        }
    }
}

- (ALRow *) createNewRowWithView: (UIView *) view previousRow: (ALRow *) previousRow top: (CGFloat) top
{
    ALRow * newRow = [[ALRow alloc] init];
    newRow.contentAlign = self.view.contentAlign;
    newRow.top = top;
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


@end
