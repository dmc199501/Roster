//
//  UITabBar+MCTabBar.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 2017/9/12.
//  Copyright © 2017年 邓梦超. All rights reserved.
//
#define TabbarItemNums 5.0
#import "UITabBar+MCTabBar.h"

@implementation UITabBar (MCTabBar)
//显示红点
- (void)showBadgeOnItmIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
    //新建小红点
    UIView *bview = [[UIView alloc]init];
    bview.tag = 888+index;
    bview.layer.cornerRadius = 5;
    bview.clipsToBounds = YES;
    bview.backgroundColor = [UIColor redColor];
    CGRect tabFram = self.frame; float percentX = (index+0.6)/TabbarItemNums;
    CGFloat x = ceilf(percentX*tabFram.size.width+10);
    CGFloat y = ceilf(0.1*tabFram.size.height);
    bview.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:bview];
    [self bringSubviewToFront:bview];
    
}

//隐藏红点
-(void)hideBadgeOnItemIndex:(int)index{
    [self removeBadgeOnItemIndex:index];
}

//移除控件
- (void)removeBadgeOnItemIndex:(int)index{
    for (UIView*subView in self.subviews)
    { if (subView.tag == 888+index) {
       
        [subView removeFromSuperview];
        
    } } }


@end
