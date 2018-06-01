//  ZFMyDBHelper.m
//  BL6600
//  Created by bailing on 2017/9/4.
//  Copyright © 2017年 bailing. All rights reserved.
#import "ZFMyDBHelper.h"
#import "FMDatabase.h"
static ZFMyDBHelper *instance = nil;
@interface ZFMyDBHelper ()
@property (strong,nonatomic)FMDatabase *db;
@end
@implementation ZFMyDBHelper
+(instancetype)sharaDBTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZFMyDBHelper alloc]init];
    });
    return  instance;
}
- (void)createDataBase{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"BLSmoke.sqlite"];
    // 2.得到数据库
    FMDatabase *db = [FMDatabase databaseWithPath:filename];
    // 3.打开数据库
    if ([db open]) {
        // 4.创表
        BOOL result = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_users (id integer PRIMARY KEY AUTOINCREMENT, username text NOT NULL, pwd text NOT NULL, smokealarm text NOT NULL,tempalarm text NOT NULL,tmepnumber text NOT NULL,laguage text NOT NULL,relay text NOT NULL,siren text NOT NULL,power text NOT NULL,sms text NOT NULL,relay_alarm text NOT NULL,temp_control text NOT NULL);"];
        if (result) {
            NSLog(@"创建t_users成功");
        }else{
            NSLog(@"创建t_users失败");
        }
    }
    self.db = db;
}
-(void)insertGsmUser:(BLUserModel *)model{
    [self.db executeUpdate:@"INSERT INTO t_users (username,pwd,smokealarm,tempalarm,tmepnumber,laguage,relay,siren,power,sms,relay_alarm,temp_control) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);",model.username,model.pwd,model.smokeAlarmContent,model.tempAlarmContent,model.tempNumber,model.languae,model.jidianqiStr,model.sirenStr,model.powerStr,model.smsReplaceStr,model.alarmWitjidianqi,model.tempControl];
}

-(void)updateGsmUser:(BLUserModel *)device{
  [self.db executeUpdate:@"update t_users set username = ?,pwd = ?,smokealarm = ?,tempalarm = ?,tmepnumber = ?,laguage = ?, relay = ?,siren = ?, power = ?,sms = ?,relay_alarm = ?,temp_control = ? where id = ?",device.username,device.pwd,device.smokeAlarmContent,device.tempAlarmContent,device.tempNumber,device.languae,device.jidianqiStr,device.sirenStr,device.powerStr,device.smsReplaceStr,device.alarmWitjidianqi,device.tempControl, @(device.index)];
}

-(void)deleteGsmUser:(BLUserModel *)userModel{
    NSLog(@"usermoel.name:%@",userModel.username);
    NSLog(@"id:%@",@(userModel.index));
    [self.db executeUpdate:@"DELETE FROM t_users WHERE id = ?;",@(userModel.index)];
}

-(BOOL)isExistingUserName:(BLUserModel *)userModel{
    NSArray *array = [self queryAllUser];
    BOOL ishave = NO;
    for (BLUserModel *dev in array) {
        if ([userModel.username isEqualToString:dev.username]) {
            ishave = YES;
            break;
        }
    }
    return ishave;
}
- (NSMutableArray *)queryAllUser{
    NSMutableArray *arrayM = [NSMutableArray array];
    FMResultSet *resultset = [self.db executeQuery:@"SELECT * FROM t_users"];
    while ([resultset next]) {
        BLUserModel *model = [[BLUserModel alloc]init];
        model.index  = [resultset intForColumn:@"id"];
        model.username = [resultset stringForColumn:@"username"];
        model.pwd = [resultset stringForColumn:@"pwd"];
        model.smokeAlarmContent = [resultset stringForColumn:@"smokealarm"];
        model.tempAlarmContent = [resultset stringForColumn:@"tempalarm"];
        model.tempNumber = [resultset stringForColumn:@"tmepnumber"];
        model.languae  = [resultset stringForColumn:@"laguage"];
        model.jidianqiStr = [resultset stringForColumn:@"relay"];
        model.sirenStr = [resultset stringForColumn:@"siren"];
        model.powerStr = [resultset stringForColumn:@"power"];
        model.smsReplaceStr = [resultset stringForColumn:@"sms"];
        model.alarmWitjidianqi = [resultset stringForColumn:@"relay_alarm"];
        model.tempControl = [resultset stringForColumn:@"temp_control"];
        [arrayM addObject:model];
    }
    return arrayM;
}
/*
 *  获取某个对象
 */
-(BLUserModel *)getUsermodeFromindex:(BLUserModel *)usermodel{
    FMResultSet *rs=  [self.db executeQuery:@"select * from t_users WHERE id = ?;",@(usermodel.index)];
    BLUserModel  *usermodel2 = [[BLUserModel alloc]init];
    while([rs next]) {
        usermodel2.index = [rs intForColumn:@"id"];
        usermodel2.username = [rs stringForColumn:@"username"];
        usermodel2.pwd = [rs stringForColumn:@"pwd"];
        usermodel2.smokeAlarmContent = [rs stringForColumn:@"smokealarm"];
        usermodel2.tempAlarmContent = [rs stringForColumn:@"tempalarm"];
        usermodel2.tempNumber = [rs stringForColumn:@"tmepnumber"];
        usermodel2.languae = [rs stringForColumn:@"laguage"];
        usermodel2.jidianqiStr = [rs stringForColumn:@"relay"];
        usermodel2.sirenStr = [rs stringForColumn:@"siren"];
        usermodel2.powerStr = [rs stringForColumn:@"power"];
        usermodel2.smsReplaceStr = [rs stringForColumn:@"sms"];
        usermodel2.alarmWitjidianqi = [rs stringForColumn:@"relay_alarm"];
        usermodel2.tempControl = [rs  stringForColumn:@"temp_control"];
    }
    [rs close];
    return  usermodel2;
}

@end
