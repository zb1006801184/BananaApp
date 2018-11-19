//
//  SHA256.h
//  MiYao
//
//  Created by Homosum on 16/7/15.
//  Copyright © 2016年 JuXiuSheQu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHA256 : NSObject
+(NSString *)getSha256String:(NSString *)srcString;
+ (NSString *)hmac:(NSString *)plaintext withKey:(NSString *)key;
@end
