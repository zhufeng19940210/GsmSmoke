//  AppDelegate.m
//  GSMSmoke
//  Created by bailing on 2018/5/23.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "AppDelegate.h"
#import "BLHomeVC.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    ///初始化三方库
    [self thirdInitialization];
    return YES;
}
#pragma mark 三方库的初始化
-(void)thirdInitialization
{   //这里设置下样式
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    //设置背景颜色
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    //设置前景色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    //显示的时间
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];//显示的时间
    //键盘的显示
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    //初始化数据
    [[ZFMyDBHelper sharaDBTool]createDataBase];
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
 
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
