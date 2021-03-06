//
//  HomeViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/15.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeViewController.h"
#import "ScrollView.h"
#import "HomeChildViewController.h"
#import "RSAEncryptor.h"

#import "LoginViewController.h"

#import "HomeTypeModel.h"

#import <CoreLocation/CoreLocation.h>

#import "LocationManger.h"

#import "AdressSelectViewController.h"

#import "HomeModel.h"

@interface HomeViewController ()<seletedControllerDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) ScrollView *titleScroll;

@property (nonatomic, strong) UIScrollView * mainScroll;

@property (nonatomic, strong) HomeTypeModel * model;

@property (nonatomic, strong) LocationManger * locationManger;

@property (nonatomic, strong) BMKPoiInfo * chosePoi;

@property (nonatomic, assign) BOOL isReady;

@property (nonatomic, copy) NSArray * locationArray;

@property (nonatomic, strong) NSMutableArray * controllerArray;

@property (nonatomic, strong) UIButton * addressBtn;

@property (nonatomic, copy) NSString * city;

@property (nonatomic, strong) CLLocationManager* location;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _location = [[CLLocationManager alloc]init];
    _location.delegate = self;
    
    [self creatNavView];
    _locationManger = [LocationManger shareInstance];
    [_locationManger.location startUserLocationService];
    WEAKSELF(wk);
//    _locationManger.loactionCallBack = ^(NSDictionary * dict) {
//
//
//        wk.locationArray = dict[@"data"];
//        wk.chosePoi = wk.locationArray[0];
//        wk.city  = dict[@"city"];
//        [wk.addressBtn setTitle:wk.chosePoi.name forState:UIControlStateNormal];
//
//
//        EDULog(@"%@",dict);
//
//    };
    [wk RefreshAES];

}


- (void)RefreshAES{
    
    
    [PublicVoid RefreshAES:^(BOOL isRefsh) {
        
        if (isRefsh) {
            
            [self requestType];
        }
        
    }];
    
}

- (void)requestType{
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:3011 parameters:@{@"lng" :@(113.686972),@"lat" : @(34.767322)} success:^(id  _Nonnull responseObject) {
        
        
        HomeModel * model = [HomeModel modelWithDictionary:responseObject[@"data"]];
        
        NSLog(@"11111");
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}

//
//- (void)chlidViewAdd{
//
//    if (self.model) {
//
//
//        CLLocationCoordinate2D pt ;
//
//        if (self.locationArray.count > 0) {
//
//            BMKPoiInfo * info  = self.locationArray[0];
//
//            pt = info.pt;
//
//
//        }else{
//
//            pt  = CLLocationCoordinate2DMake(0, 0);
//        }
//
//        pt  = CLLocationCoordinate2DMake(34.767322, 113.686972);
//        for (int i = 0; i < self.model.data.count; i ++) {
//
//            HomeTypeDetailModel * model = self.model.data[i];
//            // lng: 113.686972 lat: 34.767322
//            EDULog(@"%d",i);
//            HomeChildViewController  * vc = [HomeChildViewController new];
//            vc.model = model;
//            vc.pt = pt;
//            vc.view.frame = CGRectMake(WIDTH * i, 0, WIDTH, self.mainScroll.frame.size.height);
//            [self.mainScroll addSubview:vc.view];
//            [self addChildViewController:vc];
////            [vc refshData];
//
//        }
//
//    }
//
//
//
//
//}


#pragma ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x/WIDTH;
    
    
    [_titleScroll changeBtntitleColorWith:index+1000];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    
    NSInteger index = scrollView.contentOffset.x/WIDTH;
    
    
    [_titleScroll changeBtntitleColorWith:index+1000];
}



- (ScrollView *)titleScroll{
    
    if (!_titleScroll) {
        
        _titleScroll= [[ScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, WIDTH, 50)];
        //    _titleScroll.headArray = [self.model.datas mutableCopy];
        _titleScroll.SeletedDelegate = self;
        [self.view addSubview:_titleScroll];
    }
    
    return _titleScroll;
}
- (UIScrollView *)mainScroll{
    
    if (!_mainScroll) {
        
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavHeight+50, WIDTH, FULL_HEIGHT-50-49)];
        _mainScroll.contentSize = CGSizeMake(WIDTH*self.model.data.count, 0);
        _mainScroll.pagingEnabled = YES;
        _mainScroll.delegate = self;
        [self.view addSubview:_mainScroll];
        
        
    }
    
    
    return _mainScroll;
}

- (void)creatNavView{
    
    WEAKSELF(wk);
    _addressBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    _addressBtn.backgroundColor = [UIColor redColor];
//    [_addressBtn setTitle:@"硅谷广场" forState:UIControlStateNormal];
    
    [self.navigationView addSubview:_addressBtn clickCallback:^(UIView *view) {
        
        AdressSelectViewController * vc = [[AdressSelectViewController alloc]init];

        vc.locationArray = wk.locationArray;
        vc.city = wk.city;
        [wk.navigationController pushViewController:vc animated:YES];
//
//        LoginViewController * vc = [LoginViewController new];
//        [wk presentViewController:vc animated:YES completion:nil];
        
    }];

    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(wk.navigationView).offset(-5);
        make.centerX.equalTo(wk.navigationView);
        make.height.mas_equalTo(30);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
        
        
    }];
    
   
    
    
    
}


-(void)seletedControllerWith:(UIButton *)btn{
    
    
    [_mainScroll setContentOffset:CGPointMake(WIDTH * (btn.tag-1000), 0) animated:YES];

    [_titleScroll changeBtntitleColorWith:(int)btn.tag];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined) {
        [_locationManger.location startUserLocationService];

//        [self beginGPS];
    }
        switch (status) {
            case kCLAuthorizationStatusNotDetermined:
            {
                NSLog(@"用户还未决定授权");
                break;
            }
            case kCLAuthorizationStatusRestricted:
            {
                NSLog(@"访问受限");
                break;
            }
            case kCLAuthorizationStatusDenied:
            {
                // 类方法，判断是否开启定位服务
                if ([CLLocationManager locationServicesEnabled]) {
                    NSLog(@"定位服务开启，被拒绝");
                } else {
                    NSLog(@"定位服务关闭，不可用");
                }
                break;
            }
            case kCLAuthorizationStatusAuthorizedAlways:
            {
                
                [_locationManger.location startUserLocationService];

                NSLog(@"获得前后台授权");
                break;
            }
            case kCLAuthorizationStatusAuthorizedWhenInUse:
            {
                [_locationManger.location startUserLocationService];

                NSLog(@"获得前台授权");
                break;
            }
            default:
                break;
        }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
