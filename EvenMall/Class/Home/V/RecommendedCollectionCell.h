//
//  RecommendedCollectionCell.h
//  EvenMall
//
//  Created by xuechuan on 2018/7/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendedCollectionCell : UICollectionViewCell
@property (nonatomic, copy) void (^goodsAdd)(BOOL );
@property (nonatomic, assign) NSInteger count;

@end
