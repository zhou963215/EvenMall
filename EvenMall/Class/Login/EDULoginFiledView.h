//
//  EDULoginFiledView.h
//  Xuechuanedu
//
//  Created by xuechuan on 2018/4/17.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,FieldStyle) {
    DEFAULT = 0,
    SECRET = 1,
    VCLIDATION = 2
    
};

@interface EDULoginFiledView : UIView

@property (nonatomic, assign) FieldStyle style;

@property (nonatomic, copy) NSString * value;
 
@property (nonatomic, strong) UIImage * leftImage;

@property (nonatomic, assign) BOOL isSecret;

@property (nonatomic, copy) NSString * placehold;

@property (nonatomic, copy) NSString * phone;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) void (^endEditBlock)(NSString *);

@property (nonatomic, copy) void (^changTextBlock)(NSInteger);
@end
