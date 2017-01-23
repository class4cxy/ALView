//
//  ALLayout.m
//  ALView
//
//  Created by jdochen on 2017/1/20.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "ALLayout.h"
#import "UIView+ALEngine.h"

@implementation ALLayout

+ (void) layoutView: (UIView *) view withTop: (CGFloat) top
{
    CGRect f = view.frame;
    f.origin.y = top;
    view.frame = f;
}

+ (void) layoutView: (UIView *) view withLeft: (CGFloat) left
{
    CGRect f = view.frame;
    f.origin.x = left;
    view.frame = f;
}

+ (void) layoutView: (UIView *) view withOrigin: (CGPoint) origin
{
    CGRect f = view.frame;
    f.origin = origin;
    view.frame = f;
}

+ (void) layoutView: (UIView *) view withWidth: (CGFloat) width
{
    CGRect f = view.frame;
    f.size.width = width;
    view.frame = f;
    [view.style setWidthWithoutAutoWidth: width];
}

+ (void) layoutView: (UIView *) view withHeight: (CGFloat) height
{
    CGRect f = view.frame;
    f.size.height = height;
    view.frame = f;
    [view.style setHeightWithoutAutoHeight: height];
}

+ (void) layoutView: (UIView *) view withSize: (CGSize) size
{
    CGRect f = view.frame;
    f.size = size;
    view.frame = f;
    [view.style setWidthWithoutAutoWidth: size.width];
    [view.style setHeightWithoutAutoHeight: size.height];
}

@end
