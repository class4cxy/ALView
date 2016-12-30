//
//  ALView.h
//  ALView
//
//  Created by jdochen on 2016/10/25.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALView : UIView

- (instancetype) init;
- (instancetype) initInlineView;
- (instancetype) initAbsoluteView;

/*
 * 类方法
 */
+ (instancetype) newInlineView;
+ (instancetype) newAbsoluteView;

@end
