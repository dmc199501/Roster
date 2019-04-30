//
//  MCLoginViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/2/26.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"
#import "MCNavigationController.h"
#import "SPTabBarController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MCLoginViewController : MCRootViewControler{
    
     UIButton *pwdButton;
}

@property (nonatomic ,strong)UIView *customView;

@end

NS_ASSUME_NONNULL_END
