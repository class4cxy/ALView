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

- (instancetype) initInline
{
    if ( self = [super initALEngine] ) {
        self.style.display  = ALDisplayInline;
    }
    return self;
}

- (instancetype) initAbsolute
{
    if ( self = [super initALEngine] ) {
        self.style.position  = ALPositionAbsolute;
    }
    return self;
}

+ (instancetype) newBlock
{
    return [[self alloc] init];
}

+ (instancetype) newInline
{
    return [[self alloc] initInline];
}

+ (instancetype) newAbsolute
{
    return [[self alloc] initAbsolute];
}

@end
