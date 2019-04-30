//
//  MCNewPswViewController.h
//  CommunityThrough
//
//  Created by 邓梦超 on 2018/6/23.
//  Copyright © 2018年 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

@interface MCNewPswViewController : MCRootViewControler{
    
    UIButton *pwdButton;
    UIButton *pwdButtonTwo;
    
}
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSString *phone;
@property (nonatomic ,strong)UIView *customView;
@end
