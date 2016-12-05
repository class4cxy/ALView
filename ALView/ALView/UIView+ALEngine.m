//
//  UIView+ALEngine.m
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "UIView+ALEngine.h"
#import <objc/runtime.h>

@implementation UIView (ALEngine)

#pragma mark - dynamic property

@dynamic isALEngine;
- (BOOL) isALEngine
{
    return [objc_getAssociatedObject(self, @"isALEngine") boolValue];
}
- (void) setIsALEngine:(BOOL)isALEngine
{
    objc_setAssociatedObject(self, @"isALEngine", [NSNumber numberWithBool:isALEngine], OBJC_ASSOCIATION_RETAIN);
}

@dynamic position;
- (ALPosition) position
{
    return (ALPosition)[objc_getAssociatedObject(self, @"position") intValue];
}
-(void)setPosition:(ALPosition)position
{
    objc_setAssociatedObject(self, @"position", [NSNumber numberWithInt:position], OBJC_ASSOCIATION_RETAIN);
}

@dynamic contentAlign;
- (ALContentAlign) contentAlign
{
    return (ALContentAlign)[objc_getAssociatedObject(self, @"contentAlign") intValue];
}
-(void)setContentAlign:(ALContentAlign)contentAlign
{
    objc_setAssociatedObject(self, @"contentAlign", [NSNumber numberWithInt:contentAlign], OBJC_ASSOCIATION_RETAIN);
}

@dynamic display;
- (ALDisplay) display
{
    return (ALDisplay)[objc_getAssociatedObject(self, @"display") intValue];
}
-(void)setDisplay:(ALDisplay)display
{
    objc_setAssociatedObject(self, @"display", [NSNumber numberWithInteger:display], OBJC_ASSOCIATION_RETAIN);
}

@dynamic width;
- (CGFloat) width
{
    return [objc_getAssociatedObject(self, @"width") floatValue];
}
-(void)setWidth:(CGFloat)width
{
    self.isAutoWidth = NO;
    objc_setAssociatedObject(self, @"width", [NSNumber numberWithFloat:width], OBJC_ASSOCIATION_RETAIN);
}

@dynamic height;
- (CGFloat) height
{
    return [objc_getAssociatedObject(self, @"height") floatValue];
}
-(void)setHeight:(CGFloat)height
{
    self.isAutoHeight = NO;
    objc_setAssociatedObject(self, @"height", [NSNumber numberWithFloat:height], OBJC_ASSOCIATION_RETAIN);
}


@dynamic top;
- (CGFloat) top
{
    return [objc_getAssociatedObject(self, @"top") floatValue];
}
-(void)setTop:(CGFloat)top
{
    self.hasSettedTop = YES;
    objc_setAssociatedObject(self, @"top", [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN);
}

@dynamic bottom;
- (CGFloat) bottom
{
    return [objc_getAssociatedObject(self, @"bottom") floatValue];
}
-(void)setBottom:(CGFloat)bottom
{
    self.hasSettedBottom = YES;
    objc_setAssociatedObject(self, @"bottom", [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic left;
- (CGFloat) left
{
    return [objc_getAssociatedObject(self, @"left") floatValue];
}
-(void)setLeft:(CGFloat)left
{
    self.hasSettedLeft = YES;
    objc_setAssociatedObject(self, @"left", [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN);
}

@dynamic right;
- (CGFloat) right
{
    return [objc_getAssociatedObject(self, @"right") floatValue];
}
-(void)setRight:(CGFloat)right
{
    self.hasSettedRight = YES;
    objc_setAssociatedObject(self, @"right", [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN);
}

@dynamic centerX;
- (CGFloat) centerX
{
    return [objc_getAssociatedObject(self, @"centerX") floatValue];
}
-(void)setCenterX:(CGFloat)centerX
{
    self.hasSettedCenterX = YES;
    objc_setAssociatedObject(self, @"centerX", [NSNumber numberWithFloat:centerX], OBJC_ASSOCIATION_RETAIN);
}

@dynamic centerY;
- (CGFloat) centerY
{
    return [objc_getAssociatedObject(self, @"centerY") floatValue];
}
-(void)setCenterY:(CGFloat)centerY
{
    self.hasSettedCenterY = YES;
    objc_setAssociatedObject(self, @"centerY", [NSNumber numberWithFloat:centerY], OBJC_ASSOCIATION_RETAIN);
}

@dynamic margin;
- (CGFloat) margin
{
    return [objc_getAssociatedObject(self, @"margin") floatValue];
}
-(void)setMargin:(CGFloat)margin
{
    objc_setAssociatedObject(self, @"margin", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginTop", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginLeft", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginBottom", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, @"marginRight", [NSNumber numberWithFloat:margin], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginTop;
- (CGFloat) marginTop
{
    return [objc_getAssociatedObject(self, @"marginTop") floatValue];
}
-(void)setMarginTop:(CGFloat)marginTop
{
    objc_setAssociatedObject(self, @"marginTop", [NSNumber numberWithFloat:marginTop], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginBottom;
- (CGFloat) marginBottom
{
    return [objc_getAssociatedObject(self, @"marginBottom") floatValue];
}
-(void)setMarginBottom:(CGFloat)marginBottom
{
    objc_setAssociatedObject(self, @"marginBottom", [NSNumber numberWithFloat:marginBottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginLeft;
- (CGFloat) marginLeft
{
    return [objc_getAssociatedObject(self, @"marginLeft") floatValue];
}
-(void)setMarginLeft:(CGFloat)marginLeft
{
    objc_setAssociatedObject(self, @"marginLeft", [NSNumber numberWithFloat:marginLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic marginRight;
- (CGFloat) marginRight
{
    return [objc_getAssociatedObject(self, @"marginRight") floatValue];
}
-(void)setMarginRight:(CGFloat)marginRight
{
    objc_setAssociatedObject(self, @"marginRight", [NSNumber numberWithFloat:marginRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic currInnerHeight;
- (CGFloat) currInnerHeight
{
    return [objc_getAssociatedObject(self, @"currInnerHeight") floatValue];
}
-(void)setCurrInnerHeight:(CGFloat)currInnerHeight
{
    objc_setAssociatedObject(self, @"currInnerHeight", [NSNumber numberWithFloat:currInnerHeight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic currInnerWidth;
- (CGFloat) currInnerWidth
{
    return [objc_getAssociatedObject(self, @"currInnerWidth") floatValue];
}
-(void)setCurrInnerWidth:(CGFloat)currInnerWidth
{
    objc_setAssociatedObject(self, @"currInnerWidth", [NSNumber numberWithFloat:currInnerWidth], OBJC_ASSOCIATION_RETAIN);
}

@dynamic isAutoHeight;
- (BOOL) isAutoHeight
{
    return [objc_getAssociatedObject(self, @"isAutoHeight") boolValue];
}
- (void) setIsAutoHeight:(BOOL)isAutoHeight
{
    objc_setAssociatedObject(self, @"isAutoHeight", [NSNumber numberWithBool:isAutoHeight], OBJC_ASSOCIATION_RETAIN);
}


@dynamic isAutoWidth;
- (BOOL) isAutoWidth
{
    return [objc_getAssociatedObject(self, @"isAutoWidth") boolValue];
}
- (void) setIsAutoWidth:(BOOL)isAutoWidth
{
    objc_setAssociatedObject(self, @"isAutoWidth", [NSNumber numberWithBool:isAutoWidth], OBJC_ASSOCIATION_RETAIN);
}


@dynamic isInNewLine;
- (BOOL) isInNewLine
{
    return [objc_getAssociatedObject(self, @"isInNewLine") boolValue];
}
- (void) setIsInNewLine:(BOOL)isInNewLine
{
    objc_setAssociatedObject(self, @"isInNewLine", [NSNumber numberWithBool:isInNewLine], OBJC_ASSOCIATION_RETAIN);
}


@dynamic hasSettedTop;
- (BOOL) hasSettedTop
{
    return [objc_getAssociatedObject(self, @"hasSettedTop") boolValue];
}
- (void) setHasSettedTop:(BOOL)hasSettedTop
{
    objc_setAssociatedObject(self, @"hasSettedTop", [NSNumber numberWithBool:hasSettedTop], OBJC_ASSOCIATION_RETAIN);
}


@dynamic hasSettedLeft;
- (BOOL) hasSettedLeft
{
    return [objc_getAssociatedObject(self, @"hasSettedLeft") boolValue];
}
- (void) setHasSettedLeft:(BOOL)hasSettedLeft
{
    objc_setAssociatedObject(self, @"hasSettedLeft", [NSNumber numberWithBool:hasSettedLeft], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedCenterX;
- (BOOL) hasSettedCenterX
{
    return [objc_getAssociatedObject(self, @"hasSettedCenterX") boolValue];
}
- (void) setHasSettedCenterX:(BOOL)hasSettedCenterX
{
    objc_setAssociatedObject(self, @"hasSettedCenterX", [NSNumber numberWithBool:hasSettedCenterX], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedCenterY;
- (BOOL) hasSettedCenterY
{
    return [objc_getAssociatedObject(self, @"hasSettedCenterY") boolValue];
}
- (void) setHasSettedCenterY:(BOOL)hasSettedCenterY
{
    objc_setAssociatedObject(self, @"hasSettedCenterY", [NSNumber numberWithBool:hasSettedCenterY], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedRight;
- (BOOL) hasSettedRight
{
    return [objc_getAssociatedObject(self, @"hasSettedRight") boolValue];
}
- (void) setHasSettedRight:(BOOL)hasSettedRight
{
    objc_setAssociatedObject(self, @"hasSettedRight", [NSNumber numberWithBool:hasSettedRight], OBJC_ASSOCIATION_RETAIN);
}

@dynamic hasSettedBottom;
- (BOOL) hasSettedBottom
{
    return [objc_getAssociatedObject(self, @"hasSettedBottom") boolValue];
}
- (void) setHasSettedBottom:(BOOL)hasSettedBottom
{
    objc_setAssociatedObject(self, @"hasSettedBottom", [NSNumber numberWithBool:hasSettedBottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic nextSibling;
- (ALView *) nextSibling
{
    return objc_getAssociatedObject(self, @"nextSibling");
}
- (void) setNextSibling:(ALView *)nextSibling
{
    objc_setAssociatedObject(self, @"nextSibling", nextSibling, OBJC_ASSOCIATION_RETAIN);
}

@dynamic previousSibling;
- (ALView *) previousSibling
{
    return objc_getAssociatedObject(self, @"previousSibling");
}
- (void) setPreviousSibling:(ALView *)previousSibling
{
    objc_setAssociatedObject(self, @"previousSibling", previousSibling, OBJC_ASSOCIATION_RETAIN);
}

@dynamic belongRow;
- (ALRow *) belongRow
{
    return objc_getAssociatedObject(self, @"belongRow");
}
- (void) setBelongRow:(ALRow *)belongRow
{
    objc_setAssociatedObject(self, @"belongRow", belongRow, OBJC_ASSOCIATION_RETAIN);
}

//@dynamic previousRow;
//- (ALRow *) previousRow
//{
//    return objc_getAssociatedObject(self, @"previousRow");
//}
//- (void) setPreviousRow:(ALRow *)previousRow
//{
//    objc_setAssociatedObject(self, @"previousRow", previousRow, OBJC_ASSOCIATION_RETAIN);
//}

//@dynamic row;
//- (NSInteger) row
//{
//    return [objc_getAssociatedObject(self, @"row") integerValue];
//}
//-(void)setRow:(NSInteger)row
//{
//    objc_setAssociatedObject(self, @"row", [NSNumber numberWithInteger:row], OBJC_ASSOCIATION_RETAIN);
//}
//
//@dynamic rows;
//- (NSMutableArray *) rows
//{
//    return objc_getAssociatedObject(self, @"rows");
//}
//- (void) setRows:(NSMutableArray<ALRow *> *)rows
//{
//    objc_setAssociatedObject(self, @"rows", rows, OBJC_ASSOCIATION_RETAIN);
//}

@dynamic rowManager;
- (ALRowManager *) rowManager
{
    return objc_getAssociatedObject(self, @"rowManager");
}
- (void) setRowManager:(ALRowManager *)rowManager
{
    objc_setAssociatedObject(self, @"rowManager", rowManager, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - init
// 继承类需重载该方法，用于初始化对应的配置文件
- (instancetype) initWithALEngine
{
    if ( self = [self initWithFrame:CGRectZero] ) {
        self.isALEngine = YES;
        
        self.isAutoHeight = YES;
        self.isAutoWidth = YES;
        
        self.hasSettedTop = NO;
        self.hasSettedLeft = NO;
        self.hasSettedRight = NO;
        self.hasSettedBottom = NO;
        self.hasSettedCenterX = NO;
        self.hasSettedCenterY = NO;
        
        self.isInNewLine = NO;
        
        self.currInnerWidth = 0;
        self.currInnerHeight = 0;
        
        self.nextSibling = nil;
        self.previousSibling = nil;
        
//        self.rows = [[NSMutableArray alloc] init];
    }
    return self;
}

/*
 * 添加到父view
 */
- (void) addTo: (UIView *) parent
{
    // 将view add到树中
    [parent addSubview: self];
    if ( !parent.rowManager ) {
        // 初始化行管理器
        parent.rowManager = [[ALRowManager alloc] initWithView: parent];
    }
    // 生成兄弟view关系
    [self linkSiblingView];
    // 排版size
    [self reflowSelfSize];
    // 排版origin
    if ( self.position == ALPositionRelative ) {
        [parent.rowManager appendView: self];
    } else {
        [self reflowOriginWhenAbsolute];
    }
}

- (void) insertBefore: (UIView *) nextSiblingView
{
    
}

// 重排自己
- (void) reflow
{
    // 防止未知错误
    if ( self.superview && self.superview.rowManager ) {
        [self reflowSelfSize];
        [self.superview.rowManager reflowChildView: self];
    }
}

- (void) removeFromSuperview
{
    [self removeFromSuperview];
    // TODO
}

/*
 * link view by nextSibling & previousSibling
 */

- (void) linkSiblingView
{
    UIView * parent = self.superview;
    
    UIView * lastSubView = [self getLastALEngineSubview: parent displayModel:-1];
    
    if ( lastSubView != nil ) {
        self.previousSibling = (ALView*)lastSubView;
        lastSubView.nextSibling = (ALView*)self;
    }
}

/*
 * 排版自身尺寸
 */
- (void) reflowSelfSize
{
    UIView * parent = self.superview;
    // ALLabel的计算内部size方法比较特殊，由ALLabel自己实现
    if ( [self isKindOfClass:[ALLabel class]] ) {
        [((ALLabel *) self) reflowWithInnerText: parent];
    } else {
        CGFloat width = self.width;
        // 相对定位时
        if ( self.position == ALPositionRelative ) {
            // 如果是block，且自动宽度布局，那默认宽度是父view的宽度
            if ( self.display == ALDisplayBlock && self.isAutoWidth ) {
                width = self.superview.frame.size.width - self.marginLeft - self.marginRight;
            }
            // 绝对定位时
        } else {
            // TODO
        }
        
        // reflow
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.height);
    }
}

#pragma mark - layout & reflow

//- (void) layout
//{
//    switch (self.position) {
//        case ALPositionRelative:
//        {
//            [self reflowOriginAndSizeWhenRelative];
//        }
//            break;
//            
//        case ALPositionAbsolute:
//        {
//            [self reflowOriginAndSizeWhenAbsolute];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}

/*
 * 总的排版入口，如果涉及到关联的view或者super view需重排也尽量别直接调到这里来
 */
//- (void) reflow
//{
//    switch (self.position) {
//        case ALPositionRelative:
//        {
//            [self reflowOriginAndSizeWhenRelative];
//        }
//            break;
//            
//        case ALPositionAbsolute:
//        {
//            [self reflowOriginAndSizeWhenAbsolute];
//        }
//            break;
//            
//        default:
//            break;
//    }
//}
// relation布局时，重排origin跟size
//- (void) reflowOriginAndSizeWhenRelative
//{
//    UIView * parent = self.superview;
//    // layout size
//    [self reflowSelfSize];
//    // layout origin
//    [parent.rowManager appendView: self];
////    [self reflowOriginWhenRelative];
//    // reflow parent's size
////    [self reflowParentSize];
//}
// relation布局时，重排origin
//- (void) reflowOriginWhenRelative
//{
//    if ( self.display == ALDisplayBlock ) {
//        [self layoutBlockSizeAndOrigin];
//    } else {
//        [self layoutInlineSizeAndOrigin];
//    }
//}

//- (void) layoutBlockSizeAndOrigin
//{
//    UIView * parent = self.superview;
//    [parent.rowManager appendView: self];
////    self.rowManager appendView:(UIView *)
////    [parent pushView: self];
//    
//    // 触发next Sibling view reflow
//    
//}

//- (void) layoutInlineSizeAndOrigin
//{
//    UIView * parent = self.superview;
//    UIView * previousView = self.previousSibling;
//    
//    if ( previousView && previousView.display == ALDisplayBlock ) {
//        CGFloat top =   previousView.frame.origin.y +
//                        previousView.frame.size.height +
//                        previousView.marginBottom;
//        // 如果上一个兄弟view是block，那一定要新起一行
//        [parent createNewRowWithView: self previousRow:parent.rows.lastObject top: top];
//    } else {
//        [parent pushView: self];
//    }
//}

//- (void) reflowParentSize
//{
//    UIView * parent = self.superview;
//
//    // 触发父view重算自己的高度
//    if ( parent.isALEngine ) {
////        [parent reflowInnerSizeIfNeed];
//        [parent reflowParentInnerSize];
//    }
//    // 如果父view是ALScrollView，需触发父view重算contentSize
//    if ([parent isKindOfClass:[ALScrollView class]]) {
//        [((ALScrollView*) parent) reflowInnerFrame];
//    }
//}

//- (void) reflowParentInnerSize
//{
//    // 过滤特殊情况
//    if ( [self.rows count] == 0 ) {
//        return;
//    }
//    
//    // 考虑到排版的复杂度，这里取消支持inline类型的view的isAutoWidth特征
//    // if ( (self.isAutoWidth && self.display == ALDisplayInline) || (self.isAutoWidth && self.position == ALPositionAbsolute) ) {
//    if ( self.isAutoWidth && self.position == ALPositionAbsolute ) {
//        CGFloat innerWidth = 0;
//        for (ALRow * row in self.rows) {
//            if ( innerWidth < row.width ) {
//                innerWidth = row.width;
//            }
//        }
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, innerWidth, self.frame.size.height);
//    }
//    
//    if ( self.isAutoHeight ) {
//        CGFloat innerHeight = self.rows.lastObject.top + self.rows.lastObject.height;
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, innerHeight);
//        // 如果是relative方式布局，需触发下一个兄弟view reflow origin以及父view reflow size
//        if ( self.position == ALPositionRelative ) {
////            ALRow * row = [self.superview findTheRowBelong2: self];
//        }
//    }
//    
//    // 如果当前view使用了absolute布局，而且属于isAutoHeight 或者 isAutoWidth
//    // 那需触发该view重新进行定位排版
//    if ( self.position == ALPositionAbsolute ) {
//        if ( self.isAutoWidth || self.isAutoHeight ) {
//            [self reflowOriginWhenAbsolute];
//        }
//    // 如果是relative方式布局，需触发下一个兄弟view reflow origin以及父view reflow size
//    } else {
//        
//    }
//    if ( self.position == ALPositionAbsolute && (self.isAutoWidth || self.isAutoHeight) ) {
//        [self reflowOriginWhenAbsolute];
//        // 如果当前view使用relative布局，而且属于isAutoHeight
//        // 那需递归触发父view进行高度调整
//    } else if ( self.position == ALPositionRelative && self.superview.isALEngine ) {
//        [self.superview reflowParentInnerSize];
//    }
//}


//- (void) reflowBlockTop
//{
//    CGFloat top = self.marginTop;
//    
//    if ( self.previousSibling ) {
//        top +=  self.previousSibling.marginBottom +
//        self.previousSibling.frame.origin.y +
//        self.previousSibling.frame.size.height;
//    }
//    self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
//}

//- (void) reflowInlineTop
//{
//    ALRow * currRow = nil;
//    // 如果存在上一个view，那要区分上一个view是inline还是block
//    if ( self.previousSibling ) {
//        // inline
//        if ( self.previousSibling.display == ALDisplayInline ) {
//            // 检查是否能断行
//            if ( self.isInNewLine ) {
//                ALRow * preRow = [self getParentPreviRow];
//                CGFloat newRowY = 0;
//                if ( preRow != nil ) {
//                    newRowY = preRow.top + preRow.height;
//                }
//                
//                currRow = [self addToNewRowManager: newRowY];
//            } else { // 不断行
//                currRow = [self addToLastRowManager];
//                
//            }
//            // block
//        } else {
//            CGFloat top =   self.previousSibling.frame.origin.y +
//                            self.previousSibling.frame.size.height +
//                            self.previousSibling.marginBottom;
//            
//            currRow = [self addToNewRowManager: top];
//        }
//        // 否则
//    } else {
//        currRow = [self addToNewRowManager: 0];
//    }
//    self.frame = CGRectMake(self.frame.origin.x, currRow.top + self.marginTop, self.frame.size.width, self.frame.size.height);
//}

/*
 * 父view内容左对齐，inline排版的view的left计算逻辑
 */
//- (void) reflowInlineLeftWidthContentAlignLeft
//{
//    CGFloat left = 0;
//    UIView * parent = self.superview;
//    UIView * prevView = self.previousSibling;
//    // 存在上一个兄弟view 且 上一个兄弟view是inline排版类型
//    if ( prevView && prevView.display == ALDisplayInline ) {
//        CGFloat x = prevView.frame.origin.x +
//                    prevView.frame.size.width +
//                    prevView.marginRight;
//        // 默认取父View的宽高
//        CGFloat parentWidth = parent.frame.size.width;
//        // 如果父view是inline类型view，且没有设置宽度，那就往上找
//        // 如果父view是block类型view，但是用了absolute方式布局，那也要往上找
//        if ( (parent.display == ALDisplayInline || parent.position == ALPositionAbsolute) && parent.isAutoWidth ) {
//            UIView * p = [self getLastNotInlineOrAutoWidthParentView: parent];
//            parentWidth = p.frame.size.width;
//        }
//        // 检查是否需要断行
//        if ( parentWidth < (x + self.marginLeft + self.marginRight + self.frame.size.width) ) { // 断行
//            left = self.marginLeft;
//            
//            self.isInNewLine = YES;
//        } else { // 不断行
//            left =  self.marginLeft +
//                    prevView.frame.origin.x +
//                    prevView.frame.size.width +
//                    prevView.marginRight;
//            
//            self.isInNewLine = NO;
//        }
//    } else { // previousView为的排版类型是block或者nil都在新一行排版
//        left = self.marginLeft;
//        self.isInNewLine = YES;
//    }
//    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
////    return left;
//}

/*
 * 父view内容居中对齐，inline排版的view的left计算逻辑
 */

//- (void) reflowInlineLeftWidthContentAlignCenter
//{
//    UIView * parent = self.superview;
//    // 默认断行的排版坐标
//    CGFloat left = (parent.frame.size.width - self.frame.size.width)/2;
//    UIView * prevView = self.previousSibling;
//    UIView * nextView = self.nextSibling;
//    BOOL callPreviousViewReflow = NO;
//    
//    // 如果存在nextSibling的情况，那就是由下一个兄弟view触发的重排
//    if ( nextView && nextView.display == ALDisplayInline ) {
//        // 如果下一个view是新的一行，那当前view应该是使用最后位置的布局
//        if ( nextView.isInNewLine ) {
//            CGFloat currRowWidth = [self getWidthOfInsideRow:self];
//            CGFloat parentWidth = parent.frame.size.width;
//            
//            left =  (parentWidth + currRowWidth)/2 -
//                    self.marginRight -
//                    self.frame.size.width;
//        } else {
//            left =  nextView.frame.origin.x -
//                    nextView.marginLeft -
//                    self.marginRight -
//                    self.frame.size.width;
//        }
//        // 如果当前view不是新的一行，而且上一兄弟view存在，那就继续冒泡触发上一个兄弟view重排
//        if ( prevView ) {
//            callPreviousViewReflow = YES;
//        }
//    // 存在上一个兄弟view 且 上一个兄弟view是inline排版类型
//    } else if ( prevView && prevView.display == ALDisplayInline ) {
//        CGFloat currRowWidth = [self getWidthOfInsideRow:self];
//        CGFloat parentWidth = parent.frame.size.width;
//        if ( parent.isAutoWidth ) { // 自动宽度时，应该拿父view的宽度做计算
//            parentWidth = parent.superview.frame.size.width;
//        }
//        // 检查是否需要断行
//        if ( currRowWidth > parentWidth ) { // 断行
//            self.isInNewLine = YES;
//            callPreviousViewReflow = YES;
//        } else { // 不断行，也同样排在最右侧，只不过会触发上一个兄弟节点进行重排
//            left =  (parent.frame.size.width + currRowWidth)/2 -
//                    self.marginRight -
//                    self.frame.size.width;
//            
//            callPreviousViewReflow = YES;
//        }
//    } else { // previousView为的排版类型是block或者nil都在新一行排版
//        self.isInNewLine = YES;
//    }
//    
//    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
//    
//    if ( callPreviousViewReflow ) {
//        [prevView reflowInlineLeftWidthContentAlignCenter];
//    }
//}

/*
 * 父view内容右对齐，inline排版的view的left计算逻辑
 */
//- (void) reflowInlineLeftWidthContentAlignRight
//{
//    UIView * parent = self.superview;
//    // 默认断行情况的右对齐的排版
//    CGFloat left =  parent.frame.size.width -
//                    self.frame.size.width -
//                    self.marginRight;
//    UIView * prevView = self.previousSibling;
//    UIView * nextView = self.nextSibling;
//    BOOL callPreviousViewReflow = NO;
//    
//    // 如果存在nextSibling的情况，那就是由下一个兄弟view触发的重排
//    if ( nextView && nextView.display == ALDisplayInline ) {
//        
//        if ( !nextView.isInNewLine ) {
//            left =  nextView.frame.origin.x -
//                    nextView.marginLeft -
//                    self.marginRight -
//                    self.frame.size.width;
//        }
//        // 如果当前view不是新的一行，而且上一兄弟view存在，那就继续冒泡触发上一个兄弟view重排
//        if ( prevView ) {
//            callPreviousViewReflow = YES;
//        }
//        
//    // 存在上一个兄弟view 且 上一个兄弟view是inline排版类型
//    } else if ( prevView && prevView.display == ALDisplayInline ) {
//        CGFloat currRowWidth = [self getWidthOfInsideRow:self];
//        CGFloat parentWidth = parent.frame.size.width;
//        if ( parent.isAutoWidth ) { // 自动宽度时，应该拿父view的宽度做计算
//            parentWidth = parent.superview.frame.size.width;
//        }
//        // 检查是否需要断行
//        if ( currRowWidth > parentWidth ) { // 断行
//            self.isInNewLine = YES;
//            callPreviousViewReflow = YES;
//        } else { // 不断行，也同样排在最右侧，只不过会触发上一个兄弟节点进行重排
//            callPreviousViewReflow = YES;
//        }
//    } else { // previousView为的排版类型是block或者nil都在新一行排版
//        self.isInNewLine = YES;
//    }
//
//    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
//    NSLog(@"reflowInlineLeftWidthContentAlignRight");
//    
//    if ( callPreviousViewReflow ) {
//        [prevView reflowInlineLeftWidthContentAlignRight];
//    }
//}

//- (void) reflowBlockLeft
//{
//    CGFloat left = 0;
//    CGFloat width = self.frame.size.width;
//    UIView * parent = self.superview;
//    // 根据父view的内容对齐方式计算left
//    if ( parent.isALEngine ) {
//        switch (parent.contentAlign) {
//                // 靠左排版
//            case ALContentAlignLeft:
//            {
//                left += self.marginLeft;
//            }
//                break;
//                // 靠右排版
//            case ALContentAlignRight:
//            {
//                left += parent.frame.size.width - width - self.marginRight;
//            }
//                break;
//                // 居中排版
//            case ALContentAlignCenter:
//            {
//                left += (parent.frame.size.width - width)/2 + self.marginLeft - self.marginRight;
//            }
//                break;
//                
//            default:
//                break;
//        }
//    } else { // 默认靠左
//        left += self.marginLeft;
//    }
//    
////    self.frame.origin.x = left;
//    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
//}

// absolute方式的排版：相对父view绝对位置排版
// 宽高：没有自动宽，高度可由子view撑高，但不能撑开父view，不能触发父view reflow
// 位置：通过top,left,bottom,right,centerX,centerY相对于父view来定位
// 注：如果父view为ALScrollView，排版应该是相对于父view的滚动区
// 注：1、位置不受margin影响；2、不受同级view排版影响。
//- (void) reflowOriginAndSizeWhenAbsolute
//{
//    // 排版size
//    [self reflowSelfSize];
//    [self reflowOriginWhenAbsolute];
//}
// 不带重排size
- (void) reflowOriginWhenAbsolute
{
    UIView * parent = self.superview;
    
    CGFloat top = self.top;
    CGFloat left = self.left;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat parentHeight = parent.frame.size.height;
    CGFloat parentWidth = parent.frame.size.width;
    
    // 如果父view是scrollView，排版需参考父view的content
    // contentSize与frame.size，谁大用谁
    if ( [parent isKindOfClass:[UIScrollView class]] ) {
        CGFloat contentHeight = ((UIScrollView*)parent).contentSize.height;
        CGFloat contentWidth = ((UIScrollView*)parent).contentSize.width;
        
        if ( contentHeight > parentHeight ) {
            parentHeight = contentHeight;
        }
        if ( contentWidth > parentWidth ) {
            parentWidth = contentWidth;
        }
    }
    // 优先级：top > centerY > bottom
    if ( !self.hasSettedTop ) {
        if ( self.hasSettedCenterY ) {
            top = (parentHeight - height) / 2 + self.centerY;
        } else if ( self.hasSettedBottom ) {
            top = parentHeight - self.bottom - height;
        }
    }
    // 优先级：left > centerX > right
    if ( !self.hasSettedLeft ) {
        if ( self.hasSettedCenterX ) {
            left = (parentWidth - width) / 2 + self.centerX;
        } else if ( self.hasSettedRight ) {
            left = parentWidth - self.right - width;
        }
    }
    
    self.frame = CGRectMake(left, top, width, height);
}

/*
 * 如果isAutoHeight=YES时，每次子view操作都应当重新计算view的高度
 */
//- (void) reflowInnerSizeIfNeed
//{
//    CGFloat innerHeight = 0;
//    CGFloat innerWidth = 0;
//    // 计算最高的 currInnerHeight
//    UIView * lastView = [self getLastRelativeSubView: self];
//    // 保护
//    if ( lastView == nil ) {
//        return;
//    }
//    // 如果是block，直接取偏移量
//    if ( lastView.display == ALDisplayBlock ) {
//        innerHeight =   lastView.frame.size.height +
//                        lastView.frame.origin.y +
//                        lastView.marginBottom;
//    // 如果是inline，需找到该view所属的row的偏移量
//    } else {
//        ALRow * lastRow = self.rows.lastObject;
//        if ( lastRow ) {
//            innerHeight = lastRow.height + lastRow.top;
//        } else {
//            // TODO : 异常处理
//        }
//    }
//    // 更新属性
//    self.currInnerHeight = innerHeight;
//    
//    // calc inner width - only block view can overflow parent view's width
//    innerWidth = [self getWidthOfInsideRow: lastView];
//    
//    if ( self.currInnerWidth < innerWidth ) {
//        self.currInnerWidth = innerWidth;
//    } else {
//        innerWidth = self.currInnerWidth;
//    }
//
//    // 如果没设置高度，那就是系统自动设置（根据子view来算自身高度）
//    if ( self.isAutoHeight ) {
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, innerHeight);
//    }
//    // inline类型排版的view如果没设置宽度，则会被子view宽度撑大
//    // block类型排版的view如果没设置宽度，则默认继承父view的宽度，所以block类型不需要处理该逻辑，但是block类型如果用了absolute方式定位就不会继承父view的宽度
//    if ( (self.isAutoWidth && self.display == ALDisplayInline) || (self.position == ALPositionAbsolute && self.isAutoWidth) ) {
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, innerWidth, self.frame.size.height);
//        
//        // 重排自身的宽高之后，如果自身设置了ALContentAlignRight或者ALContentAlignCenter，那就需要触发子view进行重排
//        if ( self.contentAlign == ALContentAlignRight ) {
//            [self.subviews.lastObject reflowInlineLeftWidthContentAlignRight];
//        } else if ( self.contentAlign == ALContentAlignCenter ) {
//            [self.subviews.lastObject reflowInlineLeftWidthContentAlignCenter];
//        }
//    }
//    
//    // 如果当前view使用了absolute布局，而且属于isAutoHeight 或者 isAutoWidth
//    // 那需触发该view重新进行定位排版
//    if ( self.position == ALPositionAbsolute && (self.isAutoWidth || self.isAutoHeight) ) {
//        [self reflowOriginWhenAbsolute];
//    // 如果当前view使用relative布局，而且属于isAutoHeight
//    // 那需递归触发父view进行高度调整
//    } else if ( self.position == ALPositionRelative && self.superview.isALEngine ) {
//        [self.superview reflowInnerSizeIfNeed];
//    }
//}

//- (void) refreshView
//{
//    [self reflow];
//    UIView * parent = self.superview;
//    // absolute类型的view的重排逻辑：
//    // 1、reflow size
//    // 2、reflow origin
//    // 3、触发内部子view重排
//    if ( self.position == ALPositionAbsolute ) {
//        
//    // relative类型的view重排逻辑：
//    } else {
//        // block
//        if ( self.display == ALDisplayBlock ) {
//            
//            [self recurFrom: self recurType: ALRecursionNextView iterator:^(UIView * view) {
//                if ( view.position == ALPositionRelative ) {
//                    if ( view.display == ALDisplayBlock ) {
//                        [view reflowOriginAndSizeWhenRelative];
//                    } else {
//                        [view reflowInlineTop];
//                    }
//                }
//            }];
//
//        // inline
//        } else {
//            switch (parent.contentAlign) {
//                case ALContentAlignLeft:
//                {
//                    [parent removeViewToLastViewFromRow: self];
//                    [self recurFrom: self recurType: ALRecursionNextView iterator:^(UIView * view) {
//                        if ( view.position == ALPositionRelative ) {
//                            [view reflowOriginAndSizeWhenRelative];
//                        }
//                    }];
//                }
//                    break;
//                case ALContentAlignCenter:
//                {
//                    ALRow * exsitRow = [parent.rows objectAtIndex: self.row];
//                    if ( exsitRow && [exsitRow.viewArr count] > 0 ) {
//                        UIView * firstView = [exsitRow.viewArr objectAtIndex: 0];
//                        [parent removeViewToLastViewFromRow: firstView];
//                        [self recurFrom: self recurType: ALRecursionNextView iterator:^(UIView * view) {
//                            if ( view.position == ALPositionRelative ) {
//                                if ( view.display == ALDisplayInline ) {
//                                    [view reflow: YES];
//                                } else {
//                                    [view reflow: NO];
//                                }
//                            }
//                        }];
//                    }
//                }
//                    break;
//                case ALContentAlignRight:
//                {
//                    ALRow * exsitRow = [parent.rows objectAtIndex: self.row];
//                    if ( exsitRow && [exsitRow.viewArr count] > 0 ) {
//                        UIView * firstView = [exsitRow.viewArr objectAtIndex: 0];
//                        [parent removeViewToLastViewFromRow: firstView];
//                        [self recurFrom: self recurType: ALRecursionNextView iterator:^(UIView * view) {
//                            if ( view.position == ALPositionRelative ) {
//                                if ( view.display == ALDisplayInline ) {
//                                    [view reflow: YES];
//                                } else {
//                                    [view reflow: NO];
//                                }
//                            }
//                        }];
//                    }
//                }
//                    break;
//                    
//                default:
//                    break;
//            }
//        }
//    }
//}

#pragma mark - 链表操作逻辑

/*
 * 递归父view
 */
//- (void) recurParents: (void(^)(UIView *)) iterator
//{
//    UIView * parent = self.superview;
//    while ( parent ) {
//        // 跳过非AL布局的parent
//        if ( parent.isALEngine ) {
//            // 执行迭代器
//            iterator(parent);
//        }
//        // 递归
//        parent = parent.superview;
//    }
//}

/*
 * 递归(兄弟、父)view，（包括自己）然后执行迭代器
 */
//- (void) recurFrom: (UIView *) view recurType: (ALRecursionType) recurType iterator: (void(^)(UIView *)) iterator
//{
//    while ( view ) {
//        // 跳过非AL布局的parent
//        if ( view.isALEngine ) {
//            // 执行迭代器
//            iterator(view);
//        }
//        // 递归
//        view = [self getNextRecurView: view recurType: recurType];
//    }
//}
//
//- (UIView *) getNextRecurView: (UIView *) view recurType: (ALRecursionType) recurType
//{
//    UIView * nextView = nil;
//    
//    switch (recurType) {
//        case ALRecursionPreviousView:
//            nextView = view.previousSibling;
//            break;
//            
//        case ALRecursionParentView:
//            nextView = view.superview;
//            break;
//            
//        case ALRecursionNextView:
//            nextView = view.nextSibling;
//            break;
//            
//        default:
//            break;
//    }
//    return  nextView;
//}

#pragma mark - 行管理相关逻辑

// 将一个inline view从指定的一行开始位置插入
// 如果造成指定Row溢出（宽度超过最大宽度），那会将溢出的内容递归的插入下一个Row
//- (void) crushInlineView: (UIView *) view toRow: (NSUInteger) rowNum
//{
//    // 防止越界
//    if ( [self.rows count] >= rowNum+1 ) {
//        ALRow * toRow = [self.rows objectAtIndex: rowNum];
//
//        while ( ![toRow canAddView: view] ) {
//            // 移除溢出的view
//            UIView * overflow = [toRow popView];
//            // 如果没有下一行，那新建
//            if ( [self.rows count] < rowNum+2 ) {
//                [self addNewRowManager: toRow.top + toRow.height display: ALDisplayInline];
//            }
//            // 递归咯
//            [self crushInlineView:overflow toRow: rowNum+1];
//        }
//        
//        [toRow addView: view];
//    }
//}

// 重排指定的view所在的行
//- (void) rowReflowWithView: (UIView *) view
//{
//    if ( [self.rows count] > view.row ) {
//        ALRow * row = [self.rows objectAtIndex: view.row];
//        [row layout];
//    }
//}

//- (void) pushView: (UIView *) view
//{
//    // 当前inline view在该容器作为第一行展示
//    if ( [self.rows count] == 0 ) {
//        [self createNewRowWithView: view previousRow:nil top: 0];
//    } else {
//        ALRow * lastRow = self.rows.lastObject;
//        if ( [lastRow canAddView: view] ) {
//            [lastRow pushView: view];
//        } else {
//            [self createNewRowWithView: view previousRow:lastRow top: lastRow.top + lastRow.height];
//        }
//    }
//}

// 递归触发当前Row的兄弟Row进行reflow origin.top
//- (void) rowRecurNextRowReflow: (ALRow *) currRow
//{
//    NSInteger len = [self.rows count];
//    NSUInteger index = [self.rows indexOfObject: currRow] + 1;
//    if ( index < len ) {
//        ALRow * nextRow = [self.rows objectAtIndex: index];
//        nextRow.top = currRow.height + currRow.top;
//        [nextRow reflowTop];
//        [self rowRecurNextRowReflow: nextRow];
//    } else {
//        if ( self && self.isALEngine ) {
//            [self rowParentRowReflow];
//        }
//    }
//}
// 递归触发当前Row的父级Row进行reflow size
//- (void) rowParentRowReflow
//{
//    if ( self.position == ALPositionAbsolute ) {
//    
//    // relative 方式排版
//    } else {
//        if ( self.isAutoHeight ) {
//            ALRow * currRow =
//        }
//    }
//}

// 挤：把一个view挤到合适的行
//- (void) crushToRightRow: (UIView *) view toRow: (NSUInteger) rowNum
//{
//    // 防止越界
//    if ( [self.rows count] >= rowNum+1 ) {
//        ALRow * toRow = [self.rows objectAtIndex: rowNum];
//        
//        // 如果没有足够空间插入
//        if ( [toRow canAddView: view] ) {
//            [toRow addView: view];
//            [toRow reflow];
//        } else {
//            // 移除溢出的view
//            UIView * overflow = [toRow popView];
//            // 如果没有下一行，那新建
//            if ( [self.rows count] < rowNum+2 ) {
//                [self addNewRowManager: toRow.top + toRow.height];
//            }
//            // 递归咯
//            [self addView:overflow toRow: rowNum+1];
//        }
//    }
//}

//- (ALRow *) createNewRowWithView: (UIView *) view previousRow: (ALRow *) previousRow top: (CGFloat) top
//{
//    ALRow * newRow = [[ALRow alloc] init];
//    newRow.contentAlign = self.contentAlign;
//    newRow.top = top;
//    newRow.display = view.display;
//    newRow.maxWidth = [self getStaticWidthFromParent: view];
//    // link row
//    if ( previousRow ) {
//        newRow.previousRow = previousRow;
//        previousRow.nextRow = newRow;
//    }
//    newRow.parentView = self;
//    
//    [newRow pushView: view];
//    [self.rows addObject:newRow];
//    return newRow;
//}

// 递归重排下一个兄弟Row以及父Row
//- (void) rowReflowNextAndParent: (NSInteger) startRowNum
//{
//    NSInteger totalRowNum = [self.rows count];
//    // 存在下一行
//    if ( startRowNum < totalRowNum ) {
//        for (; startRowNum < totalRowNum; startRowNum++) {
//            
//        }
//    }
//}

// 返回该view所在的Row
//- (ALRow *) findTheRowBelong2: (UIView *) view
//{
//    if ( view.row < [self.rows count] ) {
//        return [self.rows objectAtIndex:view.row];
//    }
//    return nil;
//}

//- (ALRow *) addNewRowManager: (CGFloat) top display: (ALDisplay) display
//{
//    ALRow * newRow = [[ALRow alloc] initWithTop:top contentAlign:self.contentAlign display: display];
//    [self.rows addObject:newRow];
//    return newRow;
//}

//- (ALRow *) addToLastRowManager
//{
//    if ( self.superview && self.superview.isALEngine ) {
//        ALRow * lastRow = self.superview.rows.lastObject;
//        if ( lastRow != nil ) {
//            [lastRow addView: self];
//            self.row = [self.superview.rows count]-1;
//        }
//        return lastRow;
//    }
//    return nil;
//}

//- (ALRow *) addToNewRowManager: (CGFloat) top
//{
//    if ( self.superview && self.superview.isALEngine ) {
//        self.row = [self.superview.rows count];
//        ALRow * newRow = [[ALRow alloc] initWithTop:top contentAlign:self.superview.contentAlign display:self.display];
//        [newRow addView: self];
//        [self.superview.rows addObject:newRow];
//        return newRow;
//    }
//    return nil;
//}

//- (ALRow *) getParentPreviRow
//{
//    if ( self.superview && [self.superview.rows count] > 0 ) {
//        return [self.superview.rows objectAtIndex: [self.superview.rows count]-1];
//    }
//    return nil;
//}

// 从指定view开始移除，直到last view
// 但整个row的view被移除完后，默认移除该row
//- (void) removeViewToLastViewFromRow: (UIView *) view
//{
//    if ( view ) {
//        ALRow * lastRow = self.rows.lastObject;
//        if ( lastRow ) {
//            UIView * lastView = lastRow.viewArr.lastObject;
//            // 移除
//            [lastRow.viewArr removeLastObject];
//            // 如果结束，则移除整行
//            if ( [lastRow.viewArr count] == 0 ) {
//                [self.rows removeLastObject];
//            }
//            // 递归
//            if ( lastView && lastView != view ) {
//                [self removeViewToLastViewFromRow: view];
//            }
//        }
//    }
//}

// 当后期修改导致reflow时，需重置父view的row管理器
//- (void) resetParentRowManager
//{
//    UIView * parent = self.superview;
//    if ( parent ) {
//        switch (parent.contentAlign) {
//            case ALContentAlignLeft:
//            {
//                [parent removeViewToLastViewFromRow: self];
//            }
//                break;
//            case ALContentAlignCenter:
//            {
//                [parent.rows removeAllObjects];
//            }
//                break;
//            case ALContentAlignRight:
//            {
//                [parent.rows removeAllObjects];
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//}

#pragma mark - 私有方法
/*
 * 获取子view中的最后一个ALView，可通过display类型来查找
 */
- (UIView *) getLastALEngineSubview: (UIView *)parent displayModel: (NSUInteger) index
{
    UIView * lastView = nil;
    NSInteger i = parent.subviews.count - 2; // 跳过自己
    
    for (; i >= 0; i--) {
        lastView = [parent.subviews objectAtIndex:i];
        if ( lastView.isALEngine && (index == -1 || lastView.display == (ALDisplay)index) ) {
            return lastView;
        }
    }
    return nil;
}

/*
 * 获取view所在当前行（row）的宽度
 * 以当前view默认排到上一列而计算出的宽度
 */
//- (CGFloat) getWidthOfInsideRow: (UIView *) view
//{
//    CGFloat width = 0;
//    
//    while (view && view.display == ALDisplayInline) {
//        width += view.marginLeft +
//                 view.marginRight +
//                 view.frame.size.width;
//        
//        // 如果到了这一行的第一个view，那就跳出该计算
//        if ( view.isInNewLine ) {
//            break;
//        } else { // 否则继续递归
//            view = view.previousSibling;
//        }
//    }
//    
//    return width;
//}

/*
 * 获取当前view最近的非inline方式布局的父view
 */
//- (UIView *) getLastNotInlineOrAutoWidthParentView: (UIView *) view
//{
//    while (view) {
//        if ( (view.superview.display != ALDisplayInline && view.superview.position != ALPositionAbsolute) || !view.superview.isAutoWidth ) {
//            return view.superview;
//        }
//        view = view.superview;
//    }
//    return [[[UIApplication sharedApplication] delegate] window];
//}

/*
 * 获取当前view的最后一个使用relative布局的子view
 */
//- (UIView *) getLastRelativeSubView: (UIView *) parent
//{
//    UIView * lastView = parent.subviews.lastObject;
//    while (lastView) {
//        if ( lastView.isALEngine && lastView.position == ALPositionRelative ) {
//            return lastView;
//        }
//        lastView = lastView.previousSibling;
//    }
//    // 如果lastView不存在，那就返回Nil
//    return nil;
//}
/*
 * 获取父view的宽度
 * 特殊：使用absolute布局且isAutoWidth=YES的父view，需递归一直往上查找
 */
- (CGFloat) getParentWidth
{
    if ( self.superview ) {
        if ( self.superview.isALEngine && self.superview.position == ALPositionAbsolute && self.superview.isAutoWidth ) {
            return [self.superview getParentWidth];
        }
        return self.superview.frame.size.width;
    }
    return [[UIScreen mainScreen] bounds].size.width;
}
/*
 * 递归获取有固定宽度的父view
 * 1、如果当前view是block类型，那直接返回该view的父view宽度
 * 2、如果当前view是inline类型，递归查询父view：
 *   - 如果父view是block类型，直接返回父view的宽度
 *   - 如果父view是inline且isAutoWidth=NO，返回该父view宽度
 */
//- (CGFloat) getStaticWidthFromParent: (UIView *) view
//{
//    if ( view.superview != nil ) {
//        if ( view.display == ALDisplayBlock ) {
//            return view.superview.frame.size.width;
//        } else {
//            if ( view.superview.display == ALDisplayBlock || !view.superview.isAutoWidth ) {
//                return view.superview.frame.size.width;
//            } else {
//                return [self getStaticWidthFromParent: view.superview];
//            }
//        }
//    } else if ( view != nil ) {
//        return view.frame.size.width;
//    }
//    return 0;
//}

@end
