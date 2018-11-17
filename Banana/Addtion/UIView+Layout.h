//
//  UIView+Layout.h
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Layout)
//  left
@property (nonatomic) CGFloat left;
//  top
@property (nonatomic) CGFloat top;
//  right point.x
@property (nonatomic) CGFloat right;
//  botton point.y
@property (nonatomic) CGFloat bottom;
//  width
@property (nonatomic) CGFloat width;
//  height
@property (nonatomic) CGFloat height;
//  center.x
@property (nonatomic) CGFloat centerX;
//  center.y
@property (nonatomic) CGFloat centerY;
//  oright point    position
@property (nonatomic) CGPoint origin;
//  size point      size
@property (nonatomic) CGSize  size;

@end

NS_ASSUME_NONNULL_END
