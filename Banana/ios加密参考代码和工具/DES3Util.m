//
//  DES3Util.m
//  MiYao
//
//  Created by Homosum on 16/7/15.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import "DES3Util.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation DES3Util
//需要协商密匙和向量
#define gkey            @"ESJPWIgQQDgoJXlRy91VZncpdJgwQEDi"
#define gIv             @""




// 加密方法
+ (NSString*)getDES3Encrypt:(NSString*)plainText withKey:(NSString *)key{
    //转bytes
//    NSString*key=gkey;
    NSData*keyData=[key dataUsingEncoding:NSUTF8StringEncoding];
    const void*vkeyData=(const void*)[keyData bytes];
        //解密
        NSData*vwkeyData=[GTMBase64 decodeBytes:vkeyData length:[keyData length]];
        //转bytes
        const void*vkey=(const void*)[vwkeyData bytes];
    //base64加密
//    NSString*nskey=[GTMBase64 stringByEncodingBytes:vkeyData length:[keyData length]];
//    //转bytes
//    NSData*wkeyDate=[nskey dataUsingEncoding:NSUTF8StringEncoding];
//    const void*wkeyBetys=(const void*)[wkeyDate bytes];
//    //解密
//    NSData*vwkeyData=[GTMBase64 decodeBytes:wkeyBetys length:[wkeyDate length]];
//    //转bytes
//    const void*vkey=(const void*)[vwkeyData bytes];
    
    
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];

    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
//    const void *vkey = (const void *) [gkey UTF8String];
//    const void *vkey=(const void*) [GTMBase64 decodeData:[gkey dataUsingEncoding:NSUTF8StringEncoding]];
//    const void *vinitVec = (const void *) [gIv UTF8String];
    const void *vinitVec = nil;
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionECBMode|kCCOptionPKCS7Padding,
                       //填充方式为PKS7Padding
//                       kCCOptionPKCS7Padding,//填充方式,如果Java中为PKCS5Padding填充,修改为kCCOptionECBMode|kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    return result;
}

// 解密方法
+ (NSString*)getDES3Decrypt:(NSString*)encryptText withKey:(NSString *)key{
//    NSString*key=gkey;
    NSData*keyData=[key dataUsingEncoding:NSUTF8StringEncoding];
    const void*vkeyData=(const void*)[keyData bytes];
    //解密
    NSData*vwkeyData=[GTMBase64 decodeBytes:vkeyData length:[keyData length]];
    //转bytes
    const void*vkey=(const void*)[vwkeyData bytes];

    NSData *encryptData = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
//    const void *vkey = (const void *) [gkey UTF8String];
//    const void *vinitVec = (const void *) [gIv UTF8String];
    const void *vinitVec=nil;
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                      kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    
    
//    NSString *testString = @"1234567890";
//    
//    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
//    
//    Byte *testByte = (Byte *)[testData bytes];
//    
//    for(int i=0;i<[testData length];i++)
//        
//        printf("testByte = %d\n",testByte[i]);
    return result;
}


@end
