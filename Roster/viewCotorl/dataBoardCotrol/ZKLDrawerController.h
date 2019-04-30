//
//  ZKLDrawerController.h
//  ZKLDrawerController
//
//  Created by zkl on 2018/1/4.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKLDrawerController : UIViewController
/**
 初始化
 @param centerVC 中间的视图控制器
 @param leftVC   左边的视图控制器
 */
- (instancetype)initWithCenterViewController:(UIViewController *)centerVC
                          leftViewController:(UIViewController *)leftVC;


/**
 显示左视图
 */
- (void)showLeftView; 
@end
