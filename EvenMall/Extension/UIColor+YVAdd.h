//
//  UIColor+YVAdd.h
//  YVBase
//
//  Created by dzb on 2018/2/27.
//

#import <UIKit/UIKit.h>

typedef NSString YVHexString;

static inline UIColor * _Nullable RGBAColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha) {
	return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

static inline UIColor * _Nullable RGBColor(CGFloat red,CGFloat green,CGFloat blue) {
	return RGBAColor(red, green, blue, 1.0f);
}

/**
 生成随机色
 */
static inline UIColor * _Nullable RandomColor() {
	CGFloat red     = arc4random_uniform(255.0f);
	CGFloat green   = arc4random_uniform(255.0f);
	CGFloat blue    = arc4random_uniform(255.0f);
	return RGBAColor(red, green, blue, 1.0f);
}


@interface UIColor (YVAdd)


//从十六进制字符串获取颜色
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *_Nullable)colorWithHexString:(YVHexString *_Nullable)color;


//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *_Nullable)colorWithHexString:(YVHexString *_Nullable)color alpha:(CGFloat)alpha;

- (YVHexString *_Nullable)changeUIColorToRGB;



@end
