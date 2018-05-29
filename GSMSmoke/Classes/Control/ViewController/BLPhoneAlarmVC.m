//  BLPhoneAlarmVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLPhoneAlarmVC.h"
@interface BLPhoneAlarmVC ()
<MFMessageComposeViewControllerDelegate>
///电话号码
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
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
#pragma mark 添加手机号码
- (IBAction)acitonAddBtn:(UIButton *)sender
{
    NSString *phone = self.phone_tf.text;
    if (phone.length == 0 || [phone isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入电话号码"];
        return;
    }
    int tag = (int)sender.tag;
    NSString *commandStr = [NSString stringWithFormat:@"#%d*%@#",tag,phone];
    NSLog(@"commandStr:%@",commandStr);
    [self sendPhoneCommandWithStr:commandStr];
}
#pragma mark 删除手机号码
- (IBAction)actionDeleteBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    NSString *commandStr = [NSString stringWithFormat:@"#%d#",tag];
    [self sendPhoneCommandWithStr:commandStr];
}
#pragma mark --发送命令的命令
-(void)sendPhoneCommandWithStr:(NSString *)commandStr
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
