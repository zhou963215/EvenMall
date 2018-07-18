//
//  LocationManger.h
//  EvenMall
//
//  Created by xuechuan on 2018/7/2.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

@interface LocationManger : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, copy) void (^loactionCallBack)(NSDictionary *);
@property (nonatomic, strong) BMKLocationService * location;
@property (nonatomic, strong) BMKGeoCodeSearch * geocodesearch;

- (void)searchWith:(NSString *)city keyword:(NSString *)keyword;//根据名称搜索

@end
