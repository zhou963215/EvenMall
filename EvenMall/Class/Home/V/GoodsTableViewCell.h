//
//  GoodsTableViewCell.h
//  EvenMall
//
//  Created by xuechuan on 2018/7/5.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) void (^goodsAdd)(BOOL );


@end
