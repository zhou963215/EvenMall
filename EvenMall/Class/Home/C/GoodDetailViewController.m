
//
//  GoodDetailViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "GDHTableViewCell.h"
#import "GDDTableViewCell.h"
#import "GDMTableViewCell.h"
@interface GoodDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) UILabel * countLB;

@end

@implementation GoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.tableView reloadData];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 1;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 300;
    }
    if (indexPath.section == 1) {
        
        return 125;
    }
    if (indexPath.section == 2) {
        
        return 250;
    }
    
    
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section==1 || section ==2) {
        
        return 44;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section==1 || section ==2) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
        
        UILabel * titleLB = [UILabel new];
        titleLB.text = section ==1? @"商品详情" :@"推荐商品";
        [view addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            
            make.left.equalTo(view).offset(10);
            make.centerY.equalTo(view);
        }];
        
        
        return view;
    }
    
    
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section ==0) {
        GDHTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"goods"];
        
        cell.imageArray = @[@"http://a.hiphotos.baidu.com/image/pic/item/b64543a98226cffceee78e5eb5014a90f703ea09.jpg"];
        
        
        return cell;
    }
    
    if (indexPath.section ==1) {
        GDDTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
        
        
        return cell;
    }
    
    if (indexPath.section ==2) {
        
        GDMTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"more"];
        
       
        
        return cell;
    }
    
    
    
    return [UITableViewCell new];
}


- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"GDHTableViewCell" bundle:nil] forCellReuseIdentifier:@"goods"];
         [_tableView registerNib:[UINib nibWithNibName:@"GDDTableViewCell" bundle:nil] forCellReuseIdentifier:@"detail"];
         [_tableView registerNib:[UINib nibWithNibName:@"GDMTableViewCell" bundle:nil] forCellReuseIdentifier:@"more"];
        [self.view addSubview:self.tableView];
        
        WEAKSELF(wk);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.left.right.equalTo(wk.view);
            make.top.equalTo(wk.navigationView.mas_bottom);
        }];
    }
    return _tableView;
}

- (void)creatBottomViews{
    
    
    
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}



@end
