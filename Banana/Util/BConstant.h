//
//  BConstant.h
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#ifndef BConstant_h
#define BConstant_h

//    系统控件默认高度
#define kScreenHeight [UIScreen mainScreen].bounds.size.height//获取设备屏幕的长
#define kScreenWidth [UIScreen mainScreen].bounds.size.width//获取设备屏幕的宽
#define ZoomScall kScreenWidth/375.0 //UI适配宽度比
#define kStateHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度
#define kNavHeight ([[UIApplication sharedApplication] statusBarFrame].size.height + 44) //导航栏+状态栏高度
#define kTabbarHeight  (([[UIApplication sharedApplication] statusBarFrame].size.height) > (20) ? 83 : 49 ) //底部tabbar高度

#define WS(weakSelf) __weak typeof(self) weakSelf = self;

#endif /* BConstant_h */
