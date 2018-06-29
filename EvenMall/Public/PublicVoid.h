//
//  PublicVoid.h
//  TestNew
//
//  Created by xuechuan on 2018/4/8.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

typedef void (^ _Nullable RefshAESKEY)(BOOL isRefsh);     // 成功Block

@interface PublicVoid : NSObject

+ (void)setupRootViewController;//设置跟视图

+(void)setupLoginViewController;

+ (void)userDefaultsWith:(NSString *)key value:(NSString *)value;//存入参数

+(NSString *)userDefaultsWiht:(NSString *)key;//取出参数


+ (NSString *)formatFilesize:(NSInteger)filesize;

+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key ;

+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key ;

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;

+ (void)RefreshAES :(RefshAESKEY)refsh;
@end
