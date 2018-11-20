//
//  BAliyunOSS.m
//  Banana
//
//  Created by 朱标 on 2018/11/20.
//

#import "BAliyunOSS.h"
#import <AliyunOSSiOS/OSSService.h>
#import <AFNetworking.h>
NSString * const endPoint = @"https://oss-cn-hangzhou.aliyuncs.com";
OSSClient * client;
@interface BAliyunOSS ()
//获取token返回的json数据
@property(nonatomic,strong)NSDictionary *responseObject;
@property (assign, nonatomic) int age;
@end
@implementation BAliyunOSS
#pragma mark ====创建上传的单例====
+ (instancetype)sharedInstance {
    static BAliyunOSS *instance;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[BAliyunOSS alloc]init];
    });
    
    return instance;
}


#pragma mark ===开启上传环境====
- (void)setupEnvironment {
    // 打开调试log
    [OSSLog enableLog];
    
    // 初始化sdk
    [self initOSSClient];
}

#pragma maek ===  初始化阿里云sdk====
- (void)initOSSClient {
    
    // 明文设置AccessKeyId/AccessKeySecret的方式建议只在测试时使用LTAIUqUzNn0NgLQn   p5dgVPGj39s4TBizt9axFWcgg9Nacr
    //    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:@"LTAIUqUzNn0NgLQn" secretKey:@"p5dgVPGj39s4TBizt9axFWcgg9Nacr"];
    //    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential];
    
    
    //    //STS鉴权模式
    NSString *mobile = @"13715006982";
    NSString  *secretString = [NSString stringWithFormat:@"%@",mobile];
    
    //直接设置StsToken
    id<OSSCredentialProvider> credential2 = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
        [MineRequest getTokensuccess:^(id  _Nonnull responseObject) {
//                        NSLog(@"%@",responseObject);
                        self.responseObject = responseObject;
                        [tcs setResult:responseObject];
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
                        if (error) {
                            [tcs setError:error];
                            return;
                        }
        }];
        
        //同步
                [tcs.task waitUntilFinished];
        
        if (tcs.task.error) {
            NSLog(@"get token error: %@", tcs.task.error);
            return nil;
        }
        else {
            //获取token返回的参数
            OSSFederationToken * token = [OSSFederationToken new];
            token.tAccessKey = [self.responseObject objectForKey:@"accessKeyId"];
            token.tSecretKey = [self.responseObject objectForKey:@"accessKeySecret"];
            token.tToken = [self.responseObject objectForKey:@"securityToken"];
            token.expirationTimeInGMTFormat = [self.responseObject objectForKey:@"expiration"];
//            NSLog(@"get token: %@", token);
            return token;
        }
        
    }];
    
    //网络配置
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential2 clientConfiguration:conf];
}




#pragma mark ==== 同步上传=====
- (void)uploadObjectAsyncWith:(NSData *)uploadData withObjectKey:(NSString *)objectKey withAlbumNumber:(NSString *)number{
    
    //上传请求类
    OSSPutObjectRequest * request = [OSSPutObjectRequest new];
    //文件夹名 后台给出
    request.bucketName = @"loan-market-pics";
    //objectKey为文件名 一般自己拼接
    request.objectKey = [NSString stringWithFormat:@"images/face/%@",objectKey];
    //上传数据类型为NSData
    request.uploadingData = uploadData;
    OSSTask * putTask = [client putObject:request];
    [putTask continueWithBlock:^id(OSSTask *task) {
        
        if (!task.error) {
            
            NSLog(@"上传成功!");
            NSNotification * notice = [NSNotification notificationWithName:@"postImage" object:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        } else {
            
            NSLog(@"upload object failed, error: %@" , task.error);

        }
        return nil;
    }];
    
//    [putTask waitUntilFinished];
    
    //上传进度
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        
    };
}

@end
