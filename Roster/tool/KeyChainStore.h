//
//  KeyChainStore.h
//  TgVideo
//
//  Created by 邓梦超 on 2018/12/3.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KeyChainStore : NSObject
+ (void)save:(NSString*)service data:(id)data;
+ (id)load:(NSString*)service;
+ (void)deleteKeyData:(NSString*)service;
@end

NS_ASSUME_NONNULL_END
