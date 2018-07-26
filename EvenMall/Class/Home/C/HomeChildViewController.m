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

#import "GoodsHeadCollectionViewCell.h"

#import "GoodDetailViewController.h"
@interface HomeChildViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomeListModel * listModel;

@property (nonatomic, strong) NSMutableArray * goodsListArray;

@property (nonatomic ,strong) SDCycleScrollView *sdcScroll;

@property(nonatomic, strong) NSMutableArray *sdcSoure;

@property (nonatomic, strong) UICollectionView * collectionView;

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
    NSInteger lastIndex = 0;
    for (HomeListCategoryModel * categoryModel in self.listModel.category) {
        
        index += lastIndex;
        lastIndex = categoryModel.goodsList.count;
        categoryModel.index = index;
        [self.goodsListArray addObjectsFromArray:categoryModel.goodsList];
        
        
    }
    
    NSMutableArray  * imageArray = [[NSMutableArray alloc]init];
    
    for (HomeListBannerModel * banner in self.listModel.banner) {
        
        
        [imageArray addObject:@"http://c.hiphotos.baidu.com/image/pic/item/a5c27d1ed21b0ef4b129b3b9d1c451da80cb3e17.jpg"];
        
    }
    self.sdcScroll.imageURLStringsGroup = [imageArray mutableCopy];;
    
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
    
    
//            LoginViewController * vc = [LoginViewController new];
//            [self presentViewController:vc animated:YES completion:nil];
    
    
    [self.navigationController pushViewController:[GoodDetailViewController new] animated:YES];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    if([self.model.catId isEqualToString:@"0"]){
        
        return 0.1;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (![self.model.catId isEqualToString:@"0"]) {
        
        [self.collectionView reloadData];
        
        return self.collectionView;
    }
    
    
    return nil;
}


#pragma SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    
    
    
}


#pragma UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(20, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(20, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     HomeListCategoryModel * category= self.listModel.category[indexPath.row];
    
    CGFloat width = [self widthForLabel:[NSString stringWithFormat:@"%@",category.catName] fontSize:12];
    return CGSizeMake(width+40,20);
}
//计算问题宽度
- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    
    return size.width;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
   
    return self.listModel.category.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeListCategoryModel * category= self.listModel.category[indexPath.row];

    GoodsHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"head" forIndexPath:indexPath];
    cell.nameLB.text = category.catName;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HomeListCategoryModel * category= self.listModel.category[indexPath.row];
    NSIndexPath* indexPat = [NSIndexPath indexPathForRow:category.index inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma 懒加载

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 130;
        [_tableView registerNib:[UINib nibWithNibName:@"GoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"goods"];
        [self.view addSubview:self.tableView];
        
        WEAKSELF(wk);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.bottom.left.right.equalTo(wk.view);
        }];
    }
    return _tableView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 5;
        flowLayout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 0,WIDTH-40,40) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        //注册
        [_collectionView registerNib:[UINib nibWithNibName:@"GoodsHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"head"];
        
    }
    
    return _collectionView;
}


- (NSMutableArray *)goodsListArray{
    
    if (!_goodsListArray) {
        
        _goodsListArray = [[NSMutableArray alloc]init];
    }
    
    return _goodsListArray;
}


@end
