//  ZFPickerView.h
//  ziyougou
//  Created by bailing on 2018/3/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
@class ZFPickerView;
@protocol ZFPicketViewDelegate <NSObject>
- (void)ZFPickerView:(ZFPickerView *)pickerView didSelectYear:(NSInteger )year Month:(NSInteger )month Day:(NSInteger )day Hour:(NSInteger )hour Minute:(NSInteger )minute;
@end

@interface ZFPickerView : UIView
@property (nonatomic )NSInteger MaxYear;//当前年数加上MaxYear为最大值 默认20

@property (nonatomic , weak)id <ZFPicketViewDelegate> delegate;

- (instancetype)initWithDelegate:(id <ZFPicketViewDelegate>)delegate;

- (void)show;

- (void)hide;

@end
