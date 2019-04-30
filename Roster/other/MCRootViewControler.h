//
//  MCRootViewControler.h
//  CommunityThrough
//
//  Created by 邓梦超 on 16/6/7.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMacroDefinitionHeader.h"
#import "MCHttpManager.h"
#import "SVProgressHUD.h"
#import "MCBackVIew.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "STTextHudTool.h"
@interface MCRootViewControler : UIViewController
@property(nonatomic,strong) MBProgressHUD *HUD;
/**开发中弹出框*/
- (void)TextButtonAction;
-(void)VIPTextButtonAction;
/**数字逗号隔开*/
-(NSString *)countNumAndChangeformat:(NSString *)num;
/**删除数组中的空*/
- (NSMutableArray *)removeNullFromArray:(NSArray *)arr;
/**删除字典中的空*/
- (NSMutableDictionary *)removeNullFromDictionary:(NSDictionary *)dic;
/**根据字符大小计算宽度*/
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
/**根据字符大小计算高度*/
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
//获取UUID
- (NSString *)getUUIDByKeyChain;
/**时间转化为刚刚-几分钟前*/
-(NSString *)compareCurrentTime:(NSString *)str;
/**获取当前时间*/
-(NSString*)getCurrentTimes;
/**字符串转时间*/
-(NSDate *)dateFromString:(NSString *)string;
@end
