//
//  MCNewPswViewController.m
//  CommunityThrough
//
//  Created by 邓梦超 on 2018/6/23.
//  Copyright © 2018年 邓梦超. All rights reserved.
//

#import "MCNewPswViewController.h"
#import "MCLoginViewController.h"
@interface MCNewPswViewController ()
@property(nonatomic,strong)UITextField *IDField;
@property(nonatomic,strong)UITextField *passwordField;
@end

@implementation MCNewPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
    UILabel *label = [[UILabel alloc] init];
    if (iPhoneX) {
        label.frame =CGRectMake(20, getRectNavAndStatusHight, 200, 40);
    }else{
        label.frame=CGRectMake(20, getRectNavAndStatusHight, 200, 40);
        
    }
    label.text = @"重置密码";
    label.font = [UIFont systemFontOfSize:24];
    label.textColor =  [UIColor blackColor] ;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
    
    
    
    
    
    
    
    
    
     UIColor *color = [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1];
    _IDField  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(label)+50, SCREEN_WIDTH-40, 20)];
    _IDField.backgroundColor = [UIColor clearColor];
    _IDField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName: color}];
    _IDField.textColor = [UIColor blackColor];
    [self.view addSubview:_IDField];
    _IDField.inputAccessoryView = self.customView;
    //_IDField.keyboardType = UIKeyboardTypeNumberPad;
    _IDField.secureTextEntry = YES;
   
    _IDField.font = [UIFont systemFontOfSize:16];
    [_IDField becomeFirstResponder];
    
    pwdButtonTwo = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-37, BOTTOM_Y(label)+50, 17, 9)];
    [pwdButtonTwo setBackgroundImage:[UIImage imageNamed:@"可视"] forState:UIControlStateNormal];
    [self.view addSubview:pwdButtonTwo];
    
    [pwdButtonTwo addTarget:self action:@selector(changgePwsTWO:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * underLine = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(_IDField)+5,_IDField.frame.size.width,1)];
    [_IDField becomeFirstResponder];
    underLine.backgroundColor = COLOR_LINE_MC;
    
    [self.view addSubview:underLine];//我这里把underLine添加在pswTF上
    
    
    
    
  
    
//    _passwordField  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(_IDField)+49, SCREEN_WIDTH-40, 20)];
//    _passwordField.backgroundColor = [UIColor clearColor];
//    _passwordField.placeholder = @"";
//     _passwordField.textColor = [UIColor whiteColor];
//    [self.view addSubview:_passwordField];
//    _passwordField.font = [UIFont systemFontOfSize:14];
//    [_passwordField becomeFirstResponder];
//    _passwordField.secureTextEntry = YES;
//
//    _passwordField.inputAccessoryView = self.customView;
//
//
//    UIView * underLine2 = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(_passwordField)+5,_passwordField.frame.size.width,1)];
//    underLine2.backgroundColor = COLOR_LINE_MC;
//    [self.view addSubview:_passwordField];
//    [self.view addSubview:underLine2];//我这里把underLine添加在pswTF上
//
//    pwdButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-37, BOTTOM_Y(_IDField)+49, 17, 12)];
//    [pwdButton setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
//    [self.view addSubview:pwdButton];
//    [pwdButton addTarget:self action:@selector(changgePws:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(underLine)+20, SCREEN_WIDTH-40, 24)];
    label4.text = @"密码长度必须为8位以上,且同时包含数字和字母";
    label4.textAlignment = NSTextAlignmentLeft;
    label4.font = [UIFont systemFontOfSize:14];
    label4.textColor =  [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1] ;
    [self.view addSubview:label4];
    
    
    // Do any additional setup after loading the view.
}

#pragma -mark-明文安稳切
-(void)changgePws:(UIButton *)sender{
    
    sender.selected = !sender.selected; if (sender.selected) {
        // 按下去了就是明文
        NSString *tempPwdStr = _passwordField.text;
        _passwordField.text = @"";
        // 这句代码可以防止切换的时候光标偏移
        _passwordField.secureTextEntry = NO;
        _passwordField.text = tempPwdStr;
        [pwdButton setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
        
    }
    else {
        // 暗文
        NSString *tempPwdStr = _passwordField.text;
        _passwordField.text = @"";
        _passwordField.secureTextEntry = YES;
        _passwordField.text = tempPwdStr;
        [pwdButton setBackgroundImage:[UIImage imageNamed:@"可视"] forState:UIControlStateNormal];
        
    }
    
    
    
    
}
#pragma -mark-明文安稳切2
-(void)changgePwsTWO:(UIButton *)sender{
    
    sender.selected = !sender.selected; if (sender.selected) {
        // 按下去了就是明文
        NSString *tempPwdStr = _IDField.text;
        _IDField.text = @"";
        // 这句代码可以防止切换的时候光标偏移
        _IDField.secureTextEntry = NO;
        _IDField.text = tempPwdStr;
        [pwdButtonTwo setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
        
    }
    else {
        // 暗文
        NSString *tempPwdStr = _IDField.text;
        _IDField.text = @"";
        _IDField.secureTextEntry = YES;
        _IDField.text = tempPwdStr;
        [pwdButtonTwo setBackgroundImage:[UIImage imageNamed:@"可视"] forState:UIControlStateNormal];
        
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
- (void)next{
    
    if (!([_IDField.text length] >= 6 ))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入6位以上密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    
    
    if (!([_passwordField.text isEqualToString:_IDField.text]) )
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"两次输入的密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    
    
    
    
    NSMutableDictionary *sendDict = [NSMutableDictionary dictionary];
    [sendDict setObject:_phone forKey:@"mobile"];
    [sendDict setObject:_code forKey:@"code"];
    [sendDict setObject:_passwordField.text forKey:@"pwd"];
    
//   [MCHttpManager PutWithIPString:BASEURL_TGQB urlMethod:@"/user/modfiyPwdbymobile" parameters:sendDict success:^(id responseObject) {
//        
//        NSDictionary *dicDictionary = responseObject;
//        
//        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
//        {
//           
//                NSLog(@"%@",dicDictionary);
//                
//                [SVProgressHUD showSuccessWithStatus:@"重置成功"];
//                
//                NSArray *vcArray = self.navigationController.viewControllers;
//                for(UIViewController *vc in vcArray)
//                {
//                    if ([vc isKindOfClass:[MCLoginViewControler class]])
//                    {
//                        [self.navigationController popToViewController:vc animated:YES];
//                    }
//                }
//                
//                
//          
//            
//            
//            
//            
//        }else{
//            
//            [SVProgressHUD showErrorWithStatus:dicDictionary[@"message"]];
//            
//        }
//        
//        
//        
//        
//    } failure:^(NSError *error) {
//        
//        [SVProgressHUD showErrorWithStatus:@"重置失败!"];
//       
//    }];
    
    
    
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
