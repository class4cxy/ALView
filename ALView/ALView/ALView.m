//
//  ALView.m
//  ALView
//
//  Created by jdochen on 2016/10/25.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALView.h"
#import "UIView+ALBase.h"

@implementation ALView

- (instancetype)init
{
    if ( self = [super initWithALBase] ) {
        self.position = ALPositionRelative;
        self.display  = ALDisplayBlock;
    }
    return self;
}

@end