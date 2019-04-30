//
//  MCPassWordViewControler.m
//  CommunityThrough
//
//  Created by 邓梦超 on 16/6/24.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCPassWordViewControler.h"
#import "MCNewPswViewController.h"
@implementation MCPassWordViewControler
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(NewPsw)];
    
    UILabel *label = [[UILabel alloc] init];;
    if (iPhoneX) {
        label.frame =CGRectMake(20, getRectNavAndStatusHight, 200, 40);
    }else{
        label.frame=CGRectMake(20, getRectNavAndStatusHight, 200, 40);
        
    }
    label.text = @"忘记密码";
    label.font = [UIFont systemFontOfSize:24];
    label.textColor =  COLOR_56_COLOER ;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
   
     UIColor *color = [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1];
    phoneTF = [[UITextField alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(label)+50,SCREEN_WIDTH-40,20)];
     phoneTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入手机号码" attributes:@{NSForegroundColorAttributeName: color}];
    phoneTF.textColor = [UIColor blackColor];
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    UIView * underLine = [[UIView alloc]initWithFrame:CGRectMake(0,phoneTF.frame.size.height+10,phoneTF.frame.size.width,1)];
    [phoneTF becomeFirstResponder];
    underLine.backgroundColor = COLOR_LINE_MC;
    [self.view addSubview:phoneTF];
   
    [phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    phoneTF.inputAccessoryView = self.customView;
    [phoneTF addSubview:underLine];//我这里把underLine添加在pswTF上
    phoneTF.clearButtonMode=UITextFieldViewModeAlways;
    
    
    
    codeTF = [[UITextField alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(phoneTF)+49,SCREEN_WIDTH-40,24)];
    codeTF.backgroundColor = [UIColor clearColor];
    [codeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    codeTF.textColor = [UIColor whiteColor];
    codeTF.inputAccessoryView = self.customView;
    codeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:@{NSForegroundColorAttributeName: color}];
    
    
    UIView * underLine2 = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(codeTF)+5,codeTF.frame.size.width,0.5)];
    underLine2.backgroundColor = COLOR_LINE_MC;
    [self.view addSubview:codeTF];
    [self.view addSubview:underLine2];//我这里把underLine添加在pswTF上
    
    laryView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-125, BOTTOM_Y(phoneTF)+40,105 , 27)];
    [self.view addSubview:laryView];
    laryView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:171 / 255.0 blue:109/ 255.0 alpha:1];
    [laryView.layer setCornerRadius:13.25];
    
    getCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-124, BOTTOM_Y(phoneTF)+41,103 , 25)];
    [self.view addSubview:getCodeButton];
    [getCodeButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [getCodeButton setBackgroundColor:[UIColor whiteColor]];
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeButton setTitleColor:[UIColor colorWithRed:211 / 255.0 green:171 / 255.0 blue:109/ 255.0 alpha:1] forState:UIControlStateNormal];
    [getCodeButton.layer setCornerRadius:13.25];
    [getCodeButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    
    
    
   
   
}

#pragma mark-push重置密码页面
-(void)NewPsw{
    
    MCNewPswViewController *newVC= [[MCNewPswViewController alloc]init];
    newVC.phone = phoneTF.text;
    newVC.code = codeTF.text;
    [self.navigationController pushViewController:newVC animated:YES];
    
    
}
#pragma mark-监听输入框数据
- (void)textFieldDidChange:(UITextField *)textField {
    if (phoneTF.text.length == 11 && codeTF.text.length>0) {
        
        [loginButton setBackgroundColor:YELLOW_COLOER_ZZ];
        loginButton.userInteractionEnabled= YES;
    }else{
        
        [loginButton setBackgroundColor:[UIColor colorWithRed:220 / 255.0 green:223 / 255.0 blue:230 / 255.0 alpha:1]];
        loginButton.userInteractionEnabled= NO;
    }
}
#pragma mark-键盘关闭
- (UIView*)customView {
    if (!_customView) {
        _customView =[[UIView alloc]initWithFrame:CGRectMake(-1, 0, SCREEN_WIDTH+2, 40)];
        _customView.backgroundColor = [UIColor colorWithRed:186/ 255.0 green:194 / 255.0 blue:202/ 255.0 alpha:1];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, 5, 40, 28)];
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:31/ 255.0 green:126 / 255.0 blue:255/ 255.0 alpha:1] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:btn];
    }
    return _customView;
}
- (void)btnClicked{
    [self.view endEditing:YES];
}
- (void)getCode{
    
    
        if (!([phoneTF.text length] == 11) )
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入正确电话号码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            return;
        }
        NSDictionary *sendDict =
        @{
          @"type":@2,
          @"mobile":phoneTF.text,
          @"appID":@"colourlife",
          
          };
//        [MCHttpManager GETWithIPString:BASEURL_AREA urlMethod:@"/sms/code" parameters:sendDict success:^(id responseObject) {
//
//
//            NSDictionary *dicDictionary = responseObject;
//
//            if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"])
//            {
//                if ([dicDictionary[@"content"] isKindOfClass:[NSDictionary class]])
//                {
//
//                    codeTF.text =[NSString stringWithFormat:@"%@",dicDictionary[@"content"][@"smscode"]];
//                    if (phoneTF.text.length == 11 && codeTF.text.length>0) {
//
//                        [loginButton setBackgroundColor:YELLOW_COLOER_ZZ];
//                        loginButton.userInteractionEnabled= YES;
//                    }else{
//
//                        [loginButton setBackgroundColor:[UIColor colorWithRed:220 / 255.0 green:223 / 255.0 blue:230 / 255.0 alpha:1]];
//                        loginButton.userInteractionEnabled= NO;
//                    }
//
//                }
//
//            }
//
//        } failure:^(NSError *error) {
//
//            NSLog(@"error-----%@", error);
//          }
//
//         ];
    
    __block int timeout=60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                [self->getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                
                self->getCodeButton.userInteractionEnabled = YES;
                self->laryView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:171 / 255.0 blue:109/ 255.0 alpha:1];
                [self->getCodeButton setTitleColor:[UIColor colorWithRed:211 / 255.0 green:171 / 255.0 blue:109/ 255.0 alpha:1] forState:UIControlStateNormal];
                self->getCodeButton.backgroundColor = [UIColor whiteColor];
                
            });
            
        }else{
            
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //让按钮变为不可点击的灰色
                
                self->getCodeButton.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:223 / 255.0 blue:230 / 255.0 alpha:1];
                self->laryView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:223 / 255.0 blue:230 / 255.0 alpha:1];
                self->getCodeButton.userInteractionEnabled = NO;
                [self->getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                
                [UIView setAnimationDuration:1];
                
                [self->getCodeButton setTitle:[NSString stringWithFormat:@"重新获取(%@)",strTime] forState:UIControlStateNormal];
                
                [UIView commitAnimations];
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
    

}

-(void)viewWillAppear:(BOOL)animated
{
    UIImage *image = [[UIImage alloc] init];
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.translucent = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    self.navigationController.navigationBar.translucent = NO;
}


@end
