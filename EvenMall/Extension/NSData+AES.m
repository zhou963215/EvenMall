//
//  NSData+AES.m
//  EvenMall
//
//  Created by xuechuan on 2018/6/25.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "NSData+AES.h"

@implementation NSData (AES)
//-(NSData * )CBCWithOperation:(CCOperation)operation andIv:(NSString *)ivString andKey:(NSString *)keyString andInput:(NSData *)inputData
//{
//
//    const char * iv = [[ivString dataUsingEncoding: NSUTF8StringEncoding]bytes];
//    const char * key = [[keyString dataUsingEncoding: NSUTF8StringEncoding] bytes];
//
//    CCCryptorRef cryptor;
//
//    CCCryptorCreateWithMode(operation, kCCModeCFB, kCCAlgorithmAES, ccNoPadding, iv, key, [keyString length], NULL, 0, 0, 0, &cryptor);
//
//    NSUInteger inputLength = inputData.length;
//
//    char *outData = malloc(inputLength);
//
//    memset(outData, 0, inputLength);
//
//    size_t outLength = 0;
//    
//    CCCryptorUpdate(cryptor, inputData.bytes, inputLength, outData, inputLength, &outLength);
//
//    NSData *data = [NSData dataWithBytes: outData length: outLength];
//
//    CCCryptorRelease(cryptor);
//
//    free(outData);
//
//    return data;
//
//}
- (NSData *)aes256_encrypt:(NSString *)key   //加密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}


- (NSData *)aes256_decrypt:(NSString *)key   //解密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}
@end
