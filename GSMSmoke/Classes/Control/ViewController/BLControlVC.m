//  BLControlVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "BLControlVC.h"
#import "BLSeacrhVC.h"
#import "BLSettingVC.h"
@interface BLControlVC ()
@end
@implementation BLControlVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@",self.usermodel.username];
}
#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}
#pragma mark   布防事件
- (IBAction)actionbufangBtn:(UIButton *)sender
{

}
#pragma mark 撤防事件
- (IBAction)actionchefangBtn:(UIButton *)sender
{

}
#pragma mark 查询事件
- (IBAction)actionsearchBtn:(UIButton *)sender
{
    BLSeacrhVC *searchvc = [[BLSeacrhVC alloc]init];
    searchvc.usermodel  = self.usermodel;
    [self.navigationController pushViewController:searchvc animated:YES];
}
#pragma mark 设置事件
- (IBAction)actionsetBtn:(UIButton *)sender
{
    BLSettingVC *settingvc = [[BLSettingVC alloc]init];
    settingvc.usermodel = self.usermodel;
    [self.navigationController pushViewController:settingvc animated:YES];
}

@end
