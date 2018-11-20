//
//  UserModel.m
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import "UserModel.h"

@implementation UserModel
MJCodingImplementation
+(void)saveUserModelWithObject:(UserModel *)model {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [user setObject:data forKey:@"user"];
    [user synchronize];
    
}
+(UserModel *)getUserModel {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSData *data = [user objectForKey:@"user"];
    UserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}
+(void)login {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@YES forKey:@"login"];
    [user synchronize];
}
+(void)loginOut {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@NO forKey:@"login"];
    [user synchronize];
}
@end
