//
//  ChangePhoneViewController.h
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePhoneViewController : UIViewController
@property (nonatomic, assign) NSInteger type;//1校验原手机 2确认修改
@property (nonatomic, copy) NSString *validateCheckCode;//校验码 (type = 2 的时候必填)
@end

NS_ASSUME_NONNULL_END
