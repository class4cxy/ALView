//
//  UIView+ALBase.m
//  ALView
//
//  Created by jdochen on 2016/10/24.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "UIView+ALBase.h"
#import <objc/runtime.h>

@implementation UIView (ALBase)

#pragma mark - dynamic property
@dynamic position;
- (ALPosition) position
{
    return (ALPosition)[objc_getAssociatedObject(self, @"position") intValue];
}
-(void)setPosition:(ALPosition)position
{
    objc_setAssociatedObject(self, @"position", [NSNumber numberWithInt:position], OBJC_ASSOCIATION_RETAIN);
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
    objc_setAssociatedObject(self, @"width", [NSNumber numberWithFloat:width], OBJC_ASSOCIATION_RETAIN);
}

@dynamic height;
- (CGFloat) height
{
    return [objc_getAssociatedObject(self, @"height") floatValue];
}
-(void)setHeight:(CGFloat)height
{
    objc_setAssociatedObject(self, @"height", [NSNumber numberWithFloat:height], OBJC_ASSOCIATION_RETAIN);
}


@dynamic top;
- (CGFloat) top
{
    return [objc_getAssociatedObject(self, @"top") floatValue];
}
-(void)setTop:(CGFloat)top
{
    objc_setAssociatedObject(self, @"top", [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN);
}

@dynamic bottom;
- (CGFloat) bottom
{
    return [objc_getAssociatedObject(self, @"bottom") floatValue];
}
-(void)setBottom:(CGFloat)bottom
{
    objc_setAssociatedObject(self, @"bottom", [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN);
}

@dynamic left;
- (CGFloat) left
{
    return [objc_getAssociatedObject(self, @"left") floatValue];
}
-(void)setLeft:(CGFloat)left
{
    objc_setAssociatedObject(self, @"left", [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN);
}

@dynamic right;
- (CGFloat) right
{
    return [objc_getAssociatedObject(self, @"right") floatValue];
}
-(void)setRight:(CGFloat)right
{
    objc_setAssociatedObject(self, @"right", [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN);
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

@dynamic isAutoHeight;
- (BOOL) isAutoHeight
{
    return [objc_getAssociatedObject(self, @"isAutoHeight") boolValue];
}
- (void) setIsAutoHeight:(BOOL)isAutoHeight
{
    objc_setAssociatedObject(self, @"isAutoHeight", [NSNumber numberWithBool:isAutoHeight], OBJC_ASSOCIATION_RETAIN);
}


@dynamic isFullWidth;
- (BOOL) isFullWidth
{
    return [objc_getAssociatedObject(self, @"isFullWidth") boolValue];
}
- (void) setIsFullWidth:(BOOL)isFullWidth
{
    objc_setAssociatedObject(self, @"isFullWidth", [NSNumber numberWithBool:isFullWidth], OBJC_ASSOCIATION_RETAIN);
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

@end
