//
//  Tool_LocationHandler.m
//  OO1
//
//  Created by admin on 2021/4/15.
//  Copyright © 2021 hongxujia. All rights reserved.
//

#import "Tool_LocationHandler.h"

#import <SVProgressHUD.h>

@interface Tool_LocationHandler ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;

@property(nonatomic,copy)LocationHandlerBlock locationHandlerBlock;

@end

@implementation Tool_LocationHandler

//=======单例
+ (instancetype)shareLocationHandler{
    
    static Tool_LocationHandler *_shareLocationHandler=nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _shareLocationHandler=[[Tool_LocationHandler alloc]init];
        
        [_shareLocationHandler configureLocationManager];
    });
    
    return _shareLocationHandler;
}
//=======初始化定位
-(void)configureLocationManager{
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 1000.0f;
    [_locationManager requestWhenInUseAuthorization];
}


-(void)startUpdatingAndLocationHandlerBlock:(LocationHandlerBlock)locationHandlerBlock{
    
    _locationHandlerBlock=locationHandlerBlock;
    
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {

        [self.locationManager startUpdatingLocation];
    }else{
        
        [SVProgressHUD showInfoWithStatus:@"请在设置中打开定位"];
    }
    
}

-(void)stopUpdating{
    
    [_locationManager stopUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //1.获取用户位置的对象
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coordinate = currentLocation.coordinate;
    
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    //反编码
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
                [SVProgressHUD showInfoWithStatus:@"无法定位当前城市"];
            }
            
            if (self.locationHandlerBlock) {
                
                LocationHandlerDataModel *locationModel=[LocationHandlerDataModel new];
                NSLog(@"纬度%f 经度%f",coordinate.latitude,coordinate.longitude);
                
                locationModel.latitudeStr=[NSString stringWithFormat:@"%f",coordinate.latitude];
                locationModel.longitudeStr=[NSString stringWithFormat:@"%f",coordinate.longitude];
                for (CLPlacemark * placemark in placemarks) {
                    NSDictionary *areaDic = [placemark addressDictionary];
                    //  Country(国家)  State(城市)  SubLocality(区)
                    NSLog(@"%@", [areaDic objectForKey:@"Country"]);
                    NSLog(@"%@", [areaDic objectForKey:@"State"]);
                    NSLog(@"%@", [areaDic objectForKey:@"SubLocality"]);
                    NSLog(@"%@", [areaDic objectForKey:@"Street"]);
                    
                    locationModel.location=currentLocation;
                    locationModel.countryStr=[NSString stringWithFormat:@"%@",[areaDic objectForKey:@"Country"]];
                    locationModel.provincesStr=[NSString stringWithFormat:@"%@",[areaDic objectForKey:@"State"]];
                    locationModel.cityStr=[NSString stringWithFormat:@"%@",[areaDic objectForKey:@"City"]];
                    locationModel.subLocalityStr=[NSString stringWithFormat:@"%@",[areaDic objectForKey:@"SubLocality"]];
                    locationModel.addressStr=[NSString stringWithFormat:@"%@",[areaDic objectForKey:@"Street"]];
                }
                self.locationHandlerBlock(locationModel);
            
                
            }
          
            
        }else if (error == nil && placemarks.count == 0) {
            NSLog(@"No location and error return");
            [SVProgressHUD showInfoWithStatus:@"当前无法定位"];
        }else if (error) {
            NSLog(@"location error: %@ ",error);
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",error.localizedDescription]];
        }
        
    }];
    
    [manager stopUpdatingLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(nonnull NSError *)error{
    
    [SVProgressHUD showInfoWithStatus:@"请在设置中打开定位"];
}




@end











#pragma mark - LocationHandlerDataModel类
@interface LocationHandlerDataModel ()

@end
@implementation LocationHandlerDataModel


@end
