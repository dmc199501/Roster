//
//  MCMacroDefinitionHeader.h
//  CommunityThrough
//
//  Created by 邓梦超 on 16/6/21.
//  Copyright © 2016年 邓梦超. All rights reserved.


//
#define getRectNavAndStatusHight  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height
#define getTabBarHight  self.tabBarController.tabBar.bounds.size.height
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneP ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#ifdef DEBUG_MODE
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define ZZ_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:CGSizeMake((maxSize.width) - 5.0, (maxSize.height)) options:(NSStringDrawingUsesLineFragmentOrigin) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define ZZ_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;

#endif
#define BASEURL_ROSTER   @"http://139.9.32.247:7088/v1"
#define BASEURL_GZMX     @"http://139.9.32.247:7092/v1"
#define BASEURL_USER     @"http://139.9.32.247:7090/v1"
#define BASEURL_OUTH     @"http://139.9.32.247:7091"
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define NOTOUCH   0 //禁止侧滑左边弹出主菜单
#define LEFT_X(a)          CGRectGetMinX(a.frame)         //控件左边面的X坐标
#define RIGHT_X(a)         CGRectGetMaxX(a.frame)         //控件右面的X坐标
#define TOP_Y(a)           CGRectGetMinY(a.frame)         //控件上面的Y坐标
#define BOTTOM_Y(a)        CGRectGetMaxY(a.frame)         //控件下面的Y坐标

#define HEIGH(a)             CGRectGetHeight(a.frame)       //控件的高度
#define WIDTH(a)             CGRectGetWidth(a.frame)        //控件的宽度
#define CENTER_X(a)        CGRectGetMidX(a.frame)         //控件的中心X坐标
#define CENTER_Y(a)        CGRectGetMidY(a.frame)         //控件的中心Y坐标

#define COLOR_248_COLOER   [UIColor colorWithRed:248 / 255.0 green:248 / 255.0 blue:248/ 255.0 alpha:1]
#define COLOR_164_COLOER   [UIColor colorWithRed:164 / 255.0 green:165 / 255.0 blue:169/ 255.0 alpha:1]
#define COLOR_56_COLOER   [UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56/ 255.0 alpha:1]
#define COLOR_CELL_VIDOE   [UIColor colorWithRed:22 / 255.0 green:23 / 255.0 blue:37/ 255.0 alpha:1]
#define COLOR_LINE_MC   [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235/ 255.0 alpha:1]
#define COLOR_BACKVIEW_MC    [UIColor colorWithRed:16/ 255.0 green:19 / 255.0 blue:24/ 255.0 alpha:1]
#define  YELLOW_COLOER_ZZ   [UIColor colorWithRed:211 / 255.0 green:171 / 255.0 blue:109/ 255.0 alpha:1]
#define  RED_COLOER_ZZ   [UIColor colorWithRed:255 / 255.0 green:0 / 255.0 blue:85/ 255.0 alpha:1]
#define  LOGIN_COLOER_ZZ   [UIColor colorWithRed:15 / 255.0 green:15 / 255.0 blue:27/ 255.0 alpha:1]
#define  BUTTON_COLOER_ZZ   [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251/ 255.0 alpha:1]

#define FSHOW      [HUD showView:self.view title:@"数据请求失败"];
#define Defaults          [NSUserDefaults standardUserDefaults]

#define USERNAME           [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
#define UUID                 [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"]
#define ACCESS_TOKEN                 [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]
#define EXPIRES_IN                 [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_in"]
#define REFRESH_TOKEN                 [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_token"]
           
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 || [str isEqualToString:@"<null>"]|| [str isEqualToString:@"(null)"] ? YES : NO )
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)








#import <UIKit/UIKit.h>

@interface MCMacroDefinitionHeader : UIViewController


@end
