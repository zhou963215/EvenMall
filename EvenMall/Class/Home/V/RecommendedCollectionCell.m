//
//  RecommendedCollectionCell.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/26.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "RecommendedCollectionCell.h"

@interface RecommendedCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *memberPriceLB;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLB;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *countLB;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIButton *reductionBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addWidth;

@end


@implementation RecommendedCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCount:(NSInteger)count{
    
    _count = count;
    
    if (_count == 0) {
        
        _reductionBtn.hidden = YES;
        _countLB.hidden = YES;
        _addHeight.constant = 30;
        _addWidth.constant = 30;
        
    }else{
        
        _reductionBtn.hidden = NO;
        _countLB.hidden = NO;
        _addHeight.constant = 20;
        _addWidth.constant = 20;
        _countLB.text = [NSString stringWithFormat:@"%ld",(long)_count];
    }
    
    
    
}
- (IBAction)reductionClick:(id)sender {
    
    
    if (self.count == 0) {
        
        self.count = 0;
        return;
    }
    self.count -=1;
    if (self.goodsAdd) {
        
        self.goodsAdd(NO);
        
    }
}
- (IBAction)addClick:(id)sender {
    
    self.count +=1;
    
    if (self.goodsAdd) {
        
        self.goodsAdd(YES);
        
    }
}

@end
