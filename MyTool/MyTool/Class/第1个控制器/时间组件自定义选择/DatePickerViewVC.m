//
//  DatePickerViewVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "DatePickerViewVC.h"


#import "HXJDatePickerView.h"


@interface DatePickerViewVC ()

@property(nonatomic,strong)UILabel *messageLabel;

@property(nonatomic,assign)HXJDataPickerTimeType timeType;

@end

@implementation DatePickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"时间组件自定义选择";
    
    [self UI_configureVCUI];
}

#pragma mark - UI创建
-(void)UI_configureVCUI{
    
    __HXJWeakSelf;
    
    //=============
    NSArray *btnTitleArr=@[@"年",@"月",@"日",@"时",@"分",@"秒"];
    CGFloat btnWidth=HXJkScreenWidth/btnTitleArr.count;
    
    for (int i=0; i<btnTitleArr.count; i++) {
        
        UIButton *temBtn=[[UIButton alloc]initWithFrame:CGRectMake(btnWidth*i, 30, btnWidth, 30)];
        [self.view addSubview:temBtn];
        [temBtn setTitle:btnTitleArr[i] forState:(UIControlStateNormal)];
        [temBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [temBtn setTitleColor:app_MainColor forState:(UIControlStateSelected)];
        temBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
        temBtn.tag=i;
        [temBtn addTargetActionBlock:^(UIButton *btn) {
            
            [weakSelf Action_eventBtnSelect:btn];
        }];
        
    }
    
    
    //=============
    UIButton *determinBtn=[[UIButton alloc]initWithFrame:CGRectMake((HXJkScreenWidth-80)/2, 100, 80, 40)];
    [self.view addSubview:determinBtn];
    [determinBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [determinBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    determinBtn.backgroundColor=app_MainColor;
    determinBtn.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [determinBtn addTargetActionBlock:^(UIButton *btn) {
        
        [weakSelf Action_determinBtn];
        
    }];
    
    
    //=============
    self.messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 200, HXJkScreenWidth, 30)];
    [self.view addSubview:self.messageLabel];
    self.messageLabel.textAlignment=NSTextAlignmentCenter;
    self.messageLabel.font=[UIFont systemFontOfSize:14.0];
    self.messageLabel.textColor=[UIColor blackColor];
    
    
    
}


#pragma mark - 按钮事件
-(void)Action_eventBtnSelect:(UIButton *)sender{
    
    sender.selected=!sender.selected;
    
    NSArray *typeArr=@[@(Select_Year),@(Select_Month),@(Select_Day),@(Select_Hour),@(Select_Minute),@(Select_Second)];
    
    HXJDataPickerTimeType selectType=[typeArr[sender.tag] unsignedIntValue];
    
    if (sender.selected) {
        self.timeType=self.timeType|selectType;
    }else{
        self.timeType=self.timeType^selectType;
    }
}

-(void)Action_determinBtn{
    
    
    HXJDatePickerView *datePickerView = [[HXJDatePickerView alloc] initShowViewWithTimeType:self.timeType andSelectBlock:^(HXJDatePickerModel *timeModel) {
            
        self.messageLabel.text=[NSString stringWithFormat:@""];
    }];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:datePickerView];
}




@end
