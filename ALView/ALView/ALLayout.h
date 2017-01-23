//
//  ALLayout.h
//  ALView
//
//  Created by jdochen on 2017/1/20.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#ifndef ALLayout_h
#define ALLayout_h

#import <UIKit/UIKit.h>

@interface ALLayout : NSObject

+ (void) layoutView: (UIView *) view withTop: (CGFloat) top;
+ (void) layoutView: (UIView *) view withLeft: (CGFloat) left;
+ (void) layoutView: (UIView *) view withOrigin: (CGPoint) origin;
+ (void) layoutView: (UIView *) view withWidth: (CGFloat) width;
+ (void) layoutView: (UIView *) view withHeight: (CGFloat) height;
+ (void) layoutView: (UIView *) view withSize: (CGSize) size;

@end

#endif /* ALLayout_h */
