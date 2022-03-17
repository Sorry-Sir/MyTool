//
//  HXJDatePickerView.m
//  OO1
//
//  Created by admin on 2021/7/2.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import "HXJDatePickerView.h"


#import "HXJBasicSetting.h"


#pragma mark - HXJDatePickerView类
@interface HXJDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,assign)HXJDataPickerTimeType timeType;
@property(nonatomic,copy)HXJDatePickerViewSelectedBlock selectBlock;

@property(nonatomic,strong)NSMutableArray *showTimeArr;
@property(nonatomic,strong)NSMutableArray *selectTimeTypeArr;
@property(nonatomic,strong)HXJDatePickerModel *datePickerModel;

@property(nonatomic,strong)NSMutableArray *yearArrM;
@property(nonatomic,strong)NSMutableArray *monthArrM;
@property(nonatomic,strong)NSMutableArray *dayArrM;
@property(nonatomic,strong)NSMutableArray *hourArrM;
@property(nonatomic,strong)NSMutableArray *minuteArrM;
@property(nonatomic,strong)NSMutableArray *secondArrM;

@end

@implementation HXJDatePickerView

-(instancetype)initShowViewWithTimeType:(HXJDataPickerTimeType)timeType
                         andSelectBlock:(HXJDatePickerViewSelectedBlock)selectBlock{
    
    self=[super initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, HXJkScreenHeight)];
    
    if (self) {
        
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Action_bgViewTap)];
        [self addGestureRecognizer:tap];
        
        self.timeType=timeType;
        self.selectBlock=selectBlock;
        
        //初始化数据
        [self initData];
        //UI搭建
        [self configureDatePickerViewUI];
    }
    
    return self;
}

#pragma mark - 数据初始化
-(void)initData{
    
    self.showTimeArr=[[NSMutableArray alloc]init];
    self.selectTimeTypeArr=[[NSMutableArray alloc]init];
    
    if (self.timeType&Select_Year) {
        
        [self.showTimeArr addObject:self.yearArrM];
        
        NSString *timeStr = self.yearArrM.firstObject;
        self.datePickerModel.year=[timeStr substringToIndex:timeStr.length-1];
        
        [self.selectTimeTypeArr addObject:@(Select_Year)];
    }
    
    
    if (self.timeType&Select_Month) {
        
        [self.showTimeArr addObject:self.monthArrM];
        
        NSString *timeStr = self.monthArrM.firstObject;
        self.datePickerModel.month=[timeStr substringToIndex:timeStr.length-1];
        
        [self.selectTimeTypeArr addObject:@(Select_Month)];
    }
    
    
    if (self.timeType&Select_Day) {
        
        [self.showTimeArr addObject:self.dayArrM];
        
        NSString *timeStr = self.dayArrM.firstObject;
        self.datePickerModel.day=[timeStr substringToIndex:timeStr.length-1];
        
        [self.selectTimeTypeArr addObject:@(Select_Day)];
    }
    
    if (self.timeType&Select_Hour) {
        
        [self.showTimeArr addObject:self.hourArrM];
        
        NSString *timeStr = self.hourArrM.firstObject;
        self.datePickerModel.hour=[timeStr substringToIndex:timeStr.length-1];
        
        [self.selectTimeTypeArr addObject:@(Select_Hour)];
    }
    
    if (self.timeType&Select_Minute) {
        
        [self.showTimeArr addObject:self.minuteArrM];
        
        NSString *timeStr = self.minuteArrM.firstObject;
        self.datePickerModel.minute=[timeStr substringToIndex:timeStr.length-1];
        
        [self.selectTimeTypeArr addObject:@(Select_Minute)];
    }
    
    if (self.timeType&Select_Second) {
        
        [self.showTimeArr addObject:self.secondArrM];
        
        NSString *timeStr = self.secondArrM.firstObject;
        self.datePickerModel.second=[timeStr substringToIndex:timeStr.length-1];
        
        [self.selectTimeTypeArr addObject:@(Select_Second)];
    }
    
   
    
}

#pragma mark - UI搭建
-(void)configureDatePickerViewUI{
    
    UIButton *bgView=[[UIButton alloc]initWithFrame:CGRectMake(0, HXJkScreenHeight-300*HXJkWScale, HXJkScreenWidth, 300*HXJkWScale)];
    [self addSubview:bgView];
    bgView.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *tipLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, 40*HXJkWScale)];
    [bgView addSubview:tipLabel];
    tipLabel.text=@"请选择时间";
    tipLabel.font=[UIFont systemFontOfSize:14.0];
    tipLabel.textAlignment=NSTextAlignmentCenter;
    
    
    UIButton *cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100*HXJkWScale, 40*HXJkWScale)];
    [bgView addSubview:cancelBtn];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [cancelBtn addTarget:self action:@selector(Action_cancelBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    
    
    
    UIButton *determineBtn=[[UIButton alloc]initWithFrame:CGRectMake(HXJkScreenWidth-100*HXJkWScale, 0, 100*HXJkWScale, 40*HXJkWScale)];
    [bgView addSubview:determineBtn];
    [determineBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    determineBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [determineBtn addTarget:self action:@selector(Action_determineBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [determineBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40*HXJkWScale, HXJkScreenWidth, 260*HXJkWScale)];
    [bgView addSubview:self.pickerView];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
}



#pragma mark - UIPickerViewDataDelegate,Source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.showTimeArr.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    NSArray *dateArr=self.showTimeArr[component];
    
    return dateArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSArray *dateArr=self.showTimeArr[component];
    
    return dateArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSArray *dateArr=self.showTimeArr[component];
    NSString *timeStr = dateArr[row];
    timeStr = [timeStr substringToIndex:timeStr.length-1];
    
    switch ([self.selectTimeTypeArr[component] intValue]) {
        case Select_Year:{
            self.datePickerModel.year=timeStr;
        }
            break;
        case Select_Month:{
            self.datePickerModel.month=timeStr;
        }
            break;
        case Select_Day:{
            self.datePickerModel.day=timeStr;
        }
            break;
        case Select_Hour:{
            self.datePickerModel.hour=timeStr;
        }
            break;
        case Select_Minute:{
            self.datePickerModel.minute=timeStr;
        }
            break;
        case Select_Second:{
            self.datePickerModel.second=timeStr;
        }
            break;
            
        default:
            break;
    }
    
    
}

//重写方法,改变字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *pickerLabel = (UILabel*)view;

    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    }

    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];

    return pickerLabel;

}





#pragma mark - 按钮事件
-(void)Action_bgViewTap{
    
    [self removeFromSuperview];
}

-(void)Action_cancelBtn{
    
    [self Action_bgViewTap];
}

-(void)Action_determineBtn{
    
    if (self.selectBlock) {
        
        self.selectBlock(self.datePickerModel);
    }
    
    [self Action_bgViewTap];
}


#pragma mark - 懒加载
-(NSMutableArray *)yearArrM{
    
    if (_yearArrM==nil) {
        
        _yearArrM=[[NSMutableArray alloc]init];
        
        //获取当前时间 （时间格式支持自定义）
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy"];//自定义时间格式
        NSString *currentYearStr = [formatter stringFromDate:[NSDate date]];
        NSInteger cucurrentYear = currentYearStr.integerValue;
        NSInteger toYear = cucurrentYear+100;
        
//        NSInteger cucurrentYear = 1970;
//        NSInteger toYear = currentYearStr.integerValue;
        
        
        for (NSInteger i = cucurrentYear; i <= toYear ; i++) {
            
            NSString *yearStr = [NSString stringWithFormat:@"%ld年",(long)i];
            [_yearArrM addObject:yearStr];
        }
    }
    
    return _yearArrM;
}



-(NSMutableArray *)monthArrM{
    
    if (_monthArrM==nil) {
        
        _monthArrM=[[NSMutableArray alloc]init];
        
        for (NSInteger i = 1 ; i <= 12; i++) {
            
            NSString *monthStr = [NSString stringWithFormat:@"%ld月",(long)i];
            [_monthArrM addObject:monthStr];
            
        }
    }
    
    return _monthArrM;
}


-(NSMutableArray *)dayArrM{
    
    if (_dayArrM==nil) {
        
        _dayArrM=[[NSMutableArray alloc]init];
        
        for (NSInteger i = 1 ; i <= 31; i++) {
            
            NSString *dayStr = [NSString stringWithFormat:@"%ld日",(long)i];
            [_dayArrM addObject:dayStr];
            
        }
    }
    
    return _dayArrM;
}

-(NSMutableArray *)hourArrM{
    
    if (_hourArrM==nil) {
        
        _hourArrM=[[NSMutableArray alloc]init];
        
        for (NSInteger i = 1 ; i <= 24; i++) {
            
            NSString *hourStr = [NSString stringWithFormat:@"%ld时",(long)i];
            [_hourArrM addObject:hourStr];
            
        }
    }
    
    return _hourArrM;
}

-(NSMutableArray *)minuteArrM{
    
    if (_minuteArrM==nil) {
        
        _minuteArrM=[[NSMutableArray alloc]init];
        
        for (NSInteger i = 1 ; i <= 60; i++) {
            
            NSString *minuteStr = [NSString stringWithFormat:@"%ld分",(long)i];
            [_minuteArrM addObject:minuteStr];
            
        }
    }
    
    return _minuteArrM;
}

-(NSMutableArray *)secondArrM{
    
    if (_secondArrM==nil) {
        
        _secondArrM=[[NSMutableArray alloc]init];
        
        for (NSInteger i = 1 ; i <= 60; i++) {
            
            NSString *secondStr = [NSString stringWithFormat:@"%ld秒",(long)i];
            [_secondArrM addObject:secondStr];
            
        }
    }
    
    return _secondArrM;
}

-(HXJDatePickerModel *)datePickerModel{
    
    if (_datePickerModel==nil) {
        
        _datePickerModel=[[HXJDatePickerModel alloc]init];
    }
    
    return _datePickerModel;
}



@end










#pragma mark - HXJDatePickerModel类
@interface HXJDatePickerModel ()

@end

@implementation HXJDatePickerModel

@end

