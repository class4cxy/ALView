//
//  ALView.h
//  ALView
//
//  Created by jdochen on 2016/10/25.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALView : UIView

- (instancetype) initInline;
- (instancetype) initAbsolute;

/*
 * 类方法
 */
+ (instancetype) newBlock;
+ (instancetype) newInline;
+ (instancetype) newAbsolute;

@end
