//  BLSeacrhVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSeacrhVC.h"
#import "BLSeachCell.h"
@interface BLSeacrhVC ()
<UITableViewDelegate,UITableViewDataSource >
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end
@implementation BLSeacrhVC
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
        _titleArray = [NSMutableArray arrayWithObjects:@"查询系统状态",@"查询系统时间",@"查询GSM信号",@"查询当前温度",@"查询报警记录",@"查询电话号码", nil];
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
    return self.titleArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    cell.type_icon.image = [UIImage imageNamed:self.imageArray[indexPath.section]];
    cell.type_lab.text = [NSString stringWithFormat:@"%@",self.titleArray[indexPath.section]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        NSLog(@"系统状态");
    }
    if(indexPath.section == 1){
        NSLog(@"系统时间");
    }
    if(indexPath.section == 2){
        NSLog(@"gsm信号");
    }
    if(indexPath.section == 3){
        NSLog(@"当前温度");
    }
    if(indexPath.section == 4){
        NSLog(@"报警记录");
        
    }if(indexPath.section == 5){
        NSLog(@"电话信号");
    }
}
@end
