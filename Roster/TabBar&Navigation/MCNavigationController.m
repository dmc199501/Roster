//
//  MCNavigationController.m
//  CommunityThrough
//
//  Created by 邓梦超 on 16/6/7.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCNavigationController.h"
#import "MCMacroDefinitionHeader.h"
@interface MCNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (assign, nonatomic) BOOL isCanSideBack;
@end
@implementation MCNavigationController

+ (void)initialize{
    
    // 1 .设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    //（1）设置背景图片
   
    [navBar setBarTintColor:[UIColor whiteColor]];
    //[navBar setBackgroundImage:[UIImage imageNamed:@"navigationBG"] forBarMetrics:UIBarMetricsDefault];
    //（2）设置标题文字的属性－－颜色，字体大小
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize: 18];
    navBar.titleTextAttributes = attrs;
    navBar.translucent = NO;
    //----------------------------------------------------------------
    // 2 .设置导航条上面的导航按钮的主题（字体颜色， 字体大小）
    // (1)
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize: 18];
    [item setTitleTextAttributes: itemAttrs forState: UIControlStateNormal];
    // (2)设置返回剪头的的颜色（实际上设置的是导航栏的背景颜色）
    navBar.tintColor = [UIColor blackColor]; //设置为了黑色
    
   
 

}


//重写Push这个方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count) {
        //viewController.hidesBottomBarWhenPushed = YES; //表示push到下一个页面的时候隐藏标签栏
        //修改
        UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"左箭头"]  style:UIBarButtonItemStylePlain target:self action:@selector(popCurrentViewController)];
        
        viewController.navigationItem.leftBarButtonItem = left;
        
        
    }


   
    [super pushViewController: viewController animated: animated];
    

   
    
    

}



- (void)popCurrentViewController
{
   
    [self popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        UIViewController *vc = self.viewControllers.lastObject;
    // 禁用某些不支持侧滑返回的页面
//        if ([vc isKindOfClass:[MCpalyViewController class]]) {
//
//                                if (vc.view.frame.size.width >vc.view.frame.size.height) {
//
//                                     self.interactivePopGestureRecognizer.enabled = NO;
//                                }
//        }
    //if ([vc isKindOfClass:[MCNewViewController class]]) { return NO; }
    // 禁用根目录的侧滑手势
    if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] ) { return NO; } }
    
    return YES;
    
}
    
    
   
- (void)viewDidLoad{

    [super viewDidLoad];
    
   
    
   
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;

        
    }
    
    
}



@end
