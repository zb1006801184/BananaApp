//
//  UIColor+RGBHelper.h
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (RGBHelper)
/**
 *  颜色助手，通过[0~255]整数来获取颜色
 *
 *  @param r 红色[0~255]
 *  @param g 绿色[0~255]
 *  @param b 蓝色[0~255]
 *
 *  @return UIColor实体
 */
+ (UIColor *)colorIntegerWithRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b;
/**
 *  颜色助手，通过[0~255]整数来获取颜色
 *
 *  @param r 红色[0~255]
 *  @param g 绿色[0~255]
 *  @param b 蓝色[0~255]
 *  @param a 透明度[0.0~1.0]
 *
 *  @return UIColor实体
 */
+ (UIColor *)colorIntegerWithRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(CGFloat)a;

/**
 *  根据十六进制颜色值获取颜色实体
 *
 *  @param rgb 十六进制rgb值
 *
 *  @return UIColor实体
 */
+ (UIColor *)colorWithRGBValueInHex:(NSInteger)rgb;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)color;
@end

NS_ASSUME_NONNULL_END
