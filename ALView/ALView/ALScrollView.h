//
//  ALScrollView.h
//  ALView
//
//  Created by jdochen on 2016/10/23.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALScrollView : UIScrollView

- (instancetype) init;
// private method
- (void) reflowContentFrame;

@end
