//
//  Tool_LocationHandler.h
//  OO1
//
//  Created by admin on 2021/4/15.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import <Foundation/Foundation.h>


#import <CoreLocation/CoreLocation.h>
@class LocationHandlerDataModel;


//定位后的回调
typedef void (^LocationHandlerBlock)(LocationHandlerDataModel *locationModel);




#pragma mark - Tool_LocationHandler类
@interface Tool_LocationHandler : NSObject
//单例
+(instancetype)shareLocationHandler;

-(void)startUpdatingAndLocationHandlerBlock:(LocationHandlerBlock)locationHandlerBlock;

@end





#pragma mark - LocationHandlerDataModel类
@interface LocationHandlerDataModel : NSObject

@property(nonatomic,strong)CLLocation *location;
//纬度
@property(nonatomic,strong)NSString *latitudeStr;
//经度
@property(nonatomic,strong)NSString *longitudeStr;


//国家
@property(nonatomic,strong)NSString *countryStr;
//省份
@property(nonatomic,strong)NSString *provincesStr;
//城市
@property(nonatomic,strong)NSString *cityStr;
//区
@property(nonatomic,strong)NSString *subLocalityStr;
//地址
@property(nonatomic,strong)NSString *addressStr;



@end


