//
//  UserInfoModel.h
//  ALView
//
//  Created by 陈小雅 on 2017/2/14.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoModel : NSObject

@property(nonatomic, copy) NSString *avatarUrl;
@property(nonatomic, copy) NSString *nick;
@property(nonatomic, copy) NSString *distance;
@property(nonatomic, assign) NSInteger sex;
@property(nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString* charmLevelTag;
@property (nonatomic, copy) NSString* professionTag;
@property (nonatomic, copy) NSString* interest;
@property (nonatomic, copy) NSString* richStateText;
@property (nonatomic, copy) NSString* commonLabel;

@end
