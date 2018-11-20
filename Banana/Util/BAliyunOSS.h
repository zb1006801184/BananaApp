//
//  BAliyunOSS.h
//  Banana
//
//  Created by 朱标 on 2018/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAliyunOSS : NSObject
+ (instancetype)sharedInstance;

- (void)setupEnvironment;

- (void)uploadObjectAsyncWith:(NSData *)uploadData withObjectKey:(NSString *)objectKey withAlbumNumber:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
