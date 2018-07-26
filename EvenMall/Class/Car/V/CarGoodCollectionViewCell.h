//
//  CarGoodCollectionViewCell.h
//  EvenMall
//
//  Created by xuechuan on 2018/7/25.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarGoodCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) void (^goodsAdd)(BOOL );
@property (nonatomic, assign) NSInteger count;

@end
