//  BLFunctionVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLFunctionVC.h"
#import "BLSettingCell.h"
#import "LZPickerView.h"
#import "ZFPickerView.h"
@interface BLFunctionVC ()
<UITableViewDelegate,
UITableViewDataSource,
MFMessageComposeViewControllerDelegate,
UITextFieldDelegate,
ZFPicketViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)UITextField *pwd_tf;   /// 密码限制的长度
@property (nonatomic,strong)UITextField *smoke_tf; /// 烟雾限制的长度
@property (nonatomic,strong)UITextField *temp_tf;  /// 温度限制的长度
@property (nonatomic,strong)BLUserModel *getModel;
@property (nonatomic,assign)BOOL isUpdatePwd;     ///是否是更新密码
@property (nonatomic,assign)BOOL isSmoke;         ///是否是烟雾
@property (nonatomic,assign)BOOL isTemp;          ///是否设置温度
@property (nonatomic,assign)BOOL isSetTemp;       ///设置温度
@property (nonatomic,assign)BOOL isSetLaguage;    ///设置语言
@property (nonatomic,strong)LZPickerView *lzPickerVIew;
@property (nonatomic,strong)NSString *tempStr;     ///温度str
@property (nonatomic,strong)NSString *languageStr; ///语言str
@end

@implementation BLFunctionVC
-(NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [NSMutableArray arrayWithObjects:@"设置密码",@"烟雾报警短信内容",@"温度报警短信内容",@"报警温度",@"系统时间",@"选择语言",@"系统复位", nil];
    }
    return _dataArray;
}
-(NSMutableArray *)imageArray
{
    if(!_imageArray){
        _imageArray = [NSMutableArray arrayWithObjects:@"user1",@"user1",@"user1",@"user1",@"user1",@"user1",@"user1", nil];
    }
    return _imageArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self myReresh];
}
-(void)myReresh{
    self.getModel = [[ZFMyDBHelper sharaDBTool]getUsermodeFromindex:self.usermodel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容功能设置";
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"LZPickerView" owner:nil options:nil];
    self.lzPickerVIew  = views[0];
    [self setupTableview];
}
#pragma mark 限制密码长度的输入
-(void)pwdtextFieldDidChange:(UITextField *)textField
{
    if (textField == self.pwd_tf) {
        if (textField.text.length > 6) {
            [SVProgressHUD showInfoWithStatus:@"密码长度为6位"];
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
#pragma mark 限制烟雾报警内容的设置
- (void)smoketextFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    NSString *currentLanuage = [[BLUtil ShareTool]getCurrentSysWithLaguage];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if ([currentLanuage isEqualToString:@"zh-Hans-CN"]) {
        
        if (!position) {
            if (toBeString.length >=17) {
                textField.text = [toBeString substringToIndex:16];
                [SVProgressHUD showInfoWithStatus:@"报警内容不能超过16个字符"];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    
        NSLog(@"input:%@",textField.text);
        
    }else{
        //英文限定字数的东西
        if (!position) {
            if (toBeString.length >=33) {
                textField.text = [toBeString substringToIndex:32];
                [SVProgressHUD showInfoWithStatus:@"报警内容不能超过32个字符"];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
        
        NSLog(@"input:%@",textField.text);
    }
}
#pragma mark 限制温度报警短信内容设置
-(void)temptextFieldDidChange:(UITextField *)textField
{
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    NSString *currentLanuage = [[BLUtil ShareTool]getCurrentSysWithLaguage];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if ([currentLanuage isEqualToString:@"zh-Hans-CN"]) {
        
        if (!position) {
            if (toBeString.length >=17) {
                textField.text = [toBeString substringToIndex:16];
                [SVProgressHUD showInfoWithStatus:@"报警内容不能超过16个字符"];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
        NSLog(@"input:%@",textField.text);
        
    }else{
        //英文限定字数的东西
        if (!position) {
            if (toBeString.length >=33) {
                textField.text = [toBeString substringToIndex:32];
                [SVProgressHUD showInfoWithStatus:@"报警内容不能超过32个字符"];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
        
        NSLog(@"input:%@",textField.text);
    }
}

#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}
-(void)setupTableview
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"BLSettingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BLSettingCell"];
}
#pragma mark -- UITableViewDelegate | UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLSettingCell"];
    cell.icon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.content.text = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //设置新密码
        [self setupNewPwdMethod];
    }
    if (indexPath.row == 1) {
        //烟雾报警短信内容
        [self smokeAlarmContentMethod];
    }
    if (indexPath.row == 2) {
        //温度报警短信内容
        [self tmepAlarmContentMethod];
    }
    if (indexPath.row == 3) {
        //报警温度
        [self setupTempNumberMethod];
    }
    if (indexPath.row == 4) {
        //系统时间
        [self setupSysTimeMethod];
    }
    if (indexPath.row == 5) {
        //选择语言
        [self setupLanguageMethod];
    }
    if (indexPath.row == 6) {
        //系统复位
        [self setupReSetMethod];
    }
}

#pragma mark -- 设置新密码
- (void)setupNewPwdMethod
{
    UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"设置密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        self.pwd_tf.keyboardType =  UIKeyboardTypeNumberPad;
        self.pwd_tf = textField;
        self.pwd_tf.placeholder = self.getModel.pwd;
        self.pwd_tf.delegate = self;
        [self.pwd_tf addTarget:self action:@selector(pwdtextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    //确定按钮
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *tf_username = alert2.textFields.firstObject;
        if (tf_username.text.length == 0 || [tf_username.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"密码长度不能为空"];
            return;
        }
        if (tf_username.text.length != 6) {
            [SVProgressHUD showInfoWithStatus:@"密码长度为6位"];
            return;
        }
        //开始去调用方法
        self.isUpdatePwd = YES;
        NSString *commandStr = [NSString stringWithFormat:@"#31*%@#",self.pwd_tf.text];
        NSLog(@"commandStr:%@",commandStr);
        [self sendFunctionCommandWithStr:commandStr];
    }];
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert2 addAction:sureAction];
    [alert2 addAction:cancelAction];
    [self presentViewController:alert2 animated:YES completion:^{
    }];
}
#pragma mark -- 烟雾报警短信内容
-(void)smokeAlarmContentMethod
{
    UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"烟雾报警短信内容" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        self.smoke_tf = textField;
        self.smoke_tf.placeholder = self.getModel.smokeAlarmContent;
        self.smoke_tf.delegate = self;
        [self.smoke_tf addTarget:self action:@selector(smoketextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    //确定按钮
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *smoke_content= alert2.textFields.firstObject;
        if (smoke_content.text.length == 0 || [smoke_content.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"烟雾报警内容不能为空"];
            return;
        }
        //开始去调用方法
        self.isSmoke = YES;
        NSString *commandStr = [NSString stringWithFormat:@"#40*%@#",self.smoke_tf.text];
        NSLog(@"commandStr:%@",commandStr);
        [self sendFunctionCommandWithStr:commandStr];
    }];
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert2 addAction:sureAction];
    [alert2 addAction:cancelAction];
    [self presentViewController:alert2 animated:YES completion:^{
    }];
    
}
#pragma mark -- 温度报警短信内容
-(void)tmepAlarmContentMethod
{
    UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:@"温度报警短信内容" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert2 addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        self.temp_tf = textField;
        self.temp_tf.placeholder = self.getModel.tempAlarmContent;
        self.temp_tf.delegate = self;
        [self.temp_tf addTarget:self action:@selector(temptextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    //确定按钮
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *temp_content = alert2.textFields.firstObject;
        if (temp_content.text.length == 0 || [temp_content.text isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"温度报警内容不能为空"];
            return;
        }
        self.isTemp = YES;
        NSString *commandStr = [NSString stringWithFormat:@"#41*%@#",self.temp_tf.text];
        NSLog(@"commnadStr:%@",commandStr);
        [self sendFunctionCommandWithStr:commandStr];
    }];
    //取消按钮
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert2 addAction:sureAction];
    [alert2 addAction:cancelAction];
    [self presentViewController:alert2 animated:YES completion:^{
    }];
}
#pragma mark -- 报警温度
-(void)setupTempNumberMethod
{    NSMutableArray *array = [NSMutableArray array];
    for (int i = 50; i<=70; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    NSLog(@"self.lanuage:%@",self.getModel.tempNumber);
    [self.lzPickerVIew lzPickerVIewType:LZPickerViewTypeSexAndHeight];
    self.lzPickerVIew.dataSource = array;
    self.lzPickerVIew.titleText = @"请设置报警温度";
    self.lzPickerVIew.selectDefault = self.getModel.tempNumber;
    self.lzPickerVIew.selectValue  = ^(NSString *value){
        self.isSetTemp = YES;
        self.tempStr = value;
        NSString *commandStr = [NSString stringWithFormat:@"#78*%@#",value];
        NSLog(@"commandStr:%@",commandStr);
        [self sendFunctionCommandWithStr:commandStr];
    };
    [self.lzPickerVIew show];
}
#pragma mark -- 系统时间
-(void)setupSysTimeMethod
{
    ZFPickerView *pickView = [[ZFPickerView alloc]initWithDelegate:self];
    [pickView show];
}
#pragma mark ZFPicketViewDelegate
- (void)ZFPickerView:(ZFPickerView *)pickerView didSelectYear:(NSInteger )year Month:(NSInteger )month Day:(NSInteger )day Hour:(NSInteger )hour Minute:(NSInteger )minute{
    NSLog(@"year:%ld,month:%ld,day:%ld,hour:%ld,minute:%ld",(long)year,(long)month,(long)day,(long)hour,(long)minute);
    NSString *yearStr = [NSString stringWithFormat:@"%ld",(long)year];
    NSString *subYear = [yearStr substringFromIndex:2];
    NSLog(@"subYear:%@",subYear);
    NSString *commandStr = [NSString stringWithFormat:@"#%@%02ld%02ld%02ld%02ld#",subYear,(long)month,day,(long)hour,(long)minute];
    NSLog(@"commandStr:%@",commandStr);
    [self sendFunctionCommandWithStr:commandStr];
}
#pragma mark -- 选择语言
-(void)setupLanguageMethod
{
    NSLog(@"self.lanuage:%@",self.getModel.languae);
    [self.lzPickerVIew lzPickerVIewType:LZPickerViewTypeSexAndHeight];
    self.lzPickerVIew.dataSource =@[@"中文",@"英文"];
    self.lzPickerVIew.titleText = @"请选择语言";
    self.lzPickerVIew.selectDefault = self.getModel.languae;
    self.lzPickerVIew.selectValue  = ^(NSString *value){
        self.isSetLaguage = YES;
        self.languageStr = value;
        NSLog(@"value:%@",value);
        NSString *commandTag = nil;
        if ([value isEqualToString:@"中文"]) {
            commandTag = @"1";
        }else{
            commandTag = @"0";
        }
        NSString *commandStr = [NSString stringWithFormat:@"#80*%@#",commandTag];
        NSLog(@"commandStr:%@",commandStr);
        [self sendFunctionCommandWithStr:commandStr];
    };
    [self.lzPickerVIew show];
}
#pragma mark -- 系统复位
-(void)setupReSetMethod
{
    [self sendFunctionCommandWithStr:@"#075525911778#"];
}
#pragma mark --发送命令的命令
-(void)sendFunctionCommandWithStr:(NSString *)commandStr
{
    NSLog(@"commndStr:%@",commandStr);
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *messageVc = [[MFMessageComposeViewController alloc]init];
        messageVc.recipients = @[self.getModel.username];
        messageVc.messageComposeDelegate = self;
        messageVc.body = [NSString stringWithFormat:@"%@%@",self.getModel.pwd,commandStr];
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
        [self cancelAllMethod];
        return;
        
    }else if (result == MessageComposeResultSent){
        //发送成功
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        if (self.isUpdatePwd ) {
            self.isUpdatePwd = NO;
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd =  self.pwd_tf.text;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae    = self.getModel.languae;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
   
        }
        if (self.isSmoke) {
            self.isSmoke = NO;
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd =  self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.smoke_tf.text;
            self.usermodel.tempAlarmContent = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae    = self.getModel.languae;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.isTemp) {
            self.isTemp = NO;
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd =  self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent = self.temp_tf.text;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae    = self.getModel.languae;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
            
        }
        if(self.isSetTemp){
            self.isSetTemp = NO;
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd =  self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.tempStr;
            self.usermodel.languae    = self.getModel.languae;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.isSetLaguage) {
            self.isSetLaguage = NO;
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd =  self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae    = self.languageStr;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        [self myReresh];
        
    }else if (result == MessageComposeResultFailed){
        //发送失败
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        [self cancelAllMethod];
        return;
    }
}
#pragma mark -- cancelAllMethod
-(void)cancelAllMethod
{   self.isUpdatePwd = NO;
    self.isSmoke = NO;
    self.isTemp = NO;
    self.isSetTemp = NO;
    self.isSetLaguage = NO;
}
@end
