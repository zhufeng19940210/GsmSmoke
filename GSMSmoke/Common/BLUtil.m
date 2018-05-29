//  BLUtil.m
//  GSMSmoke
//
//  Created by bailing on 2018/5/28.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import "BLUtil.h"
static BLUtil *util = nil;
@implementation BLUtil
+(instancetype)ShareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[BLUtil alloc]init];
    });
    return util;
}
-(NSString *)getCurrentSysWithLaguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"当前使用的语言是: %@", preferredLang);
    return preferredLang;
}
@end
