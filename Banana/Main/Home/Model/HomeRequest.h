//
//  HomeRequest.h
//  Banana
//
//  Created by 朱标 on 2018/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeRequest : NSObject
//详情
+(void)detailWithID:(NSString *)ID success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;

@end

NS_ASSUME_NONNULL_END
