//
//  ZHNetWorking.h
//  AFNetWork
//
//  Created by zhc on 16/6/15.
//  Copyright © 2016年 zhc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^ _Nullable Unknown) (void);
typedef void (^ _Nullable Reachable) (void);
typedef void (^ _Nullable ReachableViaWWAN) (void);
typedef void (^ _Nullable ReachableViaWiFi) (void);

typedef void (^ _Nullable Success)(id responseObject);     // 成功Block
typedef void (^ _Nullable Failure)(NSError *error);        // 失败Blcok
typedef void (^ _Nullable Progress)(NSProgress * _Nullable progress); // 上传或者下载进度Block
typedef NSURL * _Nullable (^ _Nullable Destination)(NSURL *targetPath, NSURLResponse *response); //返回URL的Block
typedef void (^ _Nullable DownLoadSuccess)(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath); // 下载成功的Blcok


@interface ZHNetWorking : NSObject

/**
 *  超时时间(默认20秒)
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**
 *  可接受的响应内容类型
 */
@property (nonatomic, copy) NSSet <NSString *> *acceptableContentTypes;

@property (nonatomic, copy) NSString * netAC;


+(ZHNetWorking *)sharedZHNetWorking;

//网络状态监听

- (void)NetworkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi;

//登录状态下

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

//未登录状态下

- (void)GETNoHud:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

//上传rsaKEY

- (void)POSTRSA:(NSInteger )code parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

//获取公钥

- (void)POSTNoAES:(NSInteger )code parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;

//普通post
- (void)POSTAES:(NSInteger)code parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure;


- (void)UpWithPOST:(NSString *)URLString parameters:(NSDictionary *)parameters data:(NSData *)fileData UpFileType:(NSString *)type success:(Success)success failure:(Failure)failure;

@end
NS_ASSUME_NONNULL_END
