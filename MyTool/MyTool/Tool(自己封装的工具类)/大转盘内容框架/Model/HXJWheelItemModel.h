//
//  HXJWheelItemModel.h
//  OO1
//
//  Created by admin on 2020/10/27.
//  Copyright © 2020 hongxujia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 大转盘物品模型
 */
@interface HXJWheelItemModel : NSObject

//物品名称
@property(nonatomic,copy)NSString *itemName;
//图片地址，可以是名称，也可以网络
@property(nonatomic,copy)NSString *itemImageStr;
//转盘里面单个视图的背景颜色（大的）
@property(nonatomic,strong)UIColor *bgColor1;
//转盘里面单个视图的背景颜色（小的）
@property(nonatomic,strong)UIColor *bgColor2;


@end


