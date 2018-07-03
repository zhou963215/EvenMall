//
//  HomeChildViewController.h
//  EvenMall
//
//  Created by xuechuan on 2018/6/21.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import "HomeAnimationViewController.h"
#import "HomeTypeModel.h"
#import <CoreLocation/CoreLocation.h>
@interface HomeChildViewController : HomeAnimationViewController

@property (nonatomic, strong) HomeTypeDetailModel * model;
@property (nonatomic) CLLocationCoordinate2D pt;
- (void)refshData;
@end
