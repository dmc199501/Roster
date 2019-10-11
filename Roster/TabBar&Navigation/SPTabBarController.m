//
//  SPTabBarController.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 17/2/16.
//  Copyright © 2017年 邓梦超. All rights reserved.
//

#import "SPTabBarController.h"
#import "UIImage+image.h"
#import "MCNavigationController.h"
#import "MCMessageViewController.h"
#import "MCDataBoardViewController.h"
#import "MCAddressBookViewController.h"
#import "MCServiceViewController.h"
#import "MCMineViewController.h"
#import "MCRWViewController.h"
@interface SPTabBarController ()

@end

@implementation SPTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    
    //改变tab顶部线的颜色
    [self.tabBar setShadowImage:[self imageWithColor:[UIColor colorWithRed:159 / 255.0 green:159 / 255.0 blue:159/ 255.0 alpha:1] size:CGSizeMake(SCREEN_WIDTH, 0.5)]];
    
  
    [self setUpAllChildViewController];
   
   
    
    
}
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setUpAllChildViewController
{
   
    MCMessageViewController *messageVC = [[MCMessageViewController alloc] init];
    [self setUpOneChildViewController:messageVC image:[UIImage imageNamed:@"icon-首页"] selectedImage:[UIImage imageWithOriginalName:@"icon-首页-active"] title:@"首页"];
    
    MCRWViewController *rwVC = [[MCRWViewController alloc] init];
    [self setUpOneChildViewController:rwVC image:[UIImage imageNamed:@"审批two"] selectedImage:[UIImage imageWithOriginalName:@"审批-fill"] title:@"任务"];
    
    MCDataBoardViewController *dataVC = [[MCDataBoardViewController alloc]init];
    [self setUpOneChildViewController:dataVC image:[UIImage imageNamed:@"icon-看板"] selectedImage:[UIImage imageWithOriginalName:@"icon-看板-active"] title:@"看板"];
  

    
    MCAddressBookViewController *addressVC = [[MCAddressBookViewController alloc] init];
    [self setUpOneChildViewController:addressVC image:[UIImage imageNamed:@"icon-通讯录"] selectedImage:[UIImage imageWithOriginalName:@"icon-通讯录-active"] title:@"通讯录"];
   

    
   // MCServiceViewController *serviceVC = [[MCServiceViewController alloc] init];
   // [self setUpOneChildViewController:serviceVC image:[UIImage imageNamed:@"icon-服务"] selectedImage:[UIImage imageWithOriginalName:@"icon-服务-active"] title:@"服务"];
    
    MCMineViewController *mineVC = [[MCMineViewController alloc] init];
   
    [self setUpOneChildViewController:mineVC image:[UIImage imageNamed:@"icon-我的"] selectedImage:[UIImage imageWithOriginalName:@"icon-我的-active"] title:@"我的"];
   
   
    

   
   
   
    
    
    
}


#pragma mark - 添加一个子控制器
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    
    
    vc.tabBarItem.selectedImage = selectedImage;
    
    MCNavigationController *nav = [[MCNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
