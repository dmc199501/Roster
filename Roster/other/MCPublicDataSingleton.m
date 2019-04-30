//
//  MCPublicDataSingleton.m
//  CommunityThrough
//
//  Created by 邓梦超 on 16/8/12.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCPublicDataSingleton.h"

@implementation MCPublicDataSingleton
+ (MCPublicDataSingleton *)sharePublicDataSingleton;
{
    static MCPublicDataSingleton *sharePublicDataSingleton;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        //        DLog(@"第一次创建tabbar");
        sharePublicDataSingleton = [[MCPublicDataSingleton alloc] init];
       
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        if ([defaults objectForKey:@"userInfo"] && sharePublicDataSingleton.userDictionary == nil)
        {
            sharePublicDataSingleton.userDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        }
        
        
    });
    
    return sharePublicDataSingleton;
}

#pragma mark 等比压缩图片

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}

+ (UIImage *)fixOrientation:(UIImage *)srcImg
{
    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (srcImg.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, srcImg.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (srcImg.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, srcImg.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, srcImg.size.width, srcImg.size.height,
                                             CGImageGetBitsPerComponent(srcImg.CGImage), 0,
                                             CGImageGetColorSpace(srcImg.CGImage),
                                             CGImageGetBitmapInfo(srcImg.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (srcImg.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.height,srcImg.size.width), srcImg.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,srcImg.size.width,srcImg.size.height), srcImg.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma -mark参数排序加密
+(NSString *)mpSign:(NSDictionary *)param{
    
    NSArray *array = param.allKeys;
    
    NSMutableArray * array1 =[[NSMutableArray alloc]initWithArray:array];
    
    
    //冒泡
    
    for (int i =0; i<[array1 count]-1; i++) {
        
        for (int j =0; j<[array1 count]-1-i; j++) {
            
            if(([array1[j] compare:array1[j+1]]) == NSOrderedDescending){
                
                //交换
                
                [array1 exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                
                
            }
            
        }
        
    }
    NSMutableArray *stringArray = [NSMutableArray array];
    for (int i=0; i<array1.count; i++) {
        
        NSString *sting = [NSString stringWithFormat:@"%@=%@",array1[i],[param objectForKey:array1[i]]];
        [stringArray addObject:sting];
        
    }
    NSString *string = [stringArray componentsJoinedByString:@","];
    string=[string stringByReplacingOccurrencesOfString:@","withString:@"&"];
    
    return string;
    
};

@end
