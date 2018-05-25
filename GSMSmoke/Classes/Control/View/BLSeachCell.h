//
//  BLSeachCell.h
//  GSMSmoke
//
//  Created by bailing on 2018/5/24.
//  Copyright © 2018年 zhufeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLSeachCell : UITableViewCell
///类型图片
@property (weak, nonatomic) IBOutlet UIImageView *type_icon;
///类型的文字
@property (weak, nonatomic) IBOutlet UILabel *type_lab;

@end
