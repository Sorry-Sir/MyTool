//
//  HXJDatePickerView.h
//  OO1
//
//  Created by admin on 2021/7/2.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXJDatePickerModel;



#pragma mark - 时间类型枚举
typedef  NS_OPTIONS(NSInteger,HXJDataPickerTimeType)
{
    Select_Year     = (1UL << 1),
    Select_Month    = (1UL << 2),
    Select_Day      = (1UL << 3),
    Select_Hour     = (1UL << 4),
    Select_Minute   = (1UL << 5),
    Select_Second   = (1UL << 6),
};


#pragma mark - 回调
typedef void (^HXJDatePickerViewSelectedBlock)(HXJDatePickerModel *timeModel);







#pragma mark - HXJDatePickerView类
@interface HXJDatePickerView : UIView

-(instancetype)initShowViewWithTimeType:(HXJDataPickerTimeType)timeType
                         andSelectBlock:(HXJDatePickerViewSelectedBlock)selectBlock;


@end








#pragma mark - HXJDatePickerModel类
@interface HXJDatePickerModel : NSObject

@property(nonatomic,copy)NSString *year;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,copy)NSString *hour;
@property(nonatomic,copy)NSString *minute;
@property(nonatomic,copy)NSString *second;

@end
