//
//  PublicVoid.m
//  TestNew
//
//  Created by xuechuan on 2018/4/8.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import "PublicVoid.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <sys/mount.h>

#import "RSAEncryptor.h"

//#import "LoginViewController.h"
//#import <JPUSHService.h>
NSString *const kInitVector = @"16-Bytes--String";
size_t const kKeySize = kCCKeySizeAES128;

@implementation PublicVoid


+ (void)userDefaultsWith:(NSString *)key value:(NSString *)value{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    [user setObject:value forKey:key];
    [user synchronize];
}

+(NSString *)userDefaultsWiht:(NSString *)key{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * str = [user objectForKey:key];
    
    
    return str;
}




+(void)setupLoginViewController{
    
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    [user removeObjectForKey:@"token"];
//    
//     ZHHud * hud = [ZHHud initWithLoading];
//    
//    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
//        
//        [hud hideAnimated:YES];
//        EDULog(@"%@",iAlias);
//      
//        
//    } seq:1];
//   
//    LoginViewController * vc = [LoginViewController new];
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    
//    [[[[UIApplication sharedApplication]delegate]window] setRootViewController:nav];

    
}

+ (void)setupRootViewController{
    
    //进入首页
//    EDUTabBarControllerConfig *tabBarControllerConfig = [[EDUTabBarControllerConfig alloc] init];
//    [[[[UIApplication sharedApplication]delegate]window] setRootViewController:tabBarControllerConfig.tabBarController];
//    [ZHHud initWithMessage:@"登录成功"];
}

+ (NSString *)formatFilesize:(NSInteger)filesize {
    return [NSByteCountFormatter stringFromByteCount:filesize countStyle:NSByteCountFormatterCountStyleFile];
}

//加密
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key {
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = contentData.length;
    // 为结束符'\\0' +1
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    // 密文长度 <= 明文长度 + BlockSize
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
     void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,  // 系统默认使用 CBC，然后指明使用 PKCS7Padding
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

//解密
+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key {
    // 把 base64 String 转换成 Data
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}

+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}



+ (void)RefreshAES:(RefshAESKEY)refsh{
    
    
   __block BOOL isRefresh = NO;

    [[ZHNetWorking sharedZHNetWorking]POSTNoAES:1001 parameters:@{} success:^(id  _Nonnull responseObject) {
        
        
        NSDictionary * dict = responseObject[@"data"];
        
        NSString * rsa = [RSAEncryptor encryptString:AES_RSA_KEY publicKey:dict[@"publicKey"]];

        
            [[ZHNetWorking sharedZHNetWorking]POSTRSA:1002 parameters:@{ @"data" : rsa} success:^(id  _Nonnull responseObject) {
            
            
                isRefresh = YES;
                refsh(isRefresh);
            
            
            } failure:^(NSError * _Nonnull error) {
            

            }];
        
        
    } failure:^(NSError * _Nonnull error) {
        

    }];
    



    
}




@end
