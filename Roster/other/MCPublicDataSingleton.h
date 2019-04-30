//
//  MCPublicDataSingleton.h
//  CommunityThrough
//
//  Created by 邓梦超 on 16/8/12.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<UIKit/UIKit.h>
@interface MCPublicDataSingleton : NSObject
@property(nonatomic, strong) NSDictionary *userDictionary;//保存在本地
@property(nonatomic, strong) NSDictionary *parkDictionary;//保存在本地

@property(nonatomic, assign) BOOL isRequestVersion;
@property(nonatomic, strong) NSString *userUid;
@property(nonatomic, strong) NSString *LoginNuber;
@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *ts;
@property(nonatomic, assign) BOOL isLogin;

@property(nonatomic, strong) NSString *userNumber;
@property(nonatomic, strong) NSString *passWord;
@property(nonatomic,assign) int WXPay;
//等比压缩图片

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

//纠正ios图片方向
+ (UIImage *)fixOrientation:(UIImage *)srcImg;

+ (MCPublicDataSingleton *)sharePublicDataSingleton;

+(NSString *)mpSign:(NSDictionary *)param;
@end
