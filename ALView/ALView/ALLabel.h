//
//  ALLabel.h
//  ALView
//
//  Created by jdochen on 2016/11/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLabel : UILabel

- (instancetype) init;
- (instancetype) initWithAbsolute;
// ALLabel私有的重排自身内部高度
- (void) reflowWithInnerText:(UIView *) parent;

// 类方法，简便调用
+ (instancetype) newWithAbsolute;

@end
