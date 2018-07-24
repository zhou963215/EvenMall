//
//  HomeChildViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/21.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeChildViewController.h"
#import "EMTabBarControllerConfig.h"
#import "GoodsTableViewCell.h"

#import "LoginViewController.h"

#import "HomeListModel.h"

#import "SDCycleScrollView.h"
@interface HomeChildViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomeListModel * listModel;

@property (nonatomic, strong) NSMutableArray * goodsListArray;

@property(nonatomic,strong)SDCycleScrollView *sdcScroll;

@property(nonatomic,strong)NSMutableArray *sdcSoure;

@end

@implementation HomeChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _sdcSoure = [[NSMutableArray alloc]init];

    self.tableView.tableHeaderView = self.sdcScroll;
    [self refshData];
    
}

- (SDCycleScrollView *)sdcScroll{
    
    if (!_sdcScroll) {
        
        _sdcScroll= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 180) imageURLStringsGroup:_sdcSoure];
        _sdcScroll.autoScrollTimeInterval = 2.5;
        _sdcScroll.delegate = self;
        _sdcScroll.pageDotColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _sdcScroll.currentPageDotColor = [UIColor whiteColor];
        _sdcScroll.placeholderImage = [UIImage imageNamed:@"placeholder"];
        _sdcScroll.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        
    }
    return _sdcScroll;
    
}
- (void)refshData{
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:3009 parameters:@{@"catId":self.model.catId , @"lng" :@(self.pt.longitude),@"lat" : @(self.pt.latitude) } success:^(id  _Nonnull responseObject) {
        
        self.listModel = [HomeListModel modelWithDictionary:responseObject[@"data"]];
        
        [self mergeGoodsList];
        
    } failure:^(NSError * _Nonnull error) {
        
        
        
        
        
    }];
    
    
    
    
}


- (void)mergeGoodsList{
    
    
    NSInteger index = 0;
    
    for (HomeListCategoryModel * categoryModel in self.listModel.category) {
        
        index += categoryModel.goodsList.count;
        categoryModel.index = index;
        [self.goodsListArray addObjectsFromArray:categoryModel.goodsList];
        
        
    }
    self.sdcScroll.imageURLStringsGroup = self.listModel.banner;
    
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    GoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"goods"];
    
    cell.count = 0;
    cell.model = self.goodsListArray[indexPath.row];
    WEAKSELF(wk);
    __weak GoodsTableViewCell * good = cell;
    cell.goodsAdd = ^(BOOL isAdd) {
        
        UIViewController *vc = wk.tabBarController.viewControllers[2];
        NSInteger badgeValue = [vc.tabBarItem.badgeValue integerValue];
        if (isAdd) {
            
            [wk addProductsAnimation:good.headImg dropToPoint:CGPointMake(WIDTH*0.65, self.view.layer.bounds.size.height - 40) isNeedNotification:YES];
            
            
            
            badgeValue += 1;
            WEAKSELF(wk);
            wk.addShopCarFinished = ^{
                
                vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", badgeValue];
//                [wk presentViewController:[LoginViewController new] animated:YES completion:nil];
                NSLog(@"完成了动画（如果不使用通知的方式，可以使用这种方式）");
            };
        }else{
            
            
            badgeValue -=1;
            if (badgeValue == 0) {
                
                vc.tabBarItem.badgeValue = nil;
            }else{
                
                vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", badgeValue];

            }
        }
        
       
        
    };
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"goods"];
        [self.view addSubview:self.tableView];
        
        WEAKSELF(wk);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.left.right.equalTo(wk.view);
        }];
    }
    return _tableView;
}

- (NSMutableArray *)goodsListArray{
    
    if (!_goodsListArray) {
        
        _goodsListArray = [[NSMutableArray alloc]init];
    }
    
    return _goodsListArray;
}


@end
