//
//  AdressSelectViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/11.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "AdressSelectViewController.h"
#import "AdressRefshTableViewCell.h"
#import "AdressSearchTableViewCell.h"
#import "LocationManger.h"

@interface AdressSelectViewController ()<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) AdressRefshTableViewCell * refshCell;

@property (nonatomic, strong) AdressSearchTableViewCell * searchCell;

@property (nonatomic, strong) LocationManger * locationManger;

@end

@implementation AdressSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WEAKSELF(wk);
    [self.tableView reloadData];
   _locationManger = [LocationManger shareInstance];
    
    _locationManger.loactionCallBack = ^(NSDictionary * dict) {
        
        
        wk.locationArray = dict[@"data"];
        [wk.tableView reloadData];
        
    };
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0.1;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return nil;
    }
    
    UIView  * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [UILabel new];
    label.font  = [UIFont systemFontOfSize:12];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(16);
        make.right.equalTo(view).offset(-16);
        
    }];
    
    if (section == 1) {
        label.text = @"请您选择准确的收货地址";
    }else if(section == 2){
        
        label.text = @"附近地址";

    }
    
    
    
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section != 2) {
        
        return 1;
    }
    
    return self.locationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        [self.searchCell.cityBtn setTitle:self.city forState:UIControlStateNormal];
        self.searchCell.searchBar.delegate = self;
        
        return self.searchCell;
    }
    
    
    if (indexPath.section == 1) {
        
        BMKPoiInfo * chosePoi = self.locationArray[0];
        self.refshCell.nameLB.text = chosePoi.name;
        
        return self.refshCell;
    }else if (indexPath.section == 2){
        
        BMKPoiInfo * chosePoi = self.locationArray[indexPath.row];

        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        cell.textLabel.text = chosePoi.name;
        
        return cell;
    }
    
    
    
    return [UITableViewCell new];
}

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = 44;
        _tableView.delegate = self;
        _tableView.dataSource = self;

        [self.view addSubview:self.tableView];
        WEAKSELF(wk);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.left.right.equalTo(wk.view);
            make.top.equalTo(wk.navigationView.mas_bottom);
        }];
        
    }
    return _tableView;
}

- (AdressRefshTableViewCell *)refshCell{
    
    if (!_refshCell) {
        
        _refshCell = [[[NSBundle mainBundle]loadNibNamed:@"AdressRefshTableViewCell" owner:self options:nil]firstObject];
        [_refshCell.refshBtn addTarget:self action:@selector(refshLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _refshCell;
}

- (AdressSearchTableViewCell *)searchCell{
    
    if (!_searchCell) {
        
        _searchCell = [[[NSBundle mainBundle]loadNibNamed:@"AdressSearchTableViewCell" owner:self options:nil]firstObject];
        [_searchCell.cityBtn addTarget:self action:@selector(cityPush) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return _searchCell;
}

- (void)refshLocation{
    
    [_locationManger.location startUserLocationService];

    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    EDULog(@"%@",searchBar.text);
    [searchBar resignFirstResponder];
    [_locationManger searchWith:_city keyword:searchBar.text];
    
    
}
- (void)cityPush{
    
    
    
    
}

@end
