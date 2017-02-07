//
//  TableViewCellModel.h
//  ALView
//
//  Created by 陈小雅 on 2017/2/7.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellModel : NSObject

/**头像链接*/
@property (nonatomic, strong) NSString * avatarUrl;
/**封面链接*/
@property (nonatomic, strong) NSString * coverUrl;
/**昵称*/
@property (nonatomic, strong) NSString * nick;
/**视频数量*/
@property (nonatomic, strong) NSString * count;
/**拍摄时间*/
@property (nonatomic, strong) NSString * time;

@end
