//
//  ScaleCycleViewVC.m
//  MyTool
//
//  Created by admin on 2022/3/16.
//

#import "ScaleCycleViewVC.h"


#import "HXJScaleCycleView.h"



@interface ScaleCycleViewVC ()

@property(nonatomic,strong)HXJScaleCycleView *scaleCycleView;

@property(nonatomic,strong)UILabel *messageLabel;

@end

@implementation ScaleCycleViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"缩放滚动轮播图";
    
    [self UI_configureVCUI];
}

#pragma mark - UI创建
-(void)UI_configureVCUI{
    
    __HXJWeakSelf;
    
    //==========UI搭建
    self.scaleCycleView=[[HXJScaleCycleView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, 450)];
    [self.view addSubview:self.scaleCycleView];
    self.scaleCycleView.scaleNum=1.2;
    self.scaleCycleView.isShowQRCode=YES;
    self.scaleCycleView.imageSize=CGSizeMake(HXJkScreenWidth*0.5, 450*HXJkWScale*0.6);
    
    
    
    self.messageLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 500, HXJkScreenWidth, 30)];
    [self.view addSubview:self.messageLabel];
    self.messageLabel.textAlignment=NSTextAlignmentCenter;
    self.messageLabel.font=[UIFont systemFontOfSize:14.0];
    self.messageLabel.textColor=[UIColor blackColor];
    
    
    //==========数据处理
    NSMutableArray *dataArrM=[[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++) {
        
        [dataArrM addObject:@"轮播图1"];
        
    }
    self.scaleCycleView.imageDataArr=dataArrM;
    
    self.scaleCycleView.selectedCenterImageBlock = ^(NSInteger index, UIImage *seeImage) {
        
        [weakSelf Action_commodityCategoryViewSelectBlock:index];
    };
    
}


#pragma mark - 按钮事件
-(void)Action_commodityCategoryViewSelectBlock:(NSInteger)index{
    
    NSLog(@"选中了第%ld个",index);
    
    self.messageLabel.text=[NSString stringWithFormat:@"选中了第%ld个",index];
}



@end
