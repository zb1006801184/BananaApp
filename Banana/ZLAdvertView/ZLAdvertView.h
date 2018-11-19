//
//  ZLAdvertView.h
//  CordovaCard
//
//  Created by tdr on 2018/11/2.
//  Copyright © 2018年 vvho. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define kUserDefaults [NSUserDefaults standardUserDefaults]


@interface ZLAdvertView : UIView


@property (nonatomic, strong) UIImageView *starimg;

@property (nonatomic, strong) UIButton *tiaoguobtn;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) int time;
/**
 *  开始定时器方法
 */
- (void)showtimer;

- (void)removeAdvertView;

@end



NS_ASSUME_NONNULL_END
