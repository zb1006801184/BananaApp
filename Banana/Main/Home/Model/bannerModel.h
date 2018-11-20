//
//  bannerModel.h
//  Banana
//
//  Created by tdr on 2018/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface bannerModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *jumpType;
@property (nonatomic, copy) NSString *jumpValue;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, copy) NSString *postion;
@property (nonatomic, copy) NSString *postionDesc;

@end

NS_ASSUME_NONNULL_END
