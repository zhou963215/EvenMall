//
//  EvenMallBaseModel.h
//  EvenMall
//
//  Created by xuechuan on 2018/6/28.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>
@interface EvenMallBaseModel : NSObject

@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, copy) NSString * msg;

@property (nonatomic, copy) NSArray * data;

@end
