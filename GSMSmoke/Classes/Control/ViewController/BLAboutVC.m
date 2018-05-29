//  BLAboutVC.m
//  GSMSmoke
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "BLAboutVC.h"
@interface BLAboutVC ()
/// 关于我们的label
@property (weak, nonatomic) IBOutlet UILabel *about_lab;
@end
@implementation BLAboutVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    NSString *currentVesion =[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    self.about_lab.text   = [NSString stringWithFormat:@"GSM Smoke Version:%@",currentVesion];
}
#pragma mark 返回按钮
- (void)navigationBarLeftButtonEvent:(UIButton *)sender
{
    [self backViewController];
}

@end
