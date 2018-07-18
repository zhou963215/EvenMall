//
//  AdressSelectViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/11.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "AdressSelectViewController.h"
#import "AdressRefshTableViewCell.h"
@interface AdressSelectViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AdressRefshTableViewCell * refshCell;


@end

@implementation AdressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    WEAKSELF(wk);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.left.right.equalTo(wk.view);
    }];
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    
    UILabel * label = [UILabel new];
    label.font  = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(16);
        make.right.equalTo(view).offset(-16);
        
    }];
    
    if (section == 0) {
        label.text = @"请您选择准确的收货地址";
    }else{
        
        label.text = @"附近地址";

    }
    
    
    
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    
    return self.locationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        
        
        
        return self.refshCell;
    }else if (indexPath.section == 0){
        
        
        
        
    }
    
    
    
    return [UITableViewCell new];
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (AdressRefshTableViewCell *)refshCell{
    
    if (_refshCell) {
        
        _refshCell = [[[NSBundle mainBundle]loadNibNamed:@"AdressRefshTableViewCell" owner:self options:nil]firstObject];
    }
    
    
    return _refshCell;
}


@end
