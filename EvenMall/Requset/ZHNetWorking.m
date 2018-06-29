//
//  ZHNetWorking.m
//  AFNetWork
//
//  Created by zhc on 16/6/15.
//  Copyright © 2016年 zhc. All rights reserved.
//

#import "ZHNetWorking.h"
#import "AFNetworking.h"
#import "ZHHud.h"
#import "PublicVoid.h"
/**
 *  是否开启https SSL 验证
 *
 *  @return YES为开启，NO为关闭
 */
#define openHttpsSSL YES
/**
 *  SSL 证书名称，仅支持cer格式。“app.bishe.com.cer”,则填“app.bishe.com”
 */
#define certificate @"client"

static ZHNetWorking * netWorking=nil;
@interface ZHNetWorking()

@property(nonatomic,strong)AFHTTPSessionManager * manager;



@end

@implementation ZHNetWorking


//ZHSingletonM(ZHNetWorking);

+(ZHNetWorking *)sharedZHNetWorking{
    
    if (netWorking==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            netWorking = [[self alloc] init];
            netWorking.manager = [AFHTTPSessionManager manager];
            netWorking.netAC = @"未知";
        });
        
    }
    return netWorking;
}



- (void)NetworkStatusUnknown:(Unknown)unknown reachable:(Reachable)reachable reachableViaWWAN:(ReachableViaWWAN)reachableViaWWAN reachableViaWiFi:(ReachableViaWiFi)reachableViaWiFi

{
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",(long)status);
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                self.netAC = @"未知";
                unknown();
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                self.netAC  = @"无网";
                reachable();
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.netAC = @"4G";
                reachableViaWWAN();
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.netAC = @"wifi";
                reachableViaWiFi();
                break;
                
            default:
                break;
        }
        
        
    }];
    
    
    [manager startMonitoring];
    
    
}


/**
 *  封装的get请求
 *
 *  @param URLString  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */

- (void)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    
    AFHTTPSessionManager * manager = self.manager;
    
    NSDictionary * dict = [self addDevice:parameters];

    NSString * timeStr = [self currentTimeStr];
    NSString * nonceStr = [NSString stringWithFormat:@"%d",[self getRandomNumber:10000000 to:99999999]];
    
//    NSString * myStr =  [self upLoadImageWith:timeStr nonce:nonceStr staffid:EDU_STAFFID token:EDU_TOKEN];
//
//
//    [manager.requestSerializer setValue:nonceStr forHTTPHeaderField:@"nonce"];
//    [manager.requestSerializer setValue:EDU_STAFFID forHTTPHeaderField:@"staffid"];
//    [manager.requestSerializer setValue: timeStr  forHTTPHeaderField:@"timestamp"];
//    [manager.requestSerializer setValue:myStr forHTTPHeaderField:@"signature"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSMutableSet * contentTypes = [[NSMutableSet alloc]initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"application/json"];

    manager.responseSerializer.acceptableContentTypes = contentTypes;
    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    [self baseGETNetWork:manager url:URLString parameters:dict success:success failure:failure];

}

- (void)GETNoHud:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    
    
    AFHTTPSessionManager * manager = self.manager;
    
    NSDictionary * dict = [self addDevice:parameters];
    
    NSString * timeStr = [self currentTimeStr];
    NSString * nonceStr = [NSString stringWithFormat:@"%d",[self getRandomNumber:10000000 to:99999999]];
    
//    NSString * myStr =  [self upLoadImageWith:timeStr nonce:nonceStr staffid:EDU_STAFFID token:EDU_TOKEN];
//
//
//    [manager.requestSerializer setValue:nonceStr forHTTPHeaderField:@"nonce"];
//    [manager.requestSerializer setValue:EDU_STAFFID forHTTPHeaderField:@"staffid"];
//    [manager.requestSerializer setValue: timeStr  forHTTPHeaderField:@"timestamp"];
//    [manager.requestSerializer setValue:myStr forHTTPHeaderField:@"signature"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableSet * contentTypes = [[NSMutableSet alloc]initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"application/json"];
    
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 20);
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    EDULog(@"%@",jsonStr);
    
    
    [manager GET:URLString parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            //            [hud hideAnimated:YES];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSDictionary * status = dic[@"status"];
            
            if ([status[@"code"]integerValue] == 200) {
                
                success(dic);
                
            }else if ([status[@"code"]integerValue] == 403 || [status[@"code"]integerValue] == 406){
                
                
                [PublicVoid setupLoginViewController];
                [ZHHud initWithMessage:@"登录过期,请重新登录"];
                
            }else{
                
                [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(error);
        }
        
    }];

}

- (void)baseGETNetWork:(AFHTTPSessionManager * )manager url:(NSString *)URLString parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
//    EDULog(@"%@",jsonStr);

    ZHHud * hud = [ZHHud initWithLoading];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hideAnimated:YES];
        if (success)
        {
//            [hud hideAnimated:YES];
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSDictionary * status = dic[@"status"];
            
            if ([status[@"code"]integerValue] == 200) {
                
                    success(dic);
            
            }else if ([status[@"code"]integerValue] == 403 || [status[@"code"]integerValue] == 406){
              
                
                [PublicVoid setupLoginViewController];
                [ZHHud initWithMessage:@"登录过期,请重新登录"];

            }else{
                
                [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
                
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];

        if (failure)
        {
            failure(error);
        }
        
    }];

    
    
    
}



- (void)POSTAES:(NSInteger)code parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure{
    
    
    AFHTTPSessionManager *manager = self.manager;

    NSDictionary * initial;
    NSString * str = nil;
    if (parameters.allKeys.count > 0) {//加密
        
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSString * aesStr = [PublicVoid encryptAES:str key:AES_RSA_KEY];
        
        initial = @{@"code" : @(code), @"data" : aesStr};

        
    }else{
        
        initial = @{@"code" : @(code)};
    }
    
    
    NSDictionary * dict = [self addDevice:initial];
    
    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 60);
    
    
    ZHHud * hud = [ZHHud initWithLoading];
   
    EDULog(@"%@",dict);
    
    
    [manager POST:BASE_URL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hideAnimated:YES];
        
        if (success)
        {
//            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSString * data = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
           
            NSString  * str = [PublicVoid decryptAES:data key:AES_RSA_KEY];
            NSDictionary * dict = [PublicVoid parseJSONStringToNSDictionary:str];
            
            if ([dict[@"resultCode"]integerValue] == 200) {
                
                
                success(dict);
            }else{
                
                [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
                
            }
            
            //            success(dic);
            NSLog(@"success====%@",dict);
            
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];
        
        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            
            NSLog(@"error=====%@",error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
    
    
    
}

/**
 *  封装的POST请求
 *
 *  @param code  请求的链接
 *  @param parameters 请求的参数
 *  @param success    请求成功回调
 *  @param failure    请求失败回调
 */
- (void)POSTRSA:(NSInteger )code parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{

    AFHTTPSessionManager *manager = self.manager;
    
    NSDictionary * initial = @{@"code" :@(code) , @"data" : parameters[@"data"]};
    
    NSDictionary * dict = [self addDevice:initial];


    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 60);
    
    
    ZHHud * hud = [ZHHud initWithLoading];
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
//    NSString * jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//
    EDULog(@"%@",dict);
    
    [manager POST:BASE_URL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [hud hideAnimated:YES];
        
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        

            if ([dic[@"resultCode"]integerValue] == 200) {
                
                NSDictionary * response = dic;
                
                success(dic);
            }else{
                
                [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
                
            }
            
            //            success(dic);
            NSLog(@"success====%@",dic);
            
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];
        
        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            
            NSLog(@"error=====%@",error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];

   
}
- (void)POSTNoAES:(NSInteger)code parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure
{
    
    
    AFHTTPSessionManager *manager = self.manager;
    
    NSDictionary * initial = @{@"code" :@(code)};
    
    NSDictionary * dict = [self addDevice:initial];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 60);
    
    ZHHud * hud = [ZHHud initWithLoading];

    [manager POST:BASE_URL parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            
            if ([dic[@"resultCode"]integerValue] == 200) {
                
                NSDictionary * response = dic;
                
                success(dic);
            }else{
                
                [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
                
            }
            
            //            success(dic);
            NSLog(@"success====%@",dic);
            
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];
        
        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            
            NSLog(@"error=====%@",error);
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; // 关闭状态栏动画
    }];
   
}



//上传图片
- (void)UpWithPOST:(NSString *)URLString parameters:(NSDictionary *)parameters data:(NSData *)fileData UpFileType:(NSString *)type success:(Success)success failure:(Failure)failure
{
    
    ZHHud * hud = [ZHHud initWithLoading];

    AFHTTPSessionManager *manager = self.manager;
    
    NSDictionary * dict = [self addDevice:parameters];
    
    NSString * timeStr = [self currentTimeStr];
    NSString * nonceStr = [NSString stringWithFormat:@"%d",[self getRandomNumber:10000000 to:99999999]];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
//    NSString * myStr =  [self upLoadImageWith:timeStr nonce:nonceStr staffid:EDU_STAFFID token:token];
//    
//    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:nonceStr forHTTPHeaderField:@"nonce"];
//    [manager.requestSerializer setValue:EDU_STAFFID forHTTPHeaderField:@"staffid"];
//    [manager.requestSerializer setValue:timeStr  forHTTPHeaderField:@"timestamp"];
//    [manager.requestSerializer setValue:myStr forHTTPHeaderField:@"signature"];
    
    
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
    
    NSMutableSet *contentTypes = [[NSMutableSet alloc]initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"application/json"];
    [contentTypes addObject:@"image/jpeg"];
    [contentTypes addObject:@"text/plain"];
    [contentTypes addObject:@"text/javascript"];
    [contentTypes addObject:@"text/json"];
    [contentTypes addObject:@"text/html"];


//
    manager.responseSerializer.acceptableContentTypes = contentTypes;
    
    
    manager.requestSerializer.timeoutInterval = (self.timeoutInterval ? self.timeoutInterval : 60);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // 开启状态栏动画
    
    NSURLSessionDataTask *uploadTask = [manager POST:URLString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 注意点: 当传图片的时候，typeName是image ， mimeType是@"image/*"
        // 注意点: 当传视频的时候，typeName是video ， mimeType是@"video/*"
        // filename一般不能省略后缀，比如jpg 和 mp4
        
        NSString *typeName, *mimeType, *fileName;
        if ([type isEqualToString:@"image"]) {
            typeName = @"image";
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            mimeType = @"image/*";
            
//            fileName = @"fileName.jpg";
        }else if ([type isEqualToString:@"video"]) {
            typeName = @"video";
            mimeType = @"video/*";
            fileName = @"fileName.mp4";
        }
        
        
        [formData appendPartWithFileData:fileData name:typeName fileName:fileName mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"%lld--%lld",uploadProgress.totalUnitCount, uploadProgress.completedUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        [hud hideAnimated:YES];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success)
        {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            success(dic);
            NSLog(@"success====%@",dic);
            
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [hud hideAnimated:YES];

        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure)
        {
            failure(error);
            [ZHHud initWithMessage:@"您的网络有问题,请稍后重试"];
            NSLog(@"error=====%@",error);
        }
        
    }];
    [uploadTask resume];
    
    
    
}



- (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    NSSet *cerset = [NSSet setWithObjects:certData, nil];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = cerset;
    
    return securityPolicy;
}


- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


-(int)getRandomNumber:(int)from to:(int)to
{
      return (int)(from + (arc4random()%(to - from + 1)));
}

- (NSMutableDictionary *)addDevice:(NSDictionary *)dict {
    
    NSMutableDictionary * parm = [[NSMutableDictionary alloc]initWithDictionary:dict];

    
    NSString * version_code = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]];
    
    NSString *version_name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    
    //手机序列号
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString * uuid = [identifierNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"手机序列号: %@",identifierNumber);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    
    [parm setObject:version_name forKey:@"version"];
    [parm setObject:uuid forKey:@"uuid"];
    [parm setObject:[self currentTimeStr] forKey:@"timestamp"];
    [parm setObject:@"863989027961856" forKey:@"imei"];

    
    return parm;
}

@end
