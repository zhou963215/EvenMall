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

@interface HomeChildViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.view addSubview:self.tableView];
    WEAKSELF(wk);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.left.right.equalTo(wk.view);
    }];
    
}


- (void)refshData{
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:3009 parameters:@{@"catId":self.model.catId , @"lng" :@(self.pt.longitude),@"lat" : @(self.pt.latitude) } success:^(id  _Nonnull responseObject) {
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        
        
    }];
    
    
    
    
}




#pragma mark - UITableViewDataSource, UITableViewDelegate




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    GoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"goods"];
    
    cell.count = 0;
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
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"goods"];
    }
    return _tableView;
}


@end
