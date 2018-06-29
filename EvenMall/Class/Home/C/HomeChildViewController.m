//
//  HomeChildViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/21.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeChildViewController.h"
#import "EMTabBarControllerConfig.h"

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

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"点击将商品添加到购物车";
    cell.imageView.image = [UIImage imageNamed:@"shopping"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self addProductsAnimation:cell.imageView dropToPoint:CGPointMake(WIDTH*0.65, self.view.layer.bounds.size.height - 40) isNeedNotification:YES];
    
    UIViewController *vc = self.tabBarController.viewControllers[2];
    NSInteger badgeValue = [vc.tabBarItem.badgeValue integerValue];
    badgeValue += 1;

    self.addShopCarFinished = ^{
        
        vc.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", badgeValue];
        NSLog(@"完成了动画（如果不使用通知的方式，可以使用这种方式）");
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 88;
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


@end
