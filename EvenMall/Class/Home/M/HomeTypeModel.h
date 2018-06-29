//
//  HomeTypeModel.h
//  EvenMall
//
//  Created by xuechuan on 2018/6/28.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "EvenMallBaseModel.h"


@interface HomeTypeDetailModel : NSObject

@property (nonatomic, copy) NSString * catId;

@property (nonatomic, copy) NSString * catImg;

@property (nonatomic, copy) NSString * catName;

@property (nonatomic, copy) NSString * parCatId;

@property (nonatomic, copy) NSString * creTime;

@property (nonatomic, copy) NSString * catCode;


@end

@interface HomeTypeModel : EvenMallBaseModel

@end
