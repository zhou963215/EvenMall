//
//  NSData+AES.h
//  EvenMall
//
//  Created by xuechuan on 2018/6/25.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@interface NSData (AES)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end
