//
//  GDHTableViewCell.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "GDHTableViewCell.h"
#import "SDCycleScrollView.h"
@interface GDHTableViewCell()


@property (weak, nonatomic) IBOutlet SDCycleScrollView *imageScrollView;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *memberPriceLB;

@property (weak, nonatomic) IBOutlet UILabel *oldPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *countLB;

@end



@implementation GDHTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}


- (void)setImageArray:(NSArray *)imageArray{
    
    _imageArray = imageArray;
    
    _imageScrollView.imageURLStringsGroup = _imageArray;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
