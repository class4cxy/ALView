//
//  ALLabel.m
//  ALView
//
//  Created by jdochen on 2016/11/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import "ALLabel.h"
#import "UIView+ALBase.h"

@implementation ALLabel

- (instancetype) init
{
    if ( self = [super initWithALBase] ) {
        self.display  = ALDisplayInline;
    }
    return self;
}

#pragma mark - 重载父类方法
// ALLabel的排版方式默认为inline类型，不允许修改
- (void)setDisplay:(ALDisplay)display
{
    [super setDisplay: ALDisplayInline];
}

@end
