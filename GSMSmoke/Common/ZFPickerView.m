//  ZFPickerView.m
//  ziyougou
//  Created by bailing on 2018/3/3.
//  Copyright © 2018年 zhufeng. All rights reserved.

#import "ZFPickerView.h"

@interface ZFPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic , strong)UIPickerView *pickerView;

@property (nonatomic , strong)NSDate *date;

@property (nonatomic )NSInteger year;

@property (nonatomic )NSInteger month;

@property (nonatomic )NSInteger day;

@property (nonatomic )NSInteger hour;

@property (nonatomic )NSInteger minute;

@property (nonatomic )NSInteger nowYear;//当前的年数

@property (nonatomic , strong)UIButton *okBtn;

@property (nonatomic , strong)UIButton *cancelBtn;

@property (nonatomic , strong)UIView *contentView;

//服务时间
@property (nonatomic,strong)UILabel *serverLabel;

@end

@implementation ZFPickerView

- (UIPickerView *)pickerView
{
    if (!_pickerView)
    {
        _pickerView = [[UIPickerView alloc] init];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setUserInteractionEnabled:YES];
        [_contentView addSubview:self.cancelBtn];
        [_contentView addSubview:self.okBtn];
        [_contentView addSubview:self.serverLabel];
    }
    return _contentView;
}

- (UIButton *)okBtn
{
    if (!_okBtn)
    {   _okBtn = [[UIButton alloc] init];
        [_okBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15.f]];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
//服务时间的东西了
-(UILabel *)serverLabel{
    if (!_serverLabel) {
        _serverLabel = [[UILabel alloc]init];
        _serverLabel.font = [UIFont systemFontOfSize:15.0f];
        _serverLabel.text = @"服务时间";
        _serverLabel.textColor = [UIColor whiteColor];
    }
    return _serverLabel;
}
//获取当前的时间
- (void)loadCurrentDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    _year = [comps year];
    _nowYear = _year;
    _month = [comps month];
    _day = [comps day];
    _hour = [comps hour];
    _minute = [comps minute];
}
//初始化pickerView
- (void)initPickViewDate;
{
    [_pickerView selectRow:_year inComponent:0 animated:YES];
    [_pickerView selectRow:_month inComponent:1 animated:YES];
    [_pickerView selectRow:_day inComponent:2 animated:YES];
    [_pickerView selectRow:_hour inComponent:3 animated:YES];
    [_pickerView selectRow:_minute inComponent:4 animated:YES];
}
//初始话的方法
-(instancetype)initWithDelegate:(id<ZFPicketViewDelegate>)delegate{
    if (self = [super init]) {
        [self loadCurrentDate];
        self.MaxYear = 20;
        _delegate = delegate;
        [self setFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        [self addSubview:self.contentView];
        [self addSubview:self.pickerView];
        [self initPickViewDate];
    }
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.1]];
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (IPHONE_WIDTH > 414) {
        NSLog(@"ipad");
        [_contentView setFrame:CGRectMake(0, 600, IPHONE_WIDTH, 40)];
        _contentView.backgroundColor = MainThemeColor;
        [_cancelBtn setFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_contentView.frame))];
        [_okBtn setFrame:CGRectMake(CGRectGetWidth(_contentView.frame) - CGRectGetWidth(_cancelBtn.frame) - CGRectGetMinX(_cancelBtn.frame), CGRectGetMinY(_cancelBtn.frame), CGRectGetWidth(_cancelBtn.frame), CGRectGetHeight(_cancelBtn.frame))];
        //服务时间的label
        [_serverLabel setFrame:CGRectMake(self.frame.size.width/2-40, 0, 80, CGRectGetHeight(_contentView.frame))];
        [_pickerView setFrame:CGRectMake(0, CGRectGetMaxY(_contentView.frame), CGRectGetWidth(_contentView.frame), IPHONE_HEIGHT -640)];
    }else{
        [_contentView setFrame:CGRectMake(0, IPHONE_HEIGHT - 300, IPHONE_WIDTH, 40)];
        _contentView.backgroundColor = MainThemeColor;
        [_cancelBtn setFrame:CGRectMake(10, 0, 60, CGRectGetHeight(_contentView.frame))];
        [_okBtn setFrame:CGRectMake(CGRectGetWidth(_contentView.frame) - CGRectGetWidth(_cancelBtn.frame) - CGRectGetMinX(_cancelBtn.frame), CGRectGetMinY(_cancelBtn.frame), CGRectGetWidth(_cancelBtn.frame), CGRectGetHeight(_cancelBtn.frame))];
        //服务时间的label
        [_serverLabel setFrame:CGRectMake(self.frame.size.width/2-40, 0, 80, CGRectGetHeight(_contentView.frame))];
        [_pickerView setFrame:CGRectMake(0, CGRectGetMaxY(_contentView.frame), CGRectGetWidth(_contentView.frame), CGRectGetMinY(_contentView.frame) - CGRectGetHeight(_contentView.frame))];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[UIApplication sharedApplication].keyWindow];
    if (point.y < CGRectGetMinY(_contentView.frame))
    {
        [self hide];
    }
}
- (void)show
{
    [self setFrame:CGRectMake(0, 0, 0, 0)];
    [UIView animateWithDuration:.5 animations:^{
        [self setFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }];
}
- (void)hide
{
//    [UIView animateWithDuration:.5 animations:^{
//        [self setFrame:CGRectMake(0, 0, 0, 0)];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
    [self removeFromSuperview];
}
- (NSInteger )getDayWithYear:(NSInteger )year Month:(NSInteger )month
{
    switch (month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
            break;
        case 2:
        {
            if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0)
            {
                return 29;
            }
            else
            {
                return 28;
            }
        }
            break;
    }
    return 30;
}
- (void)setMaxYear:(NSInteger)MaxYear
{
    _MaxYear = MaxYear;
    
    [_pickerView reloadComponent:0];
}
#pragma mark - Action
- (void)onClick:(UIButton *)btn
{
    if (btn == _okBtn)
    {
        if ([_delegate respondsToSelector:@selector(ZFPickerView:didSelectYear:Month:Day:Hour:Minute:)])
        {
            [_delegate ZFPickerView:self didSelectYear:_year Month:_month Day:_day Hour:_hour Minute:_minute];
            //这个是隐藏了东西
            [self hide];
        }
    }
    if (btn == _cancelBtn)
    {
        [self hide];
    }
}
#pragma mark - UIPickerViewDelegate | UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {//年
            return _MaxYear;
        }
            break;
        case 1:
        {//月
            return 12;
        }
            break;
        case 2:
        {//日
            return [self getDayWithYear:_year Month:_month];//
        }
            break;
        case 3:
        {//小时
            return 24;
        }
            break;
        case 4:
        {//分钟
            return 60;
        }
            break;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {//年
            return [NSString stringWithFormat:@"%ld年",_nowYear + row];
        }
            break;
        case 1:
        {//月
            return [NSString stringWithFormat:@"%02ld月",row];
        }
            break;
        case 2:
        {//日
            return [NSString stringWithFormat:@"%ld日",row];
        }
            break;
        case 3:
        {//小时
            return [NSString stringWithFormat:@"%02ld时",row];
        }
            break;
        case 4:
        {//分钟
            return [NSString stringWithFormat:@"%02ld分",row];
        }
            break;
    }
    return @"";
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *label = (UILabel *)view;
    
    if (view == nil)
    {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:13.f]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setHighlightedTextColor:[UIColor colorWithWhite:.4 alpha:.99]];
        [label setBackgroundColor:[UIColor colorWithWhite:.95 alpha:.99]];
    }
    
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            _year = row + _nowYear;
            [pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            _month = row + 1;
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            _day = row + 1;
        }
            break;
        case 3:
        {
            _hour = row;
        }
            break;
        case 4:
        {
            _minute = row;
        }
            break;
    }
}
- (void)dealloc
{
    NSLog(@"dealloc : %p ",self);
    NSLog(@"zfpickerView dealloc");
}
@end
