//
//  LuckyWheelVC.m
//  OO1
//
//  Created by admin on 2020/9/17.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import "LuckyWheelVC.h"

#import "HXJLuckyWheelItemView.h"


@interface LuckyWheelVC ()

//============UI视图
//箭头按钮视图
@property(nonatomic,strong)UIImageView *luckDrawIV;
//幸运大转盘里面的内容
@property(nonatomic,strong)HXJLuckyWheelItemView *luckyWheelItemView;

//==========数据
//所有物品
@property(nonatomic,strong)NSMutableArray *iteamArr;

@end

@implementation LuckyWheelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"幸运大转盘";
    
    [self configureLuckyWheelVCUI];
    
    [self AFN_loadData];
}

#pragma mark - 创建UI
-(void)configureLuckyWheelVCUI{
    
    
    //==================
    UIScrollView *bgScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, HXJkScreenHeight-HXJkTopHeight)];
    [self.view addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator=NO;
    bgScrollView.showsHorizontalScrollIndicator=NO;
    
    
    //============
    UIImageView *bgImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HXJkScreenWidth, HXJkScreenHeight-HXJkTopHeight)];
    [bgScrollView addSubview:bgImageView];
    bgImageView.image=[UIImage imageNamed:@"幸运大转盘_背景"];
    
    
    //===============
    UIImage *luckyWheelBgImage=[UIImage imageNamed:@"幸运大转盘_大转盘"];
    
    
    UIImageView *luckyWheelBgIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 30, HXJkScreenWidth, HXJkScreenWidth/(luckyWheelBgImage.size.width/luckyWheelBgImage.size.height))];
    [bgScrollView addSubview:luckyWheelBgIV];
    luckyWheelBgIV.image=luckyWheelBgImage;
    luckyWheelBgIV.userInteractionEnabled=YES;
    
    
    self.luckyWheelItemView=[[HXJLuckyWheelItemView alloc]initWithFrame:CGRectMake(0, 0, 210*HXJkWScale, 210*HXJkWScale)];
    [luckyWheelBgIV addSubview:self.luckyWheelItemView];
    self.luckyWheelItemView.layer.cornerRadius=210*HXJkWScale/2;
    self.luckyWheelItemView.layer.masksToBounds=YES;
    self.luckyWheelItemView.center=CGPointMake(luckyWheelBgIV.bounds.size.width/2, luckyWheelBgIV.bounds.size.height/2);
    self.luckyWheelItemView.backgroundColor=[UIColor whiteColor];
    
    
    
    UIImageView *luckDrawIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60*HXJkWScale, 60*HXJkWScale)];
    [luckyWheelBgIV addSubview:luckDrawIV];
    luckDrawIV.image=[UIImage imageNamed:@"幸运大转盘_开始抽奖箭头"];
    luckDrawIV.center=CGPointMake(luckyWheelBgIV.bounds.size.width/2, luckyWheelBgIV.bounds.size.height/2);
    luckDrawIV.contentMode=UIViewContentModeCenter;
    luckDrawIV.userInteractionEnabled=YES;
    self.luckDrawIV=luckDrawIV;
    
    UITapGestureRecognizer *luckDrawIVTap=[[UITapGestureRecognizer alloc]initWithTargetActionBlock:^{
        
        [self Action_luckDrawIVTap];
    }];
    [luckDrawIV addGestureRecognizer:luckDrawIVTap];
    
    
    
    UIImageView *bottomGiftTableIV=[[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(luckyWheelBgIV.frame)-70*HXJkWScale, HXJkScreenWidth, 120*HXJkWScale)];
    [bgScrollView addSubview:bottomGiftTableIV];
    bottomGiftTableIV.image=[UIImage imageNamed:@"幸运大转盘_礼物台"];
    
    
    
    //==================
    CGFloat maxHeight=CGRectGetMaxY(bgImageView.frame);
    maxHeight=(maxHeight>bgScrollView.bounds.size.height)?maxHeight:bgScrollView.bounds.size.height+1;
    bgScrollView.contentSize=CGSizeMake(HXJkScreenWidth,maxHeight);
    
}





#pragma mark - 按钮事件
//点击开始抽奖
-(void)Action_luckDrawIVTap{
    
    self.luckDrawIV.userInteractionEnabled=NO;
    [self AFN_luckDraw];
}



#pragma mark - 网络请求
-(void)AFN_loadData{
    
    NSDictionary *itemTypeDic=@{
        @"1":@"现金",
        @"2":@"积分",
    };

    NSDictionary *itemImageDic=@{
        @"1":@"幸运大转盘_左边图标二",
        @"2":@"幸运大转盘_左边图标一",
    };

    UIColor *color1_1=HXJRGB(245, 238, 224);
    UIColor *color1_2=HXJRGB(254, 204, 161);
    UIColor *color2_1=HXJRGB(254, 207, 207);
    UIColor *color2_2=HXJRGB(253, 182, 182);
    UIColor *color3_1=HXJRGB(245, 237, 245);
    UIColor *color3_2=HXJRGB(244, 222, 222);
    
    self.iteamArr=[[NSMutableArray alloc]init];
    
    for (int i=0; i<9; i++) {
        
        HXJWheelItemModel *wheelItemModel=[[HXJWheelItemModel alloc]init];
        wheelItemModel.itemName=@"积分";
        wheelItemModel.itemImageStr=@"幸运大转盘_左边图标一";
        
        //余数
        int remainder=i%3;
        
        switch (remainder) {
            case 0:{
                wheelItemModel.bgColor1=color1_1;
                wheelItemModel.bgColor2=color1_2;
            }
                break;
            case 1:{
                wheelItemModel.bgColor1=color2_1;
                wheelItemModel.bgColor2=color2_2;
            }
                break;
            case 2:{
                wheelItemModel.bgColor1=color3_1;
                wheelItemModel.bgColor2=color3_2;
            }
                break;
                
            default:
                break;
        }
        
        [self.iteamArr addObject:wheelItemModel];
    }


    self.luckyWheelItemView.itemsArr=self.iteamArr;

}


-(void)AFN_luckDraw{
    
    [self.luckyWheelItemView showAnimationWithSelectedIndex:3 andAnimationDidStopBlokc:^{
        
        self.luckDrawIV.userInteractionEnabled=YES;
        
    }];
    
}

@end
