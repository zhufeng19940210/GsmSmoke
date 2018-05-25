//  BLSettingVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSettingVC.h"
@interface BLSettingVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
@implementation BLSettingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@",self.usermodel.username];
}
#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}
@end
