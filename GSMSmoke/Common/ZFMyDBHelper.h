//  ZFMyDBHelper.h
//  BL6600
//  Created by bailing on 2017/9/4.
//  Copyright © 2017年 bailing. All rights reserved.
#import <Foundation/Foundation.h>
@class BLUserModel;
@interface ZFMyDBHelper : NSObject
+ (instancetype)sharaDBTool;
- (void)createDataBase;
- (void)insertGsmUser:(BLUserModel *)userModel;
- (void)updateGsmUser:(BLUserModel *)userModel;
- (void)deleteGsmUser:(BLUserModel *)userModel;
- (NSMutableArray *)queryAllUser;
-(BOOL)isExistingUserName:(BLUserModel *)userModel;
-(BLUserModel *)getUsermodeFromindex:(BLUserModel *)userModel;
@end
