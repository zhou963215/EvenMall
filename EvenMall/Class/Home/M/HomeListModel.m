//
//  HomeListModel.m
//  EvenMall
//
//  Created by xuechuan on 2018/7/16.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeListModel.h"



@implementation HomeListCategoryModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"goodsList" : HomeListGoodsModel.class};
}

@end

@implementation HomeListGoodsModel




@end


@implementation HomeListBannerModel



@end

@implementation HomeListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"banner" : HomeListBannerModel.class , @"category" : HomeListCategoryModel.class};
}

@end
