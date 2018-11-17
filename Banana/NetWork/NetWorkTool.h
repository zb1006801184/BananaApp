//
//  NetWorkTool.h
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkTool : NSObject
+(instancetype)shareInstance;
//POST
-(void)postWithUrl:(NSString *)url paramWithDic:( NSMutableDictionary * _Nullable )parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//GET
-(void)getWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary * _Nullable)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
//上传图片（用到了再写）
- (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
