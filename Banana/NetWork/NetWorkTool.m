//
//  NetWorkTool.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "NetWorkTool.h"
#import <AFNetworking.h>
@interface NetWorkTool()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end
@implementation NetWorkTool

static id _instance = nil;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain",@"text/json",@"text/javascript", nil];
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy = securityPolicy;
        _manager.operationQueue.maxConcurrentOperationCount = 5;
    }
    return _manager;
}
-(void)postWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    
    [self.manager POST:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
-(void)getWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    [self.manager GET:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    return _instance;
}
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

@end
