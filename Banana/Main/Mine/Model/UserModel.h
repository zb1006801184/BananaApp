//
//  UserModel.h
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject<NSCoding>
+(void)saveUserModelWithObject:(UserModel *)model;
+(UserModel *)getUserModel;
+(void)login;
+(void)loginOut;
@end

NS_ASSUME_NONNULL_END
