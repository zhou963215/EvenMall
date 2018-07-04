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



#import "LocationManger.h"

@interface HomeViewController ()<seletedControllerDelegate>

@property (nonatomic, strong) ScrollView *titleScroll;

@property (nonatomic, strong) UIScrollView * mainScroll;

@property (nonatomic, strong) HomeTypeModel * model;

@property (nonatomic, strong) LocationManger * locationManger;

@property (nonatomic, strong) BMKPoiInfo * chosePoi;

@property (nonatomic, assign) BOOL isReady;

@property (nonatomic, copy) NSArray * locationArray;

@property (nonatomic, strong) NSMutableArray * controllerArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self creatNavView];
    _locationManger = [LocationManger shareInstance];
    [_locationManger.location startUserLocationService];
    WEAKSELF(wk);
    _locationManger.loactionCallBack = ^(NSDictionary * dict) {
        
        
        wk.locationArray = dict[@"data"];
        [wk RefreshAES];
        EDULog(@"%@",dict);
        
    };
    

    
    

}


- (void)RefreshAES{
    
    
    [PublicVoid RefreshAES:^(BOOL isRefsh) {
        
        if (isRefsh) {
            
            [self requestType];
        }
        
    }];
    
}

- (void)requestType{
    
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:3001 parameters:@{} success:^(id  _Nonnull responseObject) {
        
        
        self.model = [HomeTypeModel modelWithDictionary:responseObject];
        self.titleScroll.headArray = [[NSMutableArray alloc]initWithArray:self.model.data];
        [self chlidViewAdd];
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
}


- (void)chlidViewAdd{
    
    if (self.model) {
        
        
        CLLocationCoordinate2D pt ;
        
        if (self.locationArray.count > 0) {
            
            BMKPoiInfo * info  = self.locationArray[0];
            
            pt = info.pt;
            
            
        }else{
            
            pt  = CLLocationCoordinate2DMake(0, 0);
        }
        
        
        for (int i = 0; i < self.model.data.count; i ++) {
            
            HomeTypeDetailModel * model = self.model.data[i];
            
            HomeChildViewController  * vc = [HomeChildViewController new];
            vc.model = model;
            vc.pt = pt;
            vc.view.frame = CGRectMake(WIDTH * i, 0, WIDTH, self.mainScroll.frame.size.height);
            [self.mainScroll addSubview:vc.view];
            [self addChildViewController:vc];
            [vc refshData];
            
        }
        
    }
    
    
   
    
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
        _mainScroll.contentSize = CGSizeMake(WIDTH*5, 0);
        _mainScroll.pagingEnabled = YES;
        [self.view addSubview:_mainScroll];
        
        
    }
    
    
    return _mainScroll;
}

- (void)creatNavView{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    [self.navigationView addSubview:imageView clickCallback:^(UIView *view) {
        
        
    }];

    WEAKSELF(wk);
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk.navigationView);
        make.right.equalTo(wk.navigationView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(80, 30));
        
        
    }];
    
   
    
    
    
}


-(void)seletedControllerWith:(UIButton *)btn{
    
//    [self.dataArray removeAllObjects];
//    _page = 1;
//    ArticleDetailTagModel * articel = self.model.datas[btn.tag-1000];
//    self.articleTag = articel.dataId;
//    [self refreshData];
    
    [_titleScroll changeBtntitleColorWith:(int)btn.tag];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
