//
//  MCPassWordViewControler.h
//  CommunityThrough
//
//  Created by 邓梦超 on 16/6/24.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

@interface MCPassWordViewControler : MCRootViewControler{
    UIButton *getCodeButton;
    UITextField * phoneTF;
    UITextField * codeTF;
    UIView *laryView;
    UIButton *loginButton;
}
@property (nonatomic ,strong)UIView *customView;
@end
