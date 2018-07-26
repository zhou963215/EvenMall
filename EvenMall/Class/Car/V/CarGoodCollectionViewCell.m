//
//  CarGoodCollectionViewCell.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/25.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "CarGoodCollectionViewCell.h"

@interface CarGoodCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *selcetBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property (weak, nonatomic) IBOutlet UILabel *memberPrice;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *reductionBtn;

@property (weak, nonatomic) IBOutlet UILabel *countLB;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end


@implementation CarGoodCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCount:(NSInteger)count{
    
    _count = count;
    _countLB.text = [NSString stringWithFormat:@"%ld",(long)_count];

    
    
    
}

- (IBAction)selectBtnClick:(id)sender {
    
    
    
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
