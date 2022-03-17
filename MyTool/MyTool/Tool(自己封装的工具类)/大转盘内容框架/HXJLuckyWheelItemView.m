//
//  HXJLuckyWheelItemView.m
//  OO1
//
//  Created by admin on 2020/10/27.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import "HXJLuckyWheelItemView.h"


#import "HXJSectorView.h"



@interface HXJLuckyWheelItemView ()<CAAnimationDelegate>
//记录转的角度
@property(nonatomic,assign)double startAngle;
//回调block
@property(nonatomic,copy)FinisheBlock finisheBlock;

@end


@implementation HXJLuckyWheelItemView


-(void)setItemsArr:(NSArray *)itemsArr{
    
    _itemsArr=itemsArr;
    
    for (UIView *view in self.subviews) {
        
        [view removeFromSuperview];
    }
    
    [self configureUI];
}


#pragma mark - 创建UI
-(void)configureUI{
    
    NSInteger itemsArrCount=self.itemsArr.count;
    CGFloat angle = 2*M_PI/itemsArrCount;
    CGFloat r =self.frame.size.height/2;
    CGFloat width=r*tan(angle/2)*2;

    // 将单个View添加到父视图上，这里要根据View个数 绕锚点 进行不同角度的旋转，
    for (int i =0; i<itemsArrCount; i++) {
       
        HXJWheelItemModel *itemModel=self.itemsArr[i];
        
        HXJSectorView *view = [[HXJSectorView alloc] initWithFrame:CGRectMake(0, 0, width, r) titleStr:itemModel.itemName imageStr:itemModel.itemImageStr backColor1:itemModel.bgColor1 backColor2:itemModel.bgColor2 angle:angle];
        //锚点在父视图的位置
        view.layer.position =CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2);
        //锚点在自己的视图位置
        view.layer.anchorPoint =CGPointMake(0.5,1);
        //正数:顺时针，负数，逆时针
        view.transform =CGAffineTransformMakeRotation(angle*i);
        [self addSubview:view];
    }
    
}


#pragma mark - 开始旋转
- (void)showAnimationWithSelectedIndex:(NSInteger)index andAnimationDidStopBlokc:(FinisheBlock)finisheBlock{
    
    self.finisheBlock=finisheBlock;
    
    //因为是反转
    index = self.itemsArr.count - index + 1;
    
    double endAngle =_startAngle+(2*M_PI/self.itemsArr.count)*index+((2*M_PI)*2);
    
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置旋转的起始值与终止值
    rotationAnimation.fromValue = @(_startAngle);
    rotationAnimation.toValue = @(endAngle);
    
    //旋转时长
    rotationAnimation.duration = 2.0;
    
    //速度函数
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeBoth;
    
    rotationAnimation.delegate=self;
    
    [self.layer addAnimation:rotationAnimation forKey:@"TurnTableAnimation"];
    
    //记下当前旋转的位置，作为下一次旋转的起始值
//    _startAngle = endAngle;
    //重新转
    _startAngle = 0;
}


#pragma mark - CAAnimationDelegate转盘停止后的回调
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (self.finisheBlock) {
        
        self.finisheBlock();
    }
    
}



@end
