//
//  CommodityCategoryViewVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "CommodityCategoryViewVC.h"


#import "HXJCommodityCategoryView.h"


@interface CommodityCategoryViewVC ()

@property(nonatomic,strong)HXJCommodityCategoryView *commodityCategoryView;

@property(nonatomic,strong)UILabel *messageLabel;

@end

@implementation CommodityCategoryViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"商品类目横排滑动";
    
    [self UI_configureVCUI];
}

#pragma mark - UI创建
-(void)UI_configureVCUI{
    
    __HXJWeakSelf;
    
    //==========UI搭建
    self.commodityCategoryView=[[HXJCommodityCategoryView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, 200)];
    [self.view addSubview:self.commodityCategoryView];
    
    
    self.messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 250, HXJkScreenWidth, 30)];
    [self.view addSubview:self.messageLabel];
    self.messageLabel.textAlignment=NSTextAlignmentCenter;
    self.messageLabel.font=[UIFont systemFontOfSize:14.0];
    self.messageLabel.textColor=[UIColor blackColor];
    
    
    //==========数据处理
    NSMutableArray *dataArrM=[[NSMutableArray alloc]init];
    
    for (int i=0; i<11; i++) {
        
        [dataArrM addObject:@{
            @"home_icon":@"应用中心_人工客服",
            @"category_name":@"耳机类"
        }];
        
    }
    self.commodityCategoryView.dataArr=dataArrM;
    
    self.commodityCategoryView.selectBlock = ^(NSInteger index) {
        
        [weakSelf Action_commodityCategoryViewSelectBlock:index];
    };
    
}


#pragma mark - 按钮事件
-(void)Action_commodityCategoryViewSelectBlock:(NSInteger)index{
    
    NSLog(@"选中了第%ld个",index);
    
    self.messageLabel.text=[NSString stringWithFormat:@"选中了第%ld个",index];
}



@end
