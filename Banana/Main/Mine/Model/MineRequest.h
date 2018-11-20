//
//  MineRequest.h
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineRequest : NSObject
//登录
+ (void)loginWithUsername:(NSString *)username  password:(NSString *)password loginType:(NSString *)loginType success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//注册
+ (void)registerWithPhone:(NSString *)Phone username:(NSString *)username checkCode:(NSString *)checkCode password:(NSString *)password success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//获取验证码
+ (void)sendCodeWithToken:(NSString *)token telephone:(NSString *)telephone operationType:(NSString *)operationType success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//获取用户信息
+ (void)getMessageSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//登出
+ (void)loginOutSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//忘记密码
+ (void)forgetPassWordWithKey:(NSString *)key password:(NSString *)password checkCode:(NSString *)checkCode success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;;
//意见反馈
+ (void)ideaWithContactMsg:(NSString *)contactMsg content:(NSString *)content success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//验证码校验
+ (void)validateCheckCodeWithTelephone:(NSString *)telephone checkCode:(NSString *)checkCode operationType:(NSString *)operationType success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//绑定手机号
+ (void)changeBindWithPhone:(NSString *)phone checkCode:(NSString *)checkCode validateCode:(NSString *)validateCode success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure; 
@end

NS_ASSUME_NONNULL_END
