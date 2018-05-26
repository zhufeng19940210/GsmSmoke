//  BLAboutVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "BLAboutVC.h"

@interface BLAboutVC ()

@end

@implementation BLAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
}

#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}

@end
