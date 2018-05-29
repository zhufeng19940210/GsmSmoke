//  BLSwitchVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSwitchVC.h"
#import "BLSwitchCell.h"
@interface BLSwitchVC ()
<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)BLUserModel *getModel;
@property (nonatomic,strong)NSMutableArray *statusArray; ///状态的数组
@property (nonatomic,assign)int selectTag;//选择的tag
@property (nonatomic,copy) NSString *myCommand; //发送的命令
@end

@implementation BLSwitchVC
-(NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    return _statusArray;
}

-(NSMutableArray *)imageArray
{
    if(!_imageArray){
        _imageArray = [NSMutableArray arrayWithObjects:@"user1",@"user1",@"user1",@"user1",@"user1",@"user1", nil];
    }
    return _imageArray;
}

-(NSMutableArray *)titleArray
{
    if(!_titleArray){
        _titleArray = [NSMutableArray arrayWithObjects:@"继电器开关",@"警笛开关",@"电源提醒",@"短信回复",@"报警时继电器触发",@"温控报警", nil];
    }
    return _titleArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self SwitchRefesh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开关功能设置";
    [self setupTableView];
}

-(void)SwitchRefesh{
    [self.statusArray removeAllObjects];
    self.getModel = [[ZFMyDBHelper sharaDBTool]getUsermodeFromindex:self.usermodel];
    NSLog(@"jidianqi:%@",self.getModel.jidianqiStr);
    NSLog(@"siren:%@",self.getModel.sirenStr);
    NSLog(@"power:%@",self.getModel.powerStr);
    NSLog(@"sms:%@",self.getModel.smsReplaceStr);
    NSLog(@"alarmandjidianqi:%@",self.getModel.alarmWitjidianqi);
    NSLog(@"tempcontrol:%@",self.getModel.tempControl);
    [self.statusArray addObject:self.getModel.jidianqiStr];
    [self.statusArray addObject:self.getModel.sirenStr];
    [self.statusArray addObject:self.getModel.powerStr];
    [self.statusArray addObject:self.getModel.smsReplaceStr];
    [self.statusArray addObject:self.getModel.alarmWitjidianqi];
    [self.statusArray addObject:self.getModel.tempControl];
    [self.tableview reloadData];
}

#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}

-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"BLSwitchCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BLSwitchCell"];
}
#pragma mark -- UITableViewDelegate | UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLSwitchCell"];
    cell.type_icon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.type_lab.text = [NSString stringWithFormat:@"%@",self.titleArray[indexPath.row]];
    cell.myswitch.tag = (int)indexPath.row;
    NSString *tagStr = self.statusArray[indexPath.row];
    if ([tagStr isEqualToString:@"1"]) {
        //打开
        [cell.myswitch setOn:YES];
    }else{
        //关闭
        [cell.myswitch setOn:NO];
    }
    [cell.myswitch addTarget:self action:@selector(mySwitchMethod:) forControlEvents:UIControlEventValueChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark switch的方法
-(void)mySwitchMethod:(UISwitch *)mySwtich
{
    self.selectTag = (int)mySwtich.tag;
    NSString *commandPrefix = nil;
    NSString *commandStr = nil;
    NSLog(@"mySwtich:%ld",(long)mySwtich.tag);
    NSString *statusStr = self.statusArray[mySwtich.tag];
    NSLog(@"statusStr:%@",statusStr);
   
    if (mySwtich.tag == 0) {
        commandPrefix = @"75*";
    }
    if(mySwtich.tag == 1){
        commandPrefix = @"71*";
    }
    if (mySwtich.tag == 2) {
        commandPrefix = @"76*";
    }
    if (mySwtich.tag == 3){
        commandPrefix = @"72*";
    }
    if(mySwtich.tag == 4){
        commandPrefix = @"73*";
    }
    if (mySwtich.tag == 5) {
        commandPrefix = @"77*";
    }
  
    if ([statusStr isEqualToString:@"0"]) {
        self.myCommand = @"1";
        //发送1
        commandStr = [NSString stringWithFormat:@"#%@%@#",commandPrefix,@"1"];
        NSLog(@"commandStr:%@",commandStr);
        [self sendSwtichCommandWithStr:commandStr];
    }else{
        //发送0 出去了
        self.myCommand = @"0";
        commandStr = [NSString stringWithFormat:@"#%@%@#",commandPrefix,@"0"];
        NSLog(@"commandStr:%@",commandStr);
        [self sendSwtichCommandWithStr:commandStr];
    }
}
#pragma mark --发送命令的命令
-(void)sendSwtichCommandWithStr:(NSString *)commandStr
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
        [self SwitchRefesh];
        return;
        
    }else if (result == MessageComposeResultSent){
        //发送成功
        if (self.selectTag == 0) {
            //继电器开关
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd       = self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent  = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae = self.getModel.languae;
            self.usermodel.jidianqiStr = self.myCommand;
            self.usermodel.sirenStr = self.getModel.sirenStr;
            self.usermodel.powerStr = self.getModel.powerStr;
            self.usermodel.smsReplaceStr = self.getModel.smsReplaceStr;
            self.usermodel.alarmWitjidianqi = self.getModel.alarmWitjidianqi;
            self.usermodel.tempControl = self.getModel.tempControl;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.selectTag == 1) {
            //警笛开关
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd       = self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent  = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae = self.getModel.languae;
            self.usermodel.jidianqiStr = self.getModel.jidianqiStr;
            self.usermodel.sirenStr = self.myCommand;
            self.usermodel.powerStr = self.getModel.powerStr;
            self.usermodel.smsReplaceStr = self.getModel.smsReplaceStr;
            self.usermodel.alarmWitjidianqi = self.getModel.alarmWitjidianqi;
            self.usermodel.tempControl = self.getModel.tempControl;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.selectTag == 2){
            //电源提醒
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd       = self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent  = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae = self.getModel.languae;
            self.usermodel.jidianqiStr = self.getModel.jidianqiStr;
            self.usermodel.sirenStr = self.getModel.sirenStr;
            self.usermodel.powerStr = self.myCommand;
            self.usermodel.smsReplaceStr = self.getModel.smsReplaceStr;
            self.usermodel.alarmWitjidianqi = self.getModel.alarmWitjidianqi;
            self.usermodel.tempControl = self.getModel.tempControl;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.selectTag == 3) {
            //短信回复
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd       = self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent  = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae = self.getModel.languae;
            self.usermodel.jidianqiStr = self.getModel.jidianqiStr;
            self.usermodel.sirenStr = self.getModel.sirenStr;
            self.usermodel.powerStr = self.getModel.powerStr;
            self.usermodel.smsReplaceStr = self.myCommand;
            self.usermodel.alarmWitjidianqi = self.getModel.alarmWitjidianqi;
            self.usermodel.tempControl = self.getModel.tempControl;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.selectTag == 4){
            //报警时继电器触发
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd       = self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent  = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae = self.getModel.languae;
            self.usermodel.jidianqiStr = self.getModel.jidianqiStr;
            self.usermodel.sirenStr = self.getModel.sirenStr;
            self.usermodel.powerStr = self.getModel.powerStr;
            self.usermodel.smsReplaceStr = self.getModel.smsReplaceStr;
            self.usermodel.alarmWitjidianqi = self.myCommand;
            self.usermodel.tempControl = self.getModel.tempControl;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        if (self.selectTag == 5){
            //温控报警
            self.usermodel.username = self.getModel.username;
            self.usermodel.pwd       = self.getModel.pwd;
            self.usermodel.smokeAlarmContent = self.getModel.smokeAlarmContent;
            self.usermodel.tempAlarmContent  = self.getModel.tempAlarmContent;
            self.usermodel.tempNumber = self.getModel.tempNumber;
            self.usermodel.languae = self.getModel.languae;
            self.usermodel.jidianqiStr = self.getModel.jidianqiStr;
            self.usermodel.sirenStr = self.getModel.sirenStr;
            self.usermodel.powerStr = self.getModel.powerStr;
            self.usermodel.smsReplaceStr = self.getModel.smsReplaceStr;
            self.usermodel.alarmWitjidianqi = self.getModel.alarmWitjidianqi;
            self.usermodel.tempControl = self.myCommand;
            [[ZFMyDBHelper sharaDBTool]updateGsmUser:self.usermodel];
        }
        
        [self SwitchRefesh];
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        
    }else if (result == MessageComposeResultFailed){
        //发送失败
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        [self SwitchRefesh];
        return;
    }
}
@end
