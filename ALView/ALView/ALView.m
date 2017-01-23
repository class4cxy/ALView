//
//  ALView.m
//  ALView
//
//  Created by jdochen on 2016/10/25.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALView.h"
#import "UIView+ALEngine.h"

@implementation ALView

- (instancetype)init
{
    if ( self = [super initALEngine] ) {
        self.style.position= ALPositionRelative;
        self.style.display  = ALDisplayBlock;
    }
    return self;
}

- (instancetype) initInlineView
{
    if ( self = [super initALEngine] ) {
        self.style.display  = ALDisplayInline;
    }
    return self;
}

- (instancetype) initAbsoluteView
{
    if ( self = [super initALEngine] ) {
        self.style.position  = ALPositionAbsolute;
    }
    return self;
}

+ (instancetype) newInlineView
{
    return [[self alloc] initInlineView];
}

+ (instancetype) newAbsoluteView
{
    return [[self alloc] initAbsoluteView];
}

@end
