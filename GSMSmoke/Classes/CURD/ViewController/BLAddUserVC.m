//  BLAddUserVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLAddUserVC.h"
@interface BLAddUserVC ()
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phone_tf;
@property (weak, nonatomic) IBOutlet UITextField *pwd_tf;
@end
@implementation BLAddUserVC
- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"用户信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.pwd_tf.delegate = self;
}
#pragma mark 返回按钮

- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}
#pragma mark 保存事件

- (IBAction)actionsaveBtn:(UIButton *)sender
{
    NSString *phone = self.phone_tf.text;
    NSString *pwd   = self.pwd_tf.text;
    if(phone.length == 0 || [phone isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请设置报警电话"];
        return;
    }
    if(pwd.length == 0 || [pwd isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请设置密码"];
        return;
    }
    //这里要加一个限制密码为6位
}
@end
