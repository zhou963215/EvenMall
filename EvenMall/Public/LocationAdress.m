//
//  LocationAdress.m
//  GoodMedical
//
//  Created by zhou on 2017/8/16.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "LocationAdress.h"
@interface LocationAdress ()

@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//市
@property (nonatomic,assign) BOOL isAdress;

@end

@implementation LocationAdress

- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        [self locatemap];

    }
    
    return self;
}

- (void)locatemap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    [ZHHud initWithMessage:@"请在设置中打开定位功能"];
    
    
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//        NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//        if (locationAge > 1.0){//如果调用已经一次，不再执行
//            return;
//        }
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    WEAKSELF(wk)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (wk.isAdress) {
            
            return ;
        }else{
            wk.isAdress = YES;
        }
    
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            wk.currentCity = placeMark.locality;
            if (!wk.currentCity) {
                wk.currentCity = @"无法定位当前城市";
            }
            //看需求定义一个全局变量来接收赋值
            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
            NSLog(@"当前省市 - %@",placeMark.administrativeArea);//当前省
            NSLog(@"当前城市 - %@",wk.currentCity);//当前城市
            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
            
            if (wk.adress) {
                
                wk.adress(placeMark.administrativeArea, wk.currentCity, placeMark.subLocality);
                
            }
            
            [wk.locationManager stopUpdatingLocation];

        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
}





@end
