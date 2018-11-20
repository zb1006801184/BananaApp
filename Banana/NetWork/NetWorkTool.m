//
//  NetWorkTool.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "NetWorkTool.h"
#import <AFNetworking.h>
#import "MJExtension.h"
#import <FCUUID/FCUUID.h>
#import "AESCipher.h"
#import "RSAEncryptor.h"
#import "SHA256.h"

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
        
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        _manager.securityPolicy = securityPolicy;
    }
    return _manager;
}
-(void)postWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    
    if (parameter==nil) {
        parameter=[NSMutableDictionary new];
    }
//    对参数加密的方法
    NSDictionary *finalParam = [self getDic:parameter];
    NSString *mainUrl = [NSString stringWithFormat:@"%@%@",API_NAME,url];
    
    [self.manager POST:mainUrl parameters:finalParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDictionary = [responseObject mj_JSONObject];
        if ([jsonDictionary[@"rspCode"] isEqualToString:@"0001"]) {
            success(jsonDictionary);
        }else{
            NSLog(@"%@",jsonDictionary);
            [[UIApplication sharedApplication].keyWindow makeToast:jsonDictionary[@"rspMsg"] duration:2 position:CSToastPositionCenter style:nil];

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
-(void)getWithUrl:(NSString *)url paramWithDic:(NSMutableDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    
    if (parameter==nil) {
        parameter=[NSMutableDictionary new];
    }
    NSDictionary *finalParam = [self getDic:parameter];
    
    [self.manager GET:url parameters:finalParam success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDictionary = [responseObject mj_JSONObject];
        if ([jsonDictionary[@"rspCode"] isEqualToString:@"0001"]) {
            success(jsonDictionary);
        }else{
            NSLog(@"%@",jsonDictionary);
        }
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




//对参数加密的方法
-(NSDictionary *)getDic:(NSMutableDictionary *)parameter{
    
    //    给参数添加公共请求参数
    int flowNo = arc4random() % 10000000;
    [parameter setObject:[NSString stringWithFormat:@"%d%@",flowNo,[self getCurrentTimes]] forKey:@"flowNo"];//生成一个每次请求都不一样的随机数
    [parameter setObject:[self getCurrentTimes] forKey:@"timestamp"];//获取时间戳
    [parameter setObject:FCUUID.uuidForDevice forKey:@"mobileNo"];//生成设备唯一标识
    [parameter setObject:[[UIDevice currentDevice] model] forKey:@"mobileType"];//获取手机型号
    
    NSString *jsonData=[NetWorkTool dictionaryToJson:parameter];
    NSString*uuid0=[[NSUUID UUID] UUIDString];
    NSString*kuuid=[[uuid0 stringByReplacingOccurrencesOfString:@"-" withString:@""]substringToIndex:16];
    NSData *aesdata = aesEncryptString(jsonData , kuuid);
    NSString *tranData = [self convertDataToHexStr:aesdata];
    //    NSString *tranData = aesEncryptString1(jsonData , kuuid);
    
    NSString *ciphertext = [RSAEncryptor encryptString:kuuid publicKey:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPc9C+YOUQSLJNvEblyw2S7LSlXZxW7ya5Repy+BL3jj+RSRIQT9u8KiDTECFspyBNdh9z29nO3ViVJp5X+8KK1JSDYqxaKASwXtWxo4LoQYjSGnC1AFwj4WOG9bLRhJOJzF5bn51e5g+pSNXQFL2XxuZ+fT/2MZErb0xTSD9LQwIDAQAB"];
    NSString*signature=[SHA256 hmac:jsonData withKey:kuuid];
    
    NSDictionary *finalParam=@{@"version":@"APP2.0",
                               @"appId":@"ios-loan",
                               @"tranData":[NetWorkTool URLEncodedString:tranData],
                               @"signature":signature,
                               @"ciphertext":[NetWorkTool URLEncodedString:ciphertext]};

    
    return finalParam;
}


-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
}

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+(NSString *)URLEncodedString:(NSString*)string
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    return encodedUrl;
}

- (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}


@end
