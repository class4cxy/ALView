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
- (instancetype) initAbsolute;
// 类方法，简便调用
+ (instancetype) newAbsolute;

// 排版size
- (void) layoutSize;
@end
