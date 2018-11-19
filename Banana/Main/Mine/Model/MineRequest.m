//
//  MineRequest.m
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import "MineRequest.h"
#import "NetWorkTool.h"
@implementation MineRequest
+ (void)loginWithUsername:(NSString *)username  password:(NSString *)password  success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSDictionary *params = @{@"username":username,@"password":password};
    [[NetWorkTool shareInstance] postWithUrl:@"member/login" paramWithDic:params success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
+ (void)registerWithPhone:(NSString *)Phone username:(NSString *)username checkCode:(NSString *)checkCode password:(NSString *)password success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"phone" forKey:Phone];
    [params setObject:@"checkCode" forKey:checkCode];
    if (username.length > 0) {
        [params setObject:@"username" forKey:username];
    }
    [[NetWorkTool shareInstance] postWithUrl:@"member/register" paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)sendCodeWithToken:(NSString *)token telephone:(NSString *)telephone operationType:(NSString *)operationType success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:telephone forKey:@"telephone"];
    [params setObject:operationType forKey:@"operationType"];
    if (token.length > 0) {
        [params setObject:token forKey:@"token"];
    }
    [[NetWorkTool shareInstance] postWithUrl:@"member/register" paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
@end
