//
//  HomeTypeModel.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/28.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeTypeModel.h"

@implementation HomeTypeDetailModel

@end

@implementation HomeTypeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : HomeTypeDetailModel.class};
}

@end
