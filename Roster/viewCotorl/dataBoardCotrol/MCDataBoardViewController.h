//
//  MCDataBoardViewController.h
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"
#import "kpengHorizontalView.h"
#import "MCPickerView.h"
#import "ZZDatePickerView.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MCDataBoardViewController : MCRootViewControler<UIPickerViewDataSource, UIPickerViewDelegate,MCPickerViewDelegate>{
    
    UIView *backView;
    UIView *oderView;
    NSArray *sxArray ;
    UIButton *buttonss;
    kpengHorizontalView *view;
    UIButton *yearsButoon;
    UIButton *monthButoon;
    UIButton *formButoon;
    UIButton *barButoon;
    NSArray *mothArray;
    UIWebView *web;
    UIImageView *backImageView;
    UIView *webbackView;
    UIView *lineV;
}


@end

NS_ASSUME_NONNULL_END
