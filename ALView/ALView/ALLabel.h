//
//  ALLabel.h
//  ALView
//
//  Created by jdochen on 2016/11/7.
//  Copyright © 2016年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLabel : UILabel

/*
 * padding是ALLabel特有的属性，用于撑开文字与边框的距离
 */
//@property (nonatomic, assign) CGFloat alPadding;
//@property (nonatomic, assign) CGFloat alPaddingTop;
//@property (nonatomic, assign) CGFloat alPaddingLeft;
//@property (nonatomic, assign) CGFloat alPaddingRight;
//@property (nonatomic, assign) CGFloat alPaddingBottom;

- (instancetype) init;
// ALLabel私有的重排自身内部高度
- (void) reflowWithInnerText:(UIView *) parent;

@end
