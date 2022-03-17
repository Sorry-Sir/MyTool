//
//  HXJCommodityCategoryView.m
//  OO1
//
//  Created by admin on 2021/10/28.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import "HXJCommodityCategoryView.h"


#import "HXJBasicSetting.h"
#import <SDWebImage.h>

@interface HXJCommodityCategoryView ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation HXJCommodityCategoryView

-(void)setDataArr:(NSArray *)dataArr{
    
    _dataArr=dataArr;
    
    for (UIView *subView in self.subviews) {

        [subView removeFromSuperview];
    }
    
    [self configureUI];
}


#pragma mark - 创建UI
-(void)configureUI{
    
    __HXJWeakSelf;
    
    //==================
    UIScrollView *bgScrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:bgScrollView];
    bgScrollView.showsVerticalScrollIndicator=NO;
    bgScrollView.showsHorizontalScrollIndicator=NO;
    bgScrollView.pagingEnabled=YES;
    bgScrollView.delegate=self;
    
    
    //==================
    int page = ceil(self.dataArr.count/8.0);
    
    int k=0;
    
    CGFloat viewWith=self.bounds.size.width/4.0;
    CGFloat viewHeight=self.bounds.size.height/2.0;
    
    
    for (int i=0; i<page; i++) {
        
        UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height)];
        [bgScrollView addSubview:tempView];
        tempView.backgroundColor=[UIColor whiteColor];
        
        for (int j=0; j<2; j++) {
            
            for (int n=0; n<4; n++) {
                
                if (k==self.dataArr.count) {
                    
                    break;
                }
                
                NSDictionary *dataDic=self.dataArr[k];
                
                
                UIView *iconView=[[UIView alloc]initWithFrame:CGRectMake(viewWith*n, viewHeight*j, viewWith, viewHeight)];
                [tempView addSubview:iconView];
                
                
                UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake((viewWith-40*HXJkWScale)/2, 10*HXJkWScale, 40*HXJkWScale, 40*HXJkWScale)];
                [iconView addSubview:icon];
//                [icon sd_setImageWithURL:[NSURL URLWithString:dataDic[@"home_icon"]]];
                icon.image=[UIImage imageNamed:dataDic[@"home_icon"]];
                icon.userInteractionEnabled=YES;
                
                
                UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 60*HXJkWScale, viewWith, 20*HXJkWScale)];
                [iconView addSubview:titleLabel];
                titleLabel.textAlignment=NSTextAlignmentCenter;
                titleLabel.font=[UIFont systemFontOfSize:14.0];
                titleLabel.text=[NSString stringWithFormat:@"%@",dataDic[@"category_name"]];
                
                
                UIButton *bgBtn=[[UIButton alloc]initWithFrame:iconView.bounds];
                [iconView addSubview:bgBtn];
                bgBtn.tag=k;
                [bgBtn addTargetActionBlock:^(UIButton *btn) {
                    
                    [weakSelf Action_bgBtn:btn];
                }];
                
                
                k++;
                
            }
            
        }
        
        
    }
    
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
    [self addSubview:self.pageControl];
    self.pageControl.numberOfPages=page;
    self.pageControl.currentPage=0;
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    self.pageControl.userInteractionEnabled=NO;
    
    
    //==================
    bgScrollView.contentSize=CGSizeMake(self.bounds.size.width*page,self.bounds.size.height);
    
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //=======数据
    CGPoint point = scrollView.contentOffset;
    NSInteger currentPage = (NSInteger)point.x/self.bounds.size.width;
    
    self.pageControl.currentPage=currentPage;
    
}

#pragma mark - 按钮事件
-(void)Action_bgBtn:(UIButton *)sender{
    
    if (self.selectBlock) {
        
        self.selectBlock(sender.tag);
    }
    
}



@end
