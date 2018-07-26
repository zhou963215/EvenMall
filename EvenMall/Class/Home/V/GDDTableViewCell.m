//
//  GDDTableViewCell.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "GDDTableViewCell.h"
@interface GDDTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *weightLB;

@property (weak, nonatomic) IBOutlet UILabel *packagingLB;
@property (weak, nonatomic) IBOutlet UILabel *useLB;

@property (weak, nonatomic) IBOutlet UILabel *storageLB;

@end
@implementation GDDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
