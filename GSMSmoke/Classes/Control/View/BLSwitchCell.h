//
//  BLSwitchCell.h
//  GSMSmoke
//
//  Created by bailing on 2018/5/25.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSwitchCell : UITableViewCell
///type的image
@property (weak, nonatomic) IBOutlet UIImageView *type_icon;
///类型的button
@property (weak, nonatomic) IBOutlet UILabel *type_lab;
///开关
@property (weak, nonatomic) IBOutlet UISwitch *myswitch;

@end
