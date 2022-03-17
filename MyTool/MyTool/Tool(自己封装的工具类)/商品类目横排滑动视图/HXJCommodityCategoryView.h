//
//  HXJCommodityCategoryView.h
//  OO1
//
//  Created by admin on 2021/10/28.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef void(^HXJCommodityCategoryViewSelectBlock) (NSInteger index);



@interface HXJCommodityCategoryView : UIView

@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,copy)HXJCommodityCategoryViewSelectBlock selectBlock;

@end

