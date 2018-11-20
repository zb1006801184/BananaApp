//
//  MineRequest.m
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import "MineRequest.h"
#import "NetWorkTool.h"
@implementation MineRequest
+ (void)loginWithUsername:(NSString *)username  password:(NSString *)password loginType:(NSString *)loginType success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    [params setObject:loginType forKey:@"loginType"];

    [[NetWorkTool shareInstance] postWithUrl:MEMBER_LOGIN paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)registerWithPhone:(NSString *)Phone username:(NSString *)username checkCode:(NSString *)checkCode password:(NSString *)password success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:Phone forKey:@"phone"];
    [params setObject:checkCode forKey:@"checkCode"];
    if (username.length > 0) {
        [params setObject:@"username" forKey:username];
    }
    [[NetWorkTool shareInstance] postWithUrl:MEMBER_REGISTER paramWithDic:params success:^(id  _Nonnull responseObject) {
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
    [[NetWorkTool shareInstance] postWithUrl:SYS_SENDNOTE paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)getMessageSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    [[NetWorkTool shareInstance]postWithUrl:MEMBER_SELECTINFORMATION paramWithDic:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)loginOutSuccess:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    [[NetWorkTool shareInstance]postWithUrl:MEMBER_LOGOUT paramWithDic:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
+ (void)forgetPassWordWithKey:(NSString *)key password:(NSString *)password checkCode:(NSString *)checkCode success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:key forKey:@"key"];
    [params setObject:password forKey:@"password"];
    [params setObject:checkCode forKey:@"checkCode"];
    [[NetWorkTool shareInstance] postWithUrl:MEMEBER_CHANGEPWD paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)ideaWithContactMsg:(NSString *)contactMsg content:(NSString *)content success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:contactMsg forKey:@"contactMsg"];
    [params setObject:content forKey:@"content"];
    [[NetWorkTool shareInstance] postWithUrl:SYS_IDEA paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

+ (void)validateCheckCodeWithTelephone:(NSString *)telephone checkCode:(NSString *)checkCode operationType:(NSString *)operationType success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:telephone forKey:@"telephone"];
    [params setObject:checkCode forKey:@"checkCode"];
    [params setObject:operationType forKey:@"operationType"];
    [[NetWorkTool shareInstance] postWithUrl:SYS_VALIDATECHECKCODE paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
+ (void)changeBindWithPhone:(NSString *)phone checkCode:(NSString *)checkCode validateCode:(NSString *)validateCode success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:phone forKey:@"phone"];
    [params setObject:checkCode forKey:@"checkCode"];
    [params setObject:validateCode forKey:@"validateCode"];
    [[NetWorkTool shareInstance] postWithUrl:MEMBER_CHANGEBIND paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}

@end
