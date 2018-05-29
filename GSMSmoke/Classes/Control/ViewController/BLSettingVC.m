//  BLSettingVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSettingVC.h"
#import "BLSettingCell.h"
#import "BLSmsAlarmVC.h"
#import "BLPhoneAlarmVC.h"
#import "BLFunctionVC.h"
#import "BLSwitchVC.h"
#import "BLAboutVC.h"
@interface BLSettingVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *titleDataArray;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end
@implementation BLSettingVC
-(NSMutableArray *)imageArray
{
    if(!_imageArray){
        _imageArray = [NSMutableArray arrayWithObjects:@"user1",@"user1",@"user1",@"user1",@"user1", nil];
    }
    return _imageArray;
}

-(NSMutableArray *)titleDataArray
{
    if(!_titleDataArray){
        _titleDataArray = [NSMutableArray arrayWithObjects:@"开关功能设置",@"内容编辑设置",@"短信号码设置",@"电话号码设置",@"关于我们", nil];
    }
    return _titleDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@",self.usermodel.username];
    [self setupTableView];
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
    [self.tableview registerNib:[UINib nibWithNibName:@"BLSettingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BLSettingCell"];
}
#pragma mark UITableViewDelegate | UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLSettingCell"];
    cell.icon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.content.text = [NSString stringWithFormat:@"%@",self.titleDataArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        BLSwitchVC *swtichvc = [[BLSwitchVC alloc]init];
        swtichvc.usermodel = self.usermodel;
        [self.navigationController pushViewController:swtichvc animated:YES];
    }
    if(indexPath.row == 1){
        BLFunctionVC *functionvc = [[BLFunctionVC alloc]init];
        functionvc.usermodel = self.usermodel;
        [self.navigationController pushViewController:functionvc animated:YES];
    }
    if(indexPath.row == 2){
        BLSmsAlarmVC *smsAlarmvc = [[BLSmsAlarmVC alloc]init];
        smsAlarmvc.usermodel = self.usermodel;
        [self.navigationController pushViewController:smsAlarmvc animated:YES];
    }
    if(indexPath.row == 3){
        BLPhoneAlarmVC *phonealarmvc = [[BLPhoneAlarmVC alloc]init];
        phonealarmvc.usermodel = self.usermodel;
        [self.navigationController pushViewController:phonealarmvc animated:YES];
    }
    if(indexPath.row == 4){
        BLAboutVC *aboutvc = [[BLAboutVC alloc]init];
        [self.navigationController pushViewController:aboutvc animated:YES];
    }
}

@end
