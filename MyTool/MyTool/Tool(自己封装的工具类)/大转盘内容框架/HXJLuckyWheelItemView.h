//
//  HXJLuckyWheelItemView.h
//  OO1
//
//  Created by admin on 2020/10/27.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "HXJWheelItemModel.h"


typedef void (^FinisheBlock)(void);


/**
 幸运大转盘内容视图（里面的圆环）
*/
@interface HXJLuckyWheelItemView : UIView


//=========属性
//转盘里面所有物品数组
@property(nonatomic,strong)NSArray<HXJWheelItemModel *> *itemsArr;


//=========方法
//开始旋转到第几个停止，并停止后的回调
- (void)showAnimationWithSelectedIndex:(NSInteger)index andAnimationDidStopBlokc:(FinisheBlock)finisheBlock;



@end


