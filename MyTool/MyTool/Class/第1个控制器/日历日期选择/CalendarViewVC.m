//
//  CalendarViewVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "CalendarViewVC.h"


#import "HXJCalendarView.h"


@interface CalendarViewVC ()

//日期
@property(nonatomic,strong)UILabel *dateLabel;
//弹出的日历视图
@property(nonatomic,strong)HXJCalendarView *calendarView;

@end

@implementation CalendarViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"日历日期选择";
    
    [self UI_configureVCUI];
    
    [self configureHXJCalendarView];
}

#pragma mark - UI创建
-(void)UI_configureVCUI{
    
    __HXJWeakSelf;
    
    self.dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 30, HXJkScreenWidth-60, 80)];
    [self.view addSubview:self.dateLabel];
    self.dateLabel.font=[UIFont systemFontOfSize:14.0];
    self.dateLabel.numberOfLines=0;
    
    
    UIButton *selectBtn=[[UIButton alloc]initWithFrame:CGRectMake(100, 200, HXJkScreenWidth-200, 40)];
    [self.view addSubview:selectBtn];
    [selectBtn setTitle:@"选择日期" forState:(UIControlStateNormal)];
    [selectBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    selectBtn.backgroundColor=app_MainColor;
    selectBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [selectBtn addTargetActionBlock:^(UIButton *btn) {
        
        weakSelf.calendarView.hidden=NO;
    }];
    
}

//日历UI
-(void)configureHXJCalendarView{
    
    self.calendarView=[[HXJCalendarView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, HXJkScreenHeight-HXJkTopHeight)];
    [self.view addSubview:self.calendarView];
    self.calendarView.hidden=YES;
    self.calendarView.selectColor=app_MainColor;
    self.calendarView.isCanSelectToday=YES;
    self.calendarView.maxSelectDateDifference=0;
    [self.calendarView setCompleteDataRefreshUI];
    
    __HXJWeakSelf;
    self.calendarView.selectBlock = ^(NSMutableArray *selectDatesArrM) {
        
        NSMutableArray *yyyy_MM_ddDateArrM = [NSMutableArray array];
        for (HXJCalendarDateModel *dateModel in selectDatesArrM) {
            
            [yyyy_MM_ddDateArrM addObject:dateModel.yyyy_MM_ddStr];
        }
        
        weakSelf.dateLabel.text = [yyyy_MM_ddDateArrM componentsJoinedByString:@","];
    };
    
    
}




@end
