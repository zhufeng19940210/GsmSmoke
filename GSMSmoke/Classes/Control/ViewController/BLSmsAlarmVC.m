//  BLSmsAlarmVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "BLSmsAlarmVC.h"

@interface BLSmsAlarmVC ()

@end

@implementation BLSmsAlarmVC

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"短信报警号码";
}

#pragma mark 返回按钮

- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}
@end
