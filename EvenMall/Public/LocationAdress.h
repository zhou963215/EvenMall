//
//  LocationAdress.h
//  GoodMedical
//
//  Created by zhou on 2017/8/16.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationAdress : NSObject<CLLocationManagerDelegate>
@property (nonatomic, copy) void(^adress)(NSString * administrativeArea,NSString * currentCity,NSString * subLocality);

- (void)locatemap;


@end
