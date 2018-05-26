//  BLFunctionVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLFunctionVC.h"
#import "BLSettingCell.h"
@interface BLFunctionVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *imageArray;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内容功能设置";
    [self setupTableview];
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
}
@end
