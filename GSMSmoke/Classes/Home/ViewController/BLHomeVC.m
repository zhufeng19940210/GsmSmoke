//  BLHomeVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLHomeVC.h"
#import "BLHomeCell.h"
#import "BLAddUserVC.h"
#import "BLControlVC.h"
@interface BLHomeVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
@implementation BLHomeVC
#pragma makr lazy method
-(NSMutableArray *)dataArray
{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(200, 200, 200);
    self.title = @"用户选择";
    [self setupNavigaBar];
    [self setupTableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
#pragma mark 刷新界面
-(void)HomeRefresh
{
    [self.tableview reloadData];
}

#pragma mark 获取全部的列表
-(void)getAllUserData
{
    [self.dataArray removeAllObjects];
}

-(void)setupNavigaBar
{
    [self setRightButtonWithImage:[UIImage imageNamed:@"icon_add"]];
}

#pragma mark 点击事件

- (void)navigationBarRightButtonEvent:(UIButton *)sender
{
    BLAddUserVC *editAddvc = [[BLAddUserVC alloc]init];
    [self.navigationController pushViewController:editAddvc animated:YES];
}
#pragma mark seutptableview
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"BLHomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BLHomeCell"];
}
#pragma mark UITableViewDelegate | UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;  //test data
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLHomeCell"];
    cell.phone_lab.text = @"13751102746";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
//编辑的方式了
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//编辑点击的方式了
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) WeakSelf = self;
    //编辑事件
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [WeakSelf PushEditUserWithIndex:(int)indexPath.section];
    }];
    editRowAction.backgroundColor = [UIColor lightGrayColor];
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        //取消按钮
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        //确定按钮
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"删除东西");
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [WeakSelf presentViewController:alertController animated:YES completion:nil];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    return @[deleteRowAction,editRowAction];
}

#pragma mark 编辑事件

-(void)PushEditUserWithIndex:(int)index{
    BLAddUserVC *editAddvc = [[BLAddUserVC alloc]init];
    [self.navigationController pushViewController:editAddvc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //BLUserModel *usermodel = self.dataArray[indexPath.section];
    BLControlVC *controlvc = [[BLControlVC alloc]init];
    //controlvc.usermodel = usermodel;
    [self.navigationController pushViewController:controlvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
