//
//  PersonalInformationModel.h
//  EvenMall
//
//  Created by xuechuan on 2018/7/23.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>



@interface PersonalUserInfoModel: NSObject

@property (nonatomic, copy) NSString * birthday;

@property (nonatomic, copy) NSString * exp;

@property (nonatomic, copy) NSString * headUrl;

@property (nonatomic, copy) NSString * integral;

@property (nonatomic, copy) NSString * nickname;

@property (nonatomic, copy) NSString * realname;

@property (nonatomic, assign) NSInteger  sex;

@property (nonatomic, copy) NSString * sign;

@property (nonatomic, copy) NSString * userId;

@property (nonatomic, copy) NSString * vipExpiryTime;


@end

@interface PersonalDetailModel: NSObject

@property (nonatomic, copy) NSString * token;
@property (nonatomic, strong) PersonalUserInfoModel * userInfo;

@end



@interface PersonalInformationModel : NSObject
@property (nonatomic, assign) NSInteger resultCode;

@property (nonatomic, copy) NSString * msg;

@property (nonatomic, copy) NSDictionary * data;
@end
