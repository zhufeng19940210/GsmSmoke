//  BLSwitchVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLSwitchVC.h"
#import "BLSwitchCell.h"
@interface BLSwitchVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end

@implementation BLSwitchVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开关功能设置";
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
