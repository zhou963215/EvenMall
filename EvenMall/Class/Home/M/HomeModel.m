//
//  HomeModel.m
//  EvenMall
//
//  Created by xuechuan on 2018/8/8.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeModel.h"


@implementation HomeCategoryModel

@end

@implementation HomeBannerModel


@end

@implementation HomeGoodsModel

@end


@implementation HomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banner" : HomeBannerModel.class , @"category" : HomeCategoryModel.class, @"outStock" : HomeGoodsModel.class, @"goodsList":HomeGoodsModel.class};
}
@end
