//
//  GDMTableViewCell.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "GDMTableViewCell.h"
#import "RecommendedCollectionCell.h"
@interface GDMTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end



@implementation GDMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH-40)/2, 230);
    flowLayout.minimumLineSpacing = 20;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection  = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView.collectionViewLayout = flowLayout;
    [_collectionView registerNib:[UINib nibWithNibName:@"RecommendedCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RecommendedCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.count = 0;
    
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
