//  BLUserModel.h
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import <Foundation/Foundation.h>

@interface BLUserModel : NSObject
///id序列号
@property (nonatomic,assign)int index;
///用户名
@property (nonatomic,copy) NSString *username;
///密码
@property (nonatomic,copy) NSString *pwd;

@end
