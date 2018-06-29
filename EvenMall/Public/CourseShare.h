//
//  CourseShare.h
//  Xuechuanedu
//
//  Created by xuechuan on 2018/5/24.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CourseShare : NSObject


@property (nonatomic, copy) NSString * orderNum;

@property (nonatomic, assign) BOOL isMine;

@property (nonatomic, assign) BOOL isLoad;


@property (nonatomic, copy) NSString * nickname;
@property (nonatomic, copy) NSString * headIcon;
@property (nonatomic, assign) BOOL ischeck;
@property (nonatomic, copy) NSString  * phone;





+ (instancetype)shareInstance;


@end
