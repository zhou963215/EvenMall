//
//  CourseShare.m
//  Xuechuanedu
//
//  Created by xuechuan on 2018/5/24.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import "CourseShare.h"

@interface CourseShare()

@end

@implementation CourseShare
+ (instancetype)shareInstance{
    
    static CourseShare *shareInstance  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[CourseShare alloc]init];;
    });
    
    return shareInstance;
}








@end
