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

+ (void)userDefaultsWith:(NSString *_Nullable)key value:(NSString *_Nullable)value;//存入参数

+(NSString *_Nullable)userDefaultsWiht:(NSString *_Nullable)key;//取出参数

+ (NSString *_Nonnull)encryptAES:(NSString *_Nonnull)content key:(NSString *_Nullable)key ;

+ (NSString *_Nullable)decryptAES:(NSString *_Nullable)content key:(NSString *_Nullable)key ;

+(NSDictionary *_Nullable)parseJSONStringToNSDictionary:(NSString *_Nullable)JSONString;

+ (void)RefreshAES :(RefshAESKEY)refsh;
@end
