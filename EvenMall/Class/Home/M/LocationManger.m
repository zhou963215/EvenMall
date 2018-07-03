//
//  LocationManger.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/2.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "LocationManger.h"

@interface LocationManger ()<BMKLocationServiceDelegate,CLLocationManagerDelegate, BMKGeneralDelegate,BMKGeoCodeSearchDelegate>
{
    
    BMKPoiInfo * chosePoi;
    
    
}

@property (nonatomic, strong) BMKGeoCodeSearch * geocodesearch;

@property BOOL isGeoSearch;

@end

@implementation LocationManger


+ (instancetype)shareInstance{
    
    static LocationManger *shareInstance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[LocationManger alloc]init];
    });
    
    return shareInstance;
}

- (BMKLocationService *)location
{
    if (!_location)
    {
        _location = [[BMKLocationService alloc] init];
        _location.delegate = self;
    }
    return _location;
}

//检索对象
- (BMKGeoCodeSearch *)geocodesearch
{
    if (!_geocodesearch)
    {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}

//定位失败
- (void)didFailToLocateUserWithError:(NSError *)error{
    
//    [ZHHud initWithMessage:@"定位失败"];
    
    if (self.location) {
        
        NSDictionary * dict = @{@"isFinish" : @(YES) ,@"data" : @[]};
        
        
        self.loactionCallBack(dict);
    }
    
}

//定位完成
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    
    if ((userLocation.location.coordinate.latitude != 0 || userLocation.location.coordinate.longitude != 0))
    {
        
        
        //发送反编码请求
        [self sendBMKReverseGeoCodeOptionRequest];
        
        NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
        
        EDULog(@"latitude----%@---longitude----%@",latitude,longitude);
        
    }else{
        NSLog(@"位置为空");
    }
    
    //关闭坐标更新
    [self.location stopUserLocationService];
    
}

#pragma mark ----反向地理编码
- (void)reverseGeoCodeWithLatitude:(NSString *)latitude withLongitude:(NSString *)longitude
{
    
    //发起反向地理编码检索
    
    CLLocationCoordinate2D coor;
    coor.latitude = [latitude doubleValue];
    coor.longitude = [longitude doubleValue];
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
    reverseGeocodeSearchOption.reverseGeoPoint = coor;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];;
    if (flag)
    {
        NSLog(@"反地理编码成功");//可注释
    }
    else
    {
        
        if (self.location) {
            
            NSDictionary * dict = @{@"isFinish" : @(YES) ,@"data" : @[]};
            
            
            self.loactionCallBack(dict);
        }
        NSLog(@"反地理编码失败");//可注释
    }
}



//发送反编码请求
- (void)sendBMKReverseGeoCodeOptionRequest{
    
    self.isGeoSearch = false;
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (_location.userLocation.location.coordinate.longitude!= 0
        && _location.userLocation.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){_location.userLocation.location.coordinate.latitude,
            _location.userLocation.location.coordinate.longitude};
    }
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}


//发送成功,百度将会返回东西给你
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                          result:(BMKReverseGeoCodeResult *)result
                       errorCode:(BMKSearchErrorCode)error
{
    
    if (error == BMK_SEARCH_NO_ERROR) {
        NSString *address1 = result.address; // result.addressDetail ///层次化地址信息
        NSLog(@"我的位置在 %@",address1);
        
        if (self.location) {
            
            NSDictionary * dict = @{@"isFinish" : @(YES) ,@"data" : result.poiList};
            
            
            self.loactionCallBack(dict);
        }
        
//        chosePoi = (BMKPoiInfo *)result.poiList[0];
        
        //保存位置信息到模型
        //        [self.userLocationInfoModel saveLocationInfoWithBMKReverseGeoCodeResult:result];
        
        //进行缓存处理，上传到服务器等操作
    }
    
    
}

@end
