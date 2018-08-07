//
//  CarViewController.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/15.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "CarViewController.h"
#import "CarGoodCollectionViewCell.h"
@interface CarViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) UIButton * adressBtn;

@property (nonatomic, strong) UIButton * allSelectBtn;

@property (nonatomic, strong) UILabel * combinedPriceLB;

@end

@implementation CarViewController


- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    [self creatTopBottmView];
    [self.view addSubview:self.collectionView];
    
}


- (void)requestData{
    
    
    [[ZHNetWorking sharedZHNetWorking]POSTAES:5001 parameters:@{} success:^(id  _Nonnull responseObject) {
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
    }];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarGoodCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"car" forIndexPath:indexPath];
    
    
    return cell;
}



- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(WIDTH, 130);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection  = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"CarGoodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"car"];
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView;
}


- (void)creatTopBottmView{
    
    _adressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _adressBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_adressBtn setTitle:@"硅谷广场" forState:UIControlStateNormal];
    [_adressBtn setTitleColor:UICOLORRGB(0x6a6a6a) forState:UIControlStateNormal];
    [self.view addSubview:_adressBtn];
    
    UIImageView * adress = [[UIImageView alloc]init];
    adress.backgroundColor = [UIColor redColor];
    [self.view addSubview:adress];
    
    UIImageView * right = [[UIImageView alloc]init];
    right.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:right];
    
    UIView * line = [UIView new];
    line.backgroundColor = UICOLORRGB(0x2F3922);
    [self.view addSubview:line];
    
    _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_allSelectBtn setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:_allSelectBtn];
    
    UILabel * label = [UILabel new];
    label.text = @"全国送商品";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    UILabel * combinedLB =[UILabel new];
    combinedLB.text = @"合计";
    [self.view addSubview:combinedLB];
    
    _combinedPriceLB = [UILabel new];
    _combinedPriceLB.textColor = UICOLORRGB(0xFF4892);
    _combinedPriceLB.text= @"¥61.8";
    [self.view addSubview:_combinedPriceLB];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:UICOLORRGB(0xFF4892)];
    [self.view addSubview:submitBtn];
    
    
    
    WEAKSELF(wk);
    
    [_adressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(wk.view);
        make.top.equalTo(wk.navigationView.mas_bottom).offset(5);
        
        
    }];
    
    [adress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk.adressBtn);
        make.right.equalTo(wk.adressBtn.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(20, 30));
        
    }];
    
    
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(wk.adressBtn);
        make.left.equalTo(wk.adressBtn.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(18, 10));
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(adress.mas_bottom).offset(10);
        make.height.mas_equalTo(0.5);
        
    }];
    
    
    [_allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.top.equalTo(line.mas_bottom).offset(10);
        
        
        
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.allSelectBtn.mas_right).offset(5);
        make.centerY.equalTo(wk.allSelectBtn);
        
        
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(wk.view);
        make.top.equalTo(wk.allSelectBtn.mas_bottom).offset(10);
        make.bottom.equalTo(submitBtn.mas_top);
        
    }];
    
    [combinedLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(wk.view).offset(10);
        make.centerY.equalTo(submitBtn);
        
        
    }];
    
    [_combinedPriceLB mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(combinedLB.mas_right).offset(5);
        make.centerY.equalTo(submitBtn);
    }];
    
    
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.bottom.equalTo(wk.view);
        make.size.mas_equalTo(CGSizeMake(110, 40));
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];



}




@end
