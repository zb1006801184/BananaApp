//
//  AESCipher.h
//  AESCipher
//
//  Created by Welkin Xie on 8/13/16.
//  Copyright © 2016 WelkinXie. All rights reserved.
//
//  https://github.com/WelkinXie/AESCipher-iOS
//

#import <Foundation/Foundation.h>

NSData * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSData *content, NSString *key);

NSString * aesEncryptString1(NSString *content, NSString *key);
NSString * aesDecryptString1(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);
