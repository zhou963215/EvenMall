//
//  UIView+Controller.m
//  Xuechuanedu
//
//  Created by xuechuan on 2018/4/13.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)
- (UIViewController *)viewControll {
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    
    return nil;
}

- (UINavigationController *)navigationController {
    return self.viewControll.navigationController;
}
@end
