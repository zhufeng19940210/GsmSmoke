//  BLSeacrhVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSeacrhVC.h"
#import "BLSeachCell.h"
@interface BLSeacrhVC ()
<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end
@implementation BLSeacrhVC
-(NSMutableArray *)imageArray
{
    if(!_imageArray){
        _imageArray = [NSMutableArray arrayWithObjects:@"user1",@"user1",@"user1",@"user1",@"user1",@"user1",@"user1", nil];
    }
    return _imageArray;
}
-(NSMutableArray *)titleArray
{
    if(!_titleArray){
        _titleArray = [NSMutableArray arrayWithObjects:@"查询系统状态",@"查询系统时间",@"查询GSM信号",@"查询当前温度",@"查询报警记录",@"查询短信号码",@"查询报警号码", nil];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统查询";
    [self setupTableView];
}
#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}
#pragma mark -- setuptableview
-(void)setupTableView
{
    self.tableview.delegate  = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"BLSeachCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BLSeachCell"];
}
#pragma mark UITableViewDelegate | UITableViewDataSource
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else{
        return 0.5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  CGFLOAT_MIN;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLSeachCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLSeachCell"];
    cell.type_icon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.type_lab.text = [NSString stringWithFormat:@"%@",self.titleArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        NSLog(@"系统状态");
        [self sendSearchCommandWithStr:@"#30#"];
    }
    if(indexPath.row == 1){
        NSLog(@"系统时间");
        [self sendSearchCommandWithStr:@"#74#"];
    }
    if(indexPath.row == 2){
        NSLog(@"gsm信号");
        [self sendSearchCommandWithStr:@"#33#"];
    }
    if(indexPath.row == 3){
        NSLog(@"当前温度");
        [self sendSearchCommandWithStr:@"#79#"];
    }
    if(indexPath.row == 4){
        NSLog(@"报警记录");
        [self sendSearchCommandWithStr:@"#32#"];
        
    }if(indexPath.row == 5){
        NSLog(@"查询短信号码");
        [self sendSearchCommandWithStr:@"#35#"];
    }if (indexPath.row == 6){
        NSLog(@"查询电话号码");
        [self sendSearchCommandWithStr:@"#36#"];
    }
}
#pragma mark --发送命令的命令
-(void)sendSearchCommandWithStr:(NSString *)commandStr
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
