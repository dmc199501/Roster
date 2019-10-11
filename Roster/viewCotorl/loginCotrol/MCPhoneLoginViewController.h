//
//  MCPhoneLoginViewController.h
//  Roster
//
//  Created by 邓梦超 on 2019/8/6.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCPhoneLoginViewController : MCRootViewControler{
    UIButton *getCodeButton;
    UITextField * phoneTF;
    UITextField * codeTF;
    UIView *laryView;
    UIButton *loginButton;
}
@property (nonatomic ,strong)UIView *customView;

@end

NS_ASSUME_NONNULL_END
