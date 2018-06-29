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
@interface HomeViewController ()<seletedControllerDelegate>

@property (nonatomic, strong) ScrollView *titleScroll;
@property (nonatomic, strong) UIScrollView * mainScroll;

@property (nonatomic, strong) HomeTypeModel * model;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    
    
    
    [PublicVoid RefreshAES:^(BOOL isRefsh) {
        
        if (isRefsh) {
            
            [self requestType];
        }
        
    }];
   
    
//    NSArray * arr = @[@"熟食",@"水果",@"生鲜",@"饮料",@"日用",@"百货"];
//    
//    self.titleScroll.headArray = [[NSMutableArray alloc]initWithArray:arr];
//    
//    for (int i = 0; i < arr.count; i ++) {
//        
//        HomeChildViewController  * vc = [HomeChildViewController new];
//        vc.view.frame = CGRectMake(WIDTH * i, 0, WIDTH, self.mainScroll.frame.size.height);
//        [self.mainScroll addSubview:vc.view];
//        [self addChildViewController:vc];
//        
//        
//    }
    
    

}


- (void)requestType{
    
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:3001 parameters:@{} success:^(id  _Nonnull responseObject) {
        
        
        self.model = [HomeTypeModel modelWithDictionary:responseObject];
        self.titleScroll.headArray = [[NSMutableArray alloc]initWithArray:self.model.data];
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
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
