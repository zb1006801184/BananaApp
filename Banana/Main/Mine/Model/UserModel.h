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
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *flowNo;
@property (nonatomic, copy) NSString *headImg;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *regdate;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *username;
@end

NS_ASSUME_NONNULL_END
