//
//  HomeRequest.m
//  Banana
//
//  Created by 朱标 on 2018/11/21.
//

#import "HomeRequest.h"
#import "NetWorkTool.h"
@implementation HomeRequest
+(void)detailWithID:(NSString *)ID success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:ID forKey:@"productId"];
    
    [[NetWorkTool shareInstance] postWithUrl:PRODUCT_DETAIL paramWithDic:params success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
@end
