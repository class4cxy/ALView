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
    if ( self = [super initWithALEngine] ) {
        self.alPosition= ALPositionRelative;
        self.alDisplay  = ALDisplayBlock;
    }
    return self;
}

@end
