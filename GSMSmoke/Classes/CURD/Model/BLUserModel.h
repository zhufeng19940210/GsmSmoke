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
///烟雾抱紧内容
@property (nonatomic,copy) NSString *smokeAlarmContent;
///温度报警内容
@property (nonatomic,copy) NSString *tempAlarmContent;
///报警温度
@property (nonatomic,copy) NSString *tempNumber;
///语言
@property (nonatomic,copy) NSString *languae;
///继电器开关
@property (nonatomic,copy) NSString *jidianqiStr;
///警笛开关
@property (nonatomic,copy) NSString *sirenStr;
///电源提醒
@property (nonatomic,copy) NSString *powerStr;
///短信回复
@property (nonatomic,copy) NSString *smsReplaceStr;
/// 报警时继电器触发
@property (nonatomic,copy) NSString *alarmWitjidianqi;
///温控报警
@property (nonatomic,copy) NSString *tempControl;

@end
