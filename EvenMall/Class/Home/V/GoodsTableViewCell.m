//
//  GoodsTableViewCell.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/5.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "GoodsTableViewCell.h"

@interface GoodsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *contentLB;

@property (weak, nonatomic) IBOutlet UILabel *memberPrice;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;


@property (weak, nonatomic) IBOutlet UIButton *reductionBtn;

@property (weak, nonatomic) IBOutlet UILabel *countLB;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addWidth;

@end


@implementation GoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    


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

//增加
- (IBAction)addGoods:(id)sender {
 
    self.count +=1;
    
    if (self.goodsAdd) {
        
        self.goodsAdd(YES);

    }
}
//减少
- (IBAction)reductionGoods:(id)sender {
    
    if (self.count == 0) {
        
        self.count = 0;
        return;
    }
    self.count -=1;
    if (self.goodsAdd) {
        
        self.goodsAdd(NO);
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
