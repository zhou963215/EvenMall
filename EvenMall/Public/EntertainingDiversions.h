//
//  EntertainingDiversions.h
//  Xuechuanedu
//
//  Created by xuechuan on 2018/6/12.
//  Copyright © 2018年 xuechuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit/NSObject+YYModel.h>

@interface EntertainingDiversions : NSObject

/// 跑马灯类型
@property (nonatomic, assign) NSInteger type;

/// 单次跑马灯显示时长，不包含动画时长
@property (nonatomic, assign) NSTimeInterval displayDuration;

/// 渐变动画时长
@property (nonatomic, assign) NSTimeInterval fadeDuration;

/// 两次闪现的最大间隔时长，实际的间隔时长是取 0~maxFadeInterval 的随机值
@property (nonatomic, assign) NSTimeInterval maxFadeInterval;

/// 两次滚动的最大间隔时长，实际的间隔时长是取 0~maxRollInterval 的随机值
@property (nonatomic, assign) NSTimeInterval maxRollInterval;

/// 跑马灯颜色
@property (nonatomic, copy) NSString * color;

/// 跑马灯透明度
@property (nonatomic, assign) CGFloat alpha;

/// 跑马灯字体
@property (nonatomic, assign) float font;
@end
