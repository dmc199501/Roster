//
//  MCChanggePayViewController.m
//  TgWallet
//
//  Created by 邓梦超 on 2018/8/9.
//  Copyright © 2018年 邓梦超. All rights reserved.
//

#import "MCChanggePayViewController.h"

@interface MCChanggePayViewController ()
@property(nonatomic,strong)UITextField *IDField;
@property(nonatomic,strong)UITextField *passwordField;
@property(nonatomic,strong)UITextField *passwordTwo;
@end

@implementation MCChanggePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改支付密码";
    
    
    UILabel *phonelabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 200, 24)];
    phonelabel.text = @"请输入当前支付密码";
    phonelabel.textAlignment = NSTextAlignmentLeft;
    phonelabel.font = [UIFont systemFontOfSize:12];
    phonelabel.textColor =  [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1] ;
    [self.view addSubview:phonelabel];
    
    
    _IDField  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(phonelabel)+5, SCREEN_WIDTH-40, 20)];
    _IDField.backgroundColor = [UIColor clearColor];
    _IDField.placeholder = @"";
    _IDField.textColor = [UIColor whiteColor];
    [self.view addSubview:_IDField];
    _IDField.secureTextEntry = YES;
    _IDField.inputAccessoryView = self.customView;
    
    //_IDField.keyboardType = UIKeyboardTypeNumberPad;
    
    
    _IDField.font = [UIFont systemFontOfSize:14];
    [_IDField becomeFirstResponder];
    
    pwdButtonTwo = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-37, BOTTOM_Y(phonelabel)+5, 17, 12)];
    [pwdButtonTwo setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
    [self.view addSubview:pwdButtonTwo];
    [pwdButtonTwo addTarget:self action:@selector(changgePwsTWO:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView * underLine = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(_IDField)+5,_IDField.frame.size.width,1)];
    [_IDField becomeFirstResponder];
    underLine.backgroundColor = COLOR_LINE_MC;
    
    [self.view addSubview:underLine];//我这里把underLine添加在pswTF上
    
    
    
    
    
    
    _passwordField  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(_IDField)+49, SCREEN_WIDTH-40, 20)];
    _passwordField.backgroundColor = [UIColor clearColor];
    //_passwordField.placeholder = @"输入新密码";
    [self.view addSubview:_passwordField];
    UIColor *color2 = [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1];
    
    _passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入新密码" attributes:@{NSForegroundColorAttributeName: color2}];
    _passwordField.textColor = [UIColor whiteColor];
    _passwordField.font = [UIFont systemFontOfSize:14];
    [_passwordField becomeFirstResponder];
    _passwordField.secureTextEntry = YES;
    
    _passwordField.inputAccessoryView = self.customView;
    
    
    UIView * underLine2 = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(_passwordField)+5,_passwordField.frame.size.width,1)];
    underLine2.backgroundColor = COLOR_LINE_MC;
    [self.view addSubview:_passwordField];
    [self.view addSubview:underLine2];//我这里把underLine添加在pswTF上
    
    
    _passwordTwo  =[[UITextField alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(_passwordField)+49, SCREEN_WIDTH-40, 20)];
    _passwordTwo.backgroundColor = [UIColor clearColor];
    //_passwordTwo.placeholder = @"重复新密码";
    [self.view addSubview:_passwordTwo];
     _passwordTwo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"重复新密码" attributes:@{NSForegroundColorAttributeName: color2}];
    _passwordTwo.textColor = [UIColor whiteColor];
    _passwordTwo.font = [UIFont systemFontOfSize:14];
    [_passwordTwo becomeFirstResponder];
    _passwordTwo.secureTextEntry = YES;
    
    _passwordTwo.inputAccessoryView = self.customView;
    
    
    UIView * underLine3 = [[UIView alloc]initWithFrame:CGRectMake(20,BOTTOM_Y(_passwordTwo)+5,_passwordTwo.frame.size.width,1)];
    underLine3.backgroundColor = COLOR_LINE_MC;
    [self.view addSubview:_passwordTwo];
    [self.view addSubview:underLine3];//我这里把underLine添加在pswTF上
    
    pwdButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-37, BOTTOM_Y(_IDField)+49, 17, 12)];
    [pwdButton setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
    [self.view addSubview:pwdButton];
    [pwdButton addTarget:self action:@selector(changgePws:) forControlEvents:UIControlEventTouchUpInside];
    
    pwdButtonthree = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-37, BOTTOM_Y(_passwordField)+49, 17, 12)];
    [pwdButtonthree setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
    [self.view addSubview:pwdButtonthree];
    [pwdButtonthree addTarget:self action:@selector(changgePwsthree:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-340*SCREEN_WIDTH/375)/2, BOTTOM_Y(_passwordTwo)+40, 333*SCREEN_WIDTH/375, 44)];
    [loginButton setBackgroundColor:YELLOW_COLOER_ZZ];
    
    [loginButton setTitle:@"保存" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [loginButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    [loginButton.layer setCornerRadius:5];
    
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, BOTTOM_Y(loginButton)+20, SCREEN_WIDTH-40, 24)];
    label4.text = @"支付密码为6位数字密码";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:12];
    label4.textColor =  [UIColor colorWithRed:142 / 255.0 green:142 / 255.0 blue:142 / 255.0 alpha:1] ;
    [self.view addSubview:label4];
    // Do any additional setup after loading the view.
}




// Do any additional setup after loading the view.

#pragma -mark-明文安稳切
-(void)changgePws:(UIButton *)sender{
    
    sender.selected = !sender.selected; if (sender.selected) {
        // 按下去了就是明文
        NSString *tempPwdStr = _passwordField.text;
        _passwordField.text = @"";
        // 这句代码可以防止切换的时候光标偏移
        _passwordField.secureTextEntry = NO;
        _passwordField.text = tempPwdStr;
        [pwdButton setBackgroundImage:[UIImage imageNamed:@"密码-可视"] forState:UIControlStateNormal];
        
    }
    else {
        // 暗文
        NSString *tempPwdStr = _passwordField.text;
        _passwordField.text = @"";
        _passwordField.secureTextEntry = YES;
        _passwordField.text = tempPwdStr;
        [pwdButton setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
        
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
        [pwdButtonTwo setBackgroundImage:[UIImage imageNamed:@"密码-可视"] forState:UIControlStateNormal];
        
    }
    else {
        // 暗文
        NSString *tempPwdStr = _IDField.text;
        _IDField.text = @"";
        _IDField.secureTextEntry = YES;
        _IDField.text = tempPwdStr;
        [pwdButtonTwo setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
        
    }
    
    
    
    
}
#pragma -mark-明文安稳切3
-(void)changgePwsthree:(UIButton *)sender{
    
    sender.selected = !sender.selected; if (sender.selected) {
        // 按下去了就是明文
        NSString *tempPwdStr = _passwordTwo.text;
        _passwordTwo.text = @"";
        // 这句代码可以防止切换的时候光标偏移
        _passwordTwo.secureTextEntry = NO;
        _passwordTwo.text = tempPwdStr;
        [pwdButtonthree setBackgroundImage:[UIImage imageNamed:@"密码-可视"] forState:UIControlStateNormal];
        
    }
    else {
        // 暗文
        NSString *tempPwdStr = _passwordTwo.text;
        _passwordTwo.text = @"";
        _passwordTwo.secureTextEntry = YES;
        _passwordTwo.text = tempPwdStr;
        [pwdButtonthree setBackgroundImage:[UIImage imageNamed:@"不可视"] forState:UIControlStateNormal];
        
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
    
    if (!([_IDField.text length] == 6 ))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入旧的6位支付密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (!([_passwordField.text length] == 6 ))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入6位支付密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    if (!([_passwordTwo.text length] == 6 ))
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请重复输入6位支付密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    
    
    if (!([_passwordField.text isEqualToString:_passwordTwo.text]) )
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"两次输入的密码不一致" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    
    
    
    
    NSMutableDictionary *sendDict = [NSMutableDictionary dictionary];
    
    [sendDict setObject:_IDField.text forKey:@"oldpwd"];
    [sendDict setObject:_passwordTwo.text forKey:@"pwd"];
    [sendDict setObject:[Defaults objectForKey:@"uid"] forKey:@"uid"];
    
    [MCHttpManager PutWithIPString:BASEURL_TGQB urlMethod:@"/user/ModfiyPayPwd" parameters:sendDict success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            
            NSLog(@"%@",dicDictionary);
            
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
           
            
            
            
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:dicDictionary[@"message"]];
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"修改失败!"];
        
    }];
    
    
    
    
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
