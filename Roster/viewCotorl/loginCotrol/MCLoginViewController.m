//
//  MCLoginViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/2/26.
//  Copyright © 2019 邓梦超. All rights reserved.
//
#define ZZKeyWindow [UIApplication sharedApplication].keyWindow
#import "MCLoginViewController.h"
#import "MCPassWordViewControler.h"
#import "XBase64WithString.h"
#import "JPUSHService.h"
@interface MCLoginViewController ()<UINavigationControllerDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITextField *IDField;
@property(nonatomic,strong)UITextField *passwordField;
@end

@implementation MCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
   
  
    
    UILabel *label = [[UILabel alloc] init];;
    if (iPhoneX) {
        label.frame =CGRectMake(20, getRectNavAndStatusHight, 200, 40);
    }else{
        label.frame=CGRectMake(20, getRectNavAndStatusHight, 200, 40);
        
    }
    label.text = @"欢迎来到花名册";
    label.font = [UIFont systemFontOfSize:24];
    label.textColor =  COLOR_56_COLOER ;
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
    
     UIColor *color = [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1];
    _IDField  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(label)+50, SCREEN_WIDTH-40, 20)];
    _IDField.backgroundColor = [UIColor clearColor];
    //_IDField.placeholder = @"输入账号";
    _IDField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入账号" attributes:@{NSForegroundColorAttributeName: color}];
    [self.view addSubview:_IDField];
    _IDField.textColor = [UIColor blackColor];
    _IDField.inputAccessoryView = self.customView;
    //_IDField.keyboardType = UIKeyboardTypeNumberPad;
    
    _IDField.clearButtonMode=UITextFieldViewModeAlways;
    _IDField.font = [UIFont systemFontOfSize:16];
    [_IDField becomeFirstResponder];
    _IDField.delegate = self;
    
    UIView * underLine = [[UIView alloc]init];
    if (iPhoneX) {
        underLine.frame = CGRectMake(20,BOTTOM_Y(_IDField)+10,_IDField.frame.size.width,1);
    }else{
        underLine.frame = CGRectMake(20,BOTTOM_Y(_IDField)+5,_IDField.frame.size.width,0.5);
    }
    [_IDField becomeFirstResponder];
    underLine.backgroundColor = COLOR_LINE_MC;
    
    [self.view addSubview:underLine];//我这里把underLine添加在pswTF上
    
    
    
    
   
    
    
    _passwordField  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(_IDField)+49, SCREEN_WIDTH-40, 20)];
    _passwordField.backgroundColor = [UIColor clearColor];
     _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName: color}];
    _passwordField.textColor = [UIColor blackColor];
     [self.view addSubview:_passwordField];
    _passwordField.font = [UIFont systemFontOfSize:16];
    [_passwordField becomeFirstResponder];
    _passwordField.secureTextEntry = YES;
    _passwordField.delegate = self;
    _passwordField.inputAccessoryView = self.customView;
    
    
    UIView * underLine2 = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(_passwordField)+10,_passwordField.frame.size.width,0.5)];
    underLine2.backgroundColor = COLOR_LINE_MC;
    [self.view addSubview:_passwordField];
    [self.view addSubview:underLine2];//我这里把underLine添加在pswTF上
    
    pwdButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-42, BOTTOM_Y(_IDField)+56, 17, 9)];
    [pwdButton setBackgroundImage:[UIImage imageNamed:@"可视"] forState:UIControlStateNormal];
    [self.view addSubview:pwdButton];
    [pwdButton addTarget:self action:@selector(changgePws:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-340*SCREEN_WIDTH/375)/2, BOTTOM_Y(underLine2)+44, 333*SCREEN_WIDTH/375, 44)];
    [loginButton setBackgroundColor:BUTTON_COLOER_ZZ];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginButton addTarget:self action:@selector(getOuth) forControlEvents:UIControlEventTouchUpInside];
    [loginButton.layer setCornerRadius:5];
    [self.view addSubview:loginButton];
   
    UIButton *forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100*SCREEN_WIDTH/375, BOTTOM_Y(loginButton)+10, 100, 40)];
    [self.view addSubview:forgetButton];
    forgetButton.backgroundColor = [UIColor clearColor];
    [forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    forgetButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [forgetButton setTitleColor:BUTTON_COLOER_ZZ forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
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

#pragma -mark授权请求
-(void)getOuth{
    

    if (!([_IDField.text length] >0 ))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入正确账号再提交" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }

    if ([_passwordField.text length] == 0 )
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入密码再提交" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    NSMutableDictionary *sendDict  = [NSMutableDictionary dictionary];
    NSString *outhString = @"5c0f6d86dfcab93ea4647926:0851b6b0f79911e89ed4d55d20b6473d";
    //请求头参数公式 Basic+空格+outhString(base64加密)
    NSString *Authorization = [NSString stringWithFormat:@"Basic %@",[XBase64WithString base64StringFromText:outhString]];

    [sendDict setObject:_IDField.text forKey:@"username"];
    [sendDict setObject:_passwordField.text forKey:@"password"];
    [sendDict setObject:@"password" forKey:@"grant_type"];

    [STTextHudTool showSuccessText:@"登录中..."];
    [MCHttpManager PostOuthWithIPString:BASEURL_OUTH urlMethod:@"/oauth2/token" parameters:sendDict outhWithString:Authorization success:^(id responseObject) {

         NSDictionary *dicDictionary = responseObject;
      

        if ([dicDictionary isKindOfClass:[dicDictionary class]]) {


            NSDictionary *dicDictionary = responseObject;
            

            NSString * access_token = [NSString stringWithFormat:@"%@",dicDictionary[@"access_token"]];
            NSString * expires_in = [NSString stringWithFormat:@"%@",dicDictionary[@"expires_in"]];
            NSString * refresh_token = [NSString stringWithFormat:@"%@",dicDictionary[@"refresh_token"]];
            NSString * password = [NSString stringWithFormat:@"%@",dicDictionary[@"password"]];

            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

            [defaults setObject:access_token forKey:@"access_token"];
            [defaults setObject:expires_in forKey:@"expires_in"];
            [defaults setObject:refresh_token forKey:@"refresh_token"];
            [defaults setObject:password forKey:@"password"];

            NSString *Current = [NSString stringWithFormat:@"%@",[self getCurrentTimes]] ;
             [defaults setObject:Current forKey:@"current"];


            [defaults synchronize];

            [self getUser:access_token];
        }else{


            [STTextHudTool showErrorText:@"授权失败" withSecond:2];

        }










    } failure:^(NSError *error) {


        NSLog(@"%@",error);

    }];

    
    
}
#pragma mark-获取个人信息
-(void)getUser:(NSString *)token{
    
    NSMutableDictionary *sendDict  = [NSMutableDictionary dictionary];

    //请求头公式参数Bearer+空格+token
    NSString *Authorization = [NSString stringWithFormat:@"Bearer %@",token];


    [MCHttpManager GETOuthWithIPString:BASEURL_OUTH urlMethod:@"/user/info" parameters:sendDict outhWithString:Authorization success:^(id responseObject) {

        NSDictionary *dicDictionary = responseObject;
        


            if ([dicDictionary isKindOfClass:[dicDictionary class]]) {



                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

                [defaults setObject:dicDictionary[@"uuid"] forKey:@"uuid"];
                [defaults setObject:dicDictionary[@"username"] forKey:@"username"];

                [defaults synchronize];
                
                SPTabBarController *tabBarViewController = [[SPTabBarController alloc]init];
                
                ZZKeyWindow.rootViewController = tabBarViewController;




        }else{


            [STTextHudTool showErrorText:dicDictionary[@"message"] withSecond:2];

        }



    } failure:^(NSError *error) {


        NSLog(@"%@",error);

    }];
    
}

#pragma -mark忘记密码
- (void)forgetPassWord{
    
    [STTextHudTool showErrorText:@"功能暂未开放" withSecond:1];
   
//    MCPassWordViewControler *passWordVC = [[MCPassWordViewControler alloc]init];
//    [self.navigationController pushViewController:passWordVC animated:YES];
    
    
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
    - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
    {
        [self.view endEditing:YES];
    }
    
    - (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
    {
        [textField resignFirstResponder];
        
        return YES;
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
