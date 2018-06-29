//
//  HomeChildViewController.h
//  EvenMall
//
//  Created by xuechuan on 2018/6/21.
//  Copyright © 2018年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAnimationViewController : UIViewController
/**
 *  购物车动画，商品图片掉入购物车
 *
 *  @param imageView   掉入购物车的商品图片
 *  @param dropToPoint 掉入位置
 *  @param isNeedNotification 是否有动画结束的通知（用于购物车上的计数加一）
 */
- (void)addProductsAnimation:(UIImageView *)imageView dropToPoint:(CGPoint)dropToPoint isNeedNotification:(BOOL)isNeedNotification;

/**
 *  完成了动画后的回调，不想使用通知的方式的话，可以使用这个
 */
@property (nonatomic,copy) void(^addShopCarFinished)(void);
@end
