//
//  messageModel.h
//  Banana
//
//  Created by tdr on 2018/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface messageModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *jumpType;
@property (nonatomic, copy) NSString *jumpValue;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *picUrl;

@end

NS_ASSUME_NONNULL_END
