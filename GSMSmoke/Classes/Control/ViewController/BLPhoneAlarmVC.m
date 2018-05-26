//  BLPhoneAlarmVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "BLPhoneAlarmVC.h"

@interface BLPhoneAlarmVC ()

@end

@implementation BLPhoneAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报警电话设置";
}
#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}

@end
