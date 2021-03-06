//  BLHomeVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLHomeVC.h"
#import "BLHomeCell.h"
#import "BLAddUserVC.h"
#import "BLControlVC.h"
@interface BLHomeVC ()
<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"用户选择";
    [self setupNavigaBar];
    [self setupTableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HomeRefresh];
}
#pragma mark 刷新界面
-(void)HomeRefresh
{
    [self getAllUserData];
    [self.tableview reloadData];
}

#pragma mark 获取全部的列表
-(void)getAllUserData
{
    [self.dataArray removeAllObjects];
    self.dataArray = [[ZFMyDBHelper sharaDBTool]queryAllUser];
    NSLog(@"数量:%lu",(unsigned long)self.dataArray.count);
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
    self.tableview.emptyDataSetSource = self;
    self.tableview.emptyDataSetDelegate = self;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor =  [UIColor clearColor];
    //注册cell
    [self.tableview registerNib:[UINib nibWithNibName:@"BLHomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BLHomeCell"];
}
#pragma mark UITableViewDelegate | UITableViewDataSource
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
    return 70;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLUserModel *usermodel = self.dataArray[indexPath.row];
    BLHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLHomeCell"];
    cell.phone_lab.text = usermodel.username;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//编辑的方式了
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//编辑点击的方式了
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) WeakSelf = self;
    BLUserModel *usermodel = [self.dataArray objectAtIndex:indexPath.row];
    //编辑事件
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [WeakSelf PushEditUserWithUsermodel:usermodel];
    }];
    editRowAction.backgroundColor = [UIColor lightGrayColor];
    //删除
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [[ZFMyDBHelper sharaDBTool]deleteGsmUser:usermodel];
        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
        [WeakSelf HomeRefresh];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    return @[deleteRowAction,editRowAction];
}

#pragma mark 编辑事件

-(void)PushEditUserWithUsermodel:(BLUserModel *)usermodel{
    BLAddUserVC *editAddvc = [[BLAddUserVC alloc]init];
    editAddvc.isEdit = YES;
    editAddvc.usermodel = usermodel;
    [self.navigationController pushViewController:editAddvc animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BLUserModel *usermodel = self.dataArray[indexPath.row];
    BLControlVC *controlvc = [[BLControlVC alloc]init];
    controlvc.usermodel = usermodel;
    [self.navigationController pushViewController:controlvc animated:YES];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *imageName = [NSString stringWithFormat:@"%@",@"user1"];
    
    return [UIImage imageNamed:imageName];
}

-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *text = nil;
    NSString *font = nil;
    UIColor *textColor = nil;
    text  = @"点击添加用户";
    textColor = MainThemeColor;
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];
    }
    if (textColor) {
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

-(UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    
    return 0.0;
}

-(CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 24.0;
}
#pragma mark - DZNEmptyDataSetDelegate

-(BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}
-(BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
-(BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
{
    return YES;
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    NSLog(@"didTapView的点击方式");
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    NSLog(@"didTapButton的button的点击方式");
    BLAddUserVC *adduservc = [[BLAddUserVC alloc]init];
    [self.navigationController pushViewController:adduservc animated:YES];
}
#pragma mark - View Auto-Rotation
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
