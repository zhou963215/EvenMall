//
//  AppDelegate.m
//  EvenMall
//
//  Created by zhou on 2018/6/13.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "AppDelegate.h"

#import <BaiduMapAPI_Map/BMKMapView.h>

#import "EMTabBarControllerConfig.h"

BMKMapManager * _mapManager;

@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {



    EMTabBarControllerConfig * tabBar = [[EMTabBarControllerConfig alloc]init];
    self.window.rootViewController = tabBar.tabBarController;

    _mapManager  = [[BMKMapManager alloc]init];

    BOOL ret = [_mapManager start:@"cyNxt7Dxo5LYPLU9i9WVAfoFwXoo8QLb" generalDelegate:self];
    
    if (!ret) {
        
        EDULog(@" manager start failed!");
    }


    return YES;
}


- (void)onGetNetworkState:(int)iError{
    
    
    if (iError == 0) {
        
        EDULog(@"联网成功");
    }else{
        
        EDULog(@"onGetNetworkState %d--",iError);
        
        
    }
    
}

- (void)onGetPermissionState:(int)iError{
    
    
    if (iError == 0) {
        
        EDULog(@"联网成功");
    }else{
        
        EDULog(@"onGetNetworkState %d--",iError);
        
        
    }

    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
