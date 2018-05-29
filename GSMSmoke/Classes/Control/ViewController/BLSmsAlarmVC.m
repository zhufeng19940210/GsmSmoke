//  BLSmsAlarmVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSmsAlarmVC.h"
@interface BLSmsAlarmVC ()
<MFMessageComposeViewControllerDelegate>
///电话号码
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
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
#pragma mark 添加号码事件
- (IBAction)actionAddBtn:(UIButton *)sender
{
    NSString *smsphone = self.phone_tf.text;
    if (smsphone.length == 0 || [smsphone isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请先输入短信号码"];
        return;
    }
    int tag = (int)sender.tag;
    NSString *commandStr = [NSString stringWithFormat:@"#%d*%@#",tag,smsphone];
    NSLog(@"commandStr:%@",commandStr);
    [self sendSmsCommandWithStr:commandStr];
}
#pragma mark 删除号码事件
- (IBAction)actionDeleteBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    NSString *commandStr = [NSString stringWithFormat:@"#%d#",tag];
    NSLog(@"commandStr:%@",commandStr);
    [self sendSmsCommandWithStr:commandStr];
}
#pragma mark --发送命令的命令
-(void)sendSmsCommandWithStr:(NSString *)commandStr
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
