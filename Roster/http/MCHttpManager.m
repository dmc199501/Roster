//
//  MCHttpManager.m
//  CommunityThrough
//
//  Created by 邓梦超 on 16/7/6.
//  Copyright © 2016年 邓梦超. All rights reserved.
//
#define APP_IDROSTER     @"5c0f6d86dfcab93ea4647926"
#define secret @"HMC"
#import "MCHttpManager.h"
#import "AFNetworking.h"
#import "MyMD5.h"
#import "MCPublicDataSingleton.h"
#import <CommonCrypto/CommonCryptor.h>
#import "XBase64WithString.h"
@implementation MCHttpManager



+ (void)GETWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    mgr.requestSerializer.timeoutInterval = 15.f;
    
    [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
    
    [param setObject:APP_IDROSTER forKey:@"appID"];
    [param setObject:curTime forKey:@"ts"];
    [param setObject:secret forKey:@"secret"];
   
   
   //NSLog(@"get签名--%@",[MCPublicDataSingleton mpSign:param]);
    //在这里可以给sendDictionary配一些公共参数，以及签名操作
    NSString *allURL = [NSString stringWithFormat:@"%@%@",IPString, urlMethod];
    //签名sign
    NSString *signStr = [MyMD5 md5:[NSString stringWithFormat:@"%@",[MCPublicDataSingleton mpSign:param]]];
    [param setObject:signStr forKey:@"sign"];
   
   
   
    
  
    
    [mgr GET:allURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
       
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
       
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}

+ (void)GETOuthWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary outhWithString:(NSString *)outhString success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    mgr.requestSerializer.timeoutInterval = 15.f;
    
    [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    [mgr.requestSerializer setValue:outhString forHTTPHeaderField:@"Authorization"];
   
    
    
    
    
    //在这里可以给sendDictionary配一些公共参数，以及签名操作
    NSString *allURL = [NSString stringWithFormat:@"%@%@",IPString, urlMethod];
   
    
    [mgr GET:allURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        //NSLog(@"MGR-----%@",[mgr description]);
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}
+ (void)GETTsWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    
    
    
    
   
    
    [mgr GET:IPString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
       
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
      
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}





+ (void)PostWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
    mgr.requestSerializer.timeoutInterval = 10.f;
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    // [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
   
    
    //在这里可以给sendDictionary配一些公共参数，以及签名操作
   
    //签名sign
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //签名字典
    [dic setObject:APP_IDROSTER forKey:@"appID"];
    [dic setObject:curTime forKey:@"ts"];
    [dic setObject:secret forKey:@"secret"];
    //传递字典
    [param setObject:APP_IDROSTER forKey:@"appID"];
    [param setObject:curTime forKey:@"ts"];
   
    
    
    
   
    NSString *signStr = [MyMD5 md5:[NSString stringWithFormat:@"%@",[MCPublicDataSingleton mpSign:dic]]];
    
    //NSLog(@"签名%@",[MCPublicDataSingleton mpSign:dic]);
    [param setObject:signStr forKey:@"sign"];
     NSString *allURL = [NSString stringWithFormat:@"%@%@?appID=%@&sign=%@&ts=%@",IPString, urlMethod,APP_IDROSTER,signStr,curTime];
    NSLog(@"参数%@",allURL);
    
    [mgr POST:allURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
      //  NSLog(@"MGR-----%@",[mgr description]);
        
      //  NSLog(@"----%lld",downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
       // NSLog(@"MGR-----%@",[mgr description]);
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}

+ (void)PostOuthWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary outhWithString:(NSString *)outhString success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
{
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    //返回数据格式为json格式，不需要再json解析了
    mgr.requestSerializer.timeoutInterval = 10.f;
    
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
   [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
   // NSLog(@"请求头%@",outhString);
    [mgr.requestSerializer setValue:outhString forHTTPHeaderField:@"Authorization"];
   
    
   
    
    //在这里可以给sendDictionary配一些公共参数，以及签名操作
    NSString *allURL = [NSString stringWithFormat:@"%@%@",IPString, urlMethod];
    //签名sign
   
   // NSLog(@"-allURL-%@--param---%@", allURL,param);
    
    [mgr POST:allURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
      //  NSLog(@"----%lld",downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        
        if (success) {
            
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
    }];
}


+ (void)PutWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
     mgr.requestSerializer.timeoutInterval = 10.f;
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
//        [mgr.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //签名字典
    [dic setObject:APP_IDROSTER forKey:@"appID"];
    [dic setObject:curTime forKey:@"ts"];
    [dic setObject:secret forKey:@"secret"];
    //传递字典
    [param setObject:APP_IDROSTER forKey:@"appID"];
    [param setObject:curTime forKey:@"ts"];
    
    
    
    
    
    NSString *signStr = [MyMD5 md5:[NSString stringWithFormat:@"%@",[MCPublicDataSingleton mpSign:dic]]];
    
   // NSLog(@"签名%@",[MCPublicDataSingleton mpSign:dic]);
    [param setObject:signStr forKey:@"sign"];
    NSString *allURL = [NSString stringWithFormat:@"%@%@?appID=%@&sign=%@&ts=%@",IPString, urlMethod,APP_IDROSTER,signStr,curTime];
   // NSLog(@"参数%@",allURL);
    
    [mgr PUT:allURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //    NSLog(@"%@",responseObject);
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        
        if (success) {
            
            success(responseObject);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }

        
    }     ];
}

+ (void)DeleteWithIPString:(NSString *)IPString  urlMethod:(NSString *)urlMethod parameters:(NSDictionary *)sendDictionary success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: sendDictionary];
    
    // 创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    //[mgr.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
    
    [param setObject:APP_IDROSTER forKey:@"appID"];
    [param setObject:curTime forKey:@"ts"];
    [param setObject:secret forKey:@"secret"];
    
    
    //NSLog(@"get签名--%@",[MCPublicDataSingleton mpSign:param]);
    //在这里可以给sendDictionary配一些公共参数，以及签名操作
    NSString *allURL = [NSString stringWithFormat:@"%@%@",IPString, urlMethod];
    //签名sign
    NSString *signStr = [MyMD5 md5:[NSString stringWithFormat:@"%@",[MCPublicDataSingleton mpSign:param]]];
    [param setObject:signStr forKey:@"sign"];
    
    
    [mgr DELETE:allURL parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
        // AFN请求成功时候调用block
        // 先把请求成功要做的事情，保存到这个代码块
        
        if (success) {
            
            success(responseObject);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            failure(error);
        }
        
        
    }     ];
}


+ (void)upUserHeadWithIPString:(NSString *)IPString  urlMethod:(NSString *)url andDictionary:(NSDictionary *)parame andImage:(NSMutableArray *)imageArray success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure{

    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary: parame];
    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    // 创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //返回数据格式为json格式，不需要再json解析了
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    //[manager.requestSerializer setValue:@"application/x-www-form-urlencoded"forHTTPHeaderField:@"Content-Type"];
    
    
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
    
    
    //在这里可以给sendDictionary配一些公共参数，以及签名操作
    
    //签名sign
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    //签名字典
    [dic setObject:APP_IDROSTER forKey:@"appID"];
    [dic setObject:curTime forKey:@"ts"];
    [dic setObject:secret forKey:@"secret"];
    //传递字典
    [param setObject:APP_IDROSTER forKey:@"appID"];
    [param setObject:curTime forKey:@"ts"];
    
    
    
    
    
    NSString *signStr = [MyMD5 md5:[NSString stringWithFormat:@"%@",[MCPublicDataSingleton mpSign:dic]]];
    
   // NSLog(@"签名%@",[MCPublicDataSingleton mpSign:dic]);
    [param setObject:signStr forKey:@"sign"];
    NSString *allURL = [NSString stringWithFormat:@"%@%@?appID=%@&sign=%@&ts=%@",IPString, url,APP_IDROSTER,signStr,curTime];
   // NSLog(@"参数%@",allURL);
    
    
//   NSString* urlString = [allURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
     [manager POST:allURL parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imageArray.count) {
            NSData *data = [NSData data];
            for (NSDictionary *image in imageArray) {
                data = UIImagePNGRepresentation(image[@"image"]);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss.SS";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                
                [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
      
        if (success) {
            
            success(responseObject);
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



@end
