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
    if(self.isEdit){
        self.phone_tf.text  = self.usermodel.username;
    }else{
        //添加的状态了
    }
    self.pwd_tf.delegate = self;
    [self.pwd_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}

#pragma mark  限制字数

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.pwd_tf) {
        if (textField.text.length > 6) {
            UITextRange *markedRange = [textField markedTextRange];
            if (markedRange) {
                return;
            }
            //Emoji占2个字符，如果是超出了半个Emoji，用15位置来截取会出现Emoji截为2半
            //超出最大长度的那个字符序列(Emoji算一个字符序列)的range
            NSRange range = [textField.text rangeOfComposedCharacterSequenceAtIndex:6];
            textField.text = [textField.text substringToIndex:range.location];
        }
    }
}
#pragma mark 保存事件
- (IBAction)actionsaveBtn:(UIButton *)sender
{
    [self.phone_tf resignFirstResponder];
    [self.pwd_tf resignFirstResponder];
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
    if(pwd.length != 6 ){
        [SVProgressHUD showInfoWithStatus:@"密码长度为6位"];
        return;
    }
    if (self.isEdit){
        //编辑的状态
        self.usermodel.username = phone;
        self.usermodel.pwd = pwd;
        //编辑东西了
        [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        [SVProgressHUD showSuccessWithStatus:@"编辑成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //添加的
        BLUserModel *usermodel = [[BLUserModel alloc]init];
        usermodel.username = phone;
        usermodel.pwd = pwd;
        usermodel.smokeAlarmContent = @"烟雾报警";
        usermodel.tempAlarmContent  = @"温度报警";
        usermodel.tempNumber = @"57";
        usermodel.languae = @"中文";
        [[ZFMyDBHelper sharaDBTool]insertGsmUser:usermodel];
        [SVProgressHUD showSuccessWithStatus:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
