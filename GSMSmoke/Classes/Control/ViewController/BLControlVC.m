//  BLControlVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLControlVC.h"
#import "BLSeacrhVC.h"
#import "BLSettingVC.h"
@interface BLControlVC ()
<MFMessageComposeViewControllerDelegate>
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
    NSLog(@"布防");
    [self sendCommandWithStr:@"#1#"];
}
#pragma mark 撤防事件
- (IBAction)actionchefangBtn:(UIButton *)sender
{
    NSLog(@"撤防");
    [self sendCommandWithStr:@"#2#"];
    
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
#pragma mark --发送命令的命令

-(void)sendCommandWithStr:(NSString *)commandStr
{
    NSLog(@"commndStr:%@",commandStr);
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageVc = [[MFMessageComposeViewController alloc]init];
        messageVc.recipients = @[self.usermodel.username];
        messageVc.messageComposeDelegate = self;
        messageVc.body = [NSString stringWithFormat:@"%@%@",self.usermodel.pwd,commandStr];
        [self presentViewController:messageVc animated:YES completion:nil];
    }else{
        [SVProgressHUD showInfoWithStatus:@"不能发送短信"];
        return;
    }
}

#pragma mark -- MFMessageComposeViewControllerDelegate代理方法

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MessageComposeResultCancelled) {
        //取消了
        [SVProgressHUD showInfoWithStatus:@"发送取消"];
        return;
        
    }else if (result == MessageComposeResultSent){
        //发送成功
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        return;
        
    }else if (result == MessageComposeResultFailed){
        //发送失败
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        return;
    }
}
@end
