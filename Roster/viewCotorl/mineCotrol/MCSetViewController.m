//
//  MCSetViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/2/26.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCSetViewController.h"
#import "MyTableViewCell.h"
#import "MCLoginViewController.h"
#import "MCWebViewController.h"
#import "MCChangePswViewController.h"
#import "MCPhoneLoginViewController.h"
@interface MCSetViewController ()
@property(nonatomic,strong)NSString *addressURL;
@end

@implementation MCSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =COLOR_248_COLOER;
    self.navigationItem.title = @"更多设置";
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    // Do any additional setup after loading the view.
}

// 设备支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait; // 或者其他值 balabala~
}

// 开启自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    
    if (size.width > size.height) { // 横屏
        // 横屏布局 balabala
        listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
        [listTableView reloadData];
      
        
        ;
    } else {
        // 竖屏布局 balabala
        listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
        [listTableView reloadData];
     
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 68;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    switch (section)
    {
        case 0:
        {
            return 0;
        }
            break;
            
        default:
        {
            return 10.00;
        }
            break;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    
    return 0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (section)
    {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    
    return 0;
    
    //    return ((NSArray *)([listMutableArray objectAtIndex:section])).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *indentifier = [NSString stringWithFormat:@"cell%@%@",@(indexPath.section), @(indexPath.row)];
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    if (indexPath.section == 1) {
        
        cell.titleLabel.frame = CGRectMake(19, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20);
        cell.contentLabel.frame = CGRectMake(SCREEN_WIDTH-([[UIScreen mainScreen] bounds].size.width - 130)-20, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20);
        cell.contentLabel.textAlignment = NSTextAlignmentRight;
       [cell.titleLabel setText:@"版本检测"];
         NSString *bdVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        [cell.contentLabel setText:bdVersion];
        
    }else if(indexPath.section == 0){
        
        cell.titleLabel.frame = CGRectMake(19, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20);
        switch (indexPath.row) {
            case 0:
            {
                
                [cell.titleLabel setText:@"关于花名册"];
                
            }
                break;
            case 1:
            {
                [cell.titleLabel setText:@"修改密码"];
               
            }
                break;
            case 2:
            {
                [cell.titleLabel setText:@"清空首页列表消息"];
                
            }
                break;
           
                
                
            default:
                break;
        }
        
    }else{
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, [[UIScreen mainScreen] bounds].size.width, 20)];
        [label setTextColor: [UIColor colorWithRed:229 / 255.0 green:64 / 255.0 blue:42/ 255.0 alpha:1]];
        [label setText:@"退出登录"];
        label.textAlignment  = NSTextAlignmentCenter;
        [label setFont:[UIFont systemFontOfSize:18]];
        [cell addSubview:label];
        cell.titleLabel.text = @"    ";
    }
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    MyTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if ([cell.titleLabel.text isEqualToString:@"关于花名册"]) {
        
//        MCWebViewController *webViewController = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:@"https://www.jianshu.com/p/62343a955f22"]  titleString:@"测试"];
//        webViewController.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:webViewController animated:YES];
        [STTextHudTool showErrorText:@"功能暂未开放"];
    }
    
    if ([cell.titleLabel.text isEqualToString:@"修改密码"]) {
        
        MCChangePswViewController *pswVC = [[MCChangePswViewController alloc]init];
        pswVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pswVC animated:YES];
    }
    if ([cell.titleLabel.text isEqualToString:@"    "])
    {
        
        
        UIAlertView *inputPassword = [[UIAlertView alloc] initWithTitle:@"" message:@"确认退出登录？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        inputPassword.alertViewStyle = UIAlertViewStyleDefault;
        inputPassword.delegate = self;
        inputPassword.tag = 1555;
        [inputPassword show];
        
        
    }
    if ([cell.titleLabel.text isEqualToString:@"版本检测"])
    {
        
        [self getVersion];
        
        
    }
    if ([cell.titleLabel.text isEqualToString:@"清空首页列表消息"])
    {
        
        UIAlertView *inputPassword = [[UIAlertView alloc] initWithTitle:@"" message:@"确认清空首页消息列表？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        inputPassword.alertViewStyle = UIAlertViewStyleDefault;
        inputPassword.delegate = self;
        inputPassword.tag = 1557;
        [inputPassword show];
        
        
    }
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag  == 1555)
    {
        if (buttonIndex ==0)
        {
            
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uuid"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"info"];
           
            [[NSUserDefaults standardUserDefaults] synchronize];
            MCPhoneLoginViewController *LoginView = [[MCPhoneLoginViewController alloc]init];
            
            
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];  // 获得根窗口
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LoginView];
            window.rootViewController = nav;
            
            
        }
        
    }else  if(alertView.tag  == 1557){
        
        if (buttonIndex == 0) {
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            
            NSString *username = [defaults objectForKey:@"username"];
            NSMutableDictionary *sendMutabelDictionary = [NSMutableDictionary dictionary];
          
           
            [sendMutabelDictionary setValue:username forKey:@"username"];
            
            
            //userToken    否    登录的时效身份标识  deviceSN    是    设备唯一序列号   deviceType    否    设备类型   pushID    是    pushID>0只删除当前pushID，不考虑删除全部  deleteAll    是    等于0时，删除pushID数据
            [MCHttpManager DeleteWithIPString:BASEURL_ROSTER urlMethod:@"/homepush/deleteall" parameters:sendMutabelDictionary success:^(id responseObject) {
                
                NSDictionary *dicDictionary = responseObject;
            
                if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"])
                {
                    
                    [STTextHudTool showSuccessText:@"清空成功"];
                    
                  
                }else{
                    
                     [STTextHudTool showSuccessText:@"清空失败"];
                }
                
                
                
            } failure:^(NSError *error) {
                
               
                [STTextHudTool showSuccessText:@"清空失败"];
            }];
        
        }else if (alertView.tag == 1558){
            
            if (buttonIndex == 0) {
            
                NSString *URLencodeString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self.addressURL, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
                NSString *installURL = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@", URLencodeString];
                NSURL *openURL = [NSURL URLWithString:installURL];
                [[UIApplication sharedApplication] openURL:openURL];
            }
            
           
            
        }
    
    
}
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
}
#pragma -mark版本更新
-(void)getVersion{
    
    NSString *idUrlString = @"http://api.fir.im/apps/latest/5cac6756959d69409c4514ca?api_token=c5336bb99c57cefedfe6d0d5297c8765";
    NSURL *requestURL = [NSURL URLWithString:idUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue currentQueue]completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            //do something
            
        }else {
            NSError *jsonError = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            
            NSString *bdVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//获取项目版本号
            NSString *loadVersion = [NSString stringWithFormat:@"%@",result[@"versionShort"]];
            NSString *changelog = [NSString stringWithFormat:@"%@",result[@"changelog"]];
            
            if (!kStringIsEmpty(loadVersion)) {
                self.addressURL = [NSString stringWithFormat:@"%@",result[@"install_url"]];
                
                
                NSArray *versions1 = [bdVersion componentsSeparatedByString:@"."]; NSArray *versions2 = [loadVersion componentsSeparatedByString:@"."]; NSMutableArray *ver1Array = [NSMutableArray arrayWithArray:versions1]; NSMutableArray *ver2Array = [NSMutableArray arrayWithArray:versions2];
                // 确定最大数组
                NSInteger a = (ver1Array.count> ver2Array.count)?ver1Array.count : ver2Array.count;
                // 补成相同位数数组
                if (ver1Array.count < a) { for(NSInteger j = ver1Array.count; j < a; j++) { [ver1Array addObject:@"0"]; } } else { for(NSInteger j = ver2Array.count; j < a; j++) { [ver2Array addObject:@"0"]; } }
                // 比较版本号
                int result = [self compareArray1:ver1Array andArray2:ver2Array];
                if(result == 1) { NSLog(@"V1 > V2");
                    
                     [STTextHudTool showText:@"已经是最新版本" withSecond:1];
                }
                else if (result == -1) { NSLog(@"V1 < V2");
                    NSString *titelStr = @"检查更新";
                    NSString *messageStr = changelog;
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titelStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
                    alert.tag = 1558;
                    [alert show];
                    
                    
                } else if (result ==0 ) { NSLog(@"V1 = V2"); }
                
                [STTextHudTool showText:@"已经是最新版本" withSecond:1];
                
                
            }
            
            
            if (!jsonError && [result isKindOfClass:[NSDictionary class]]) {
                //do something
                
            }
        }
    }];
}

- (int)compareArray1:(NSMutableArray *)array1 andArray2:(NSMutableArray *)array2 { for (int i = 0; i< array2.count; i++) { NSInteger a = [[array1 objectAtIndex:i] integerValue]; NSInteger b = [[array2 objectAtIndex:i] integerValue]; if (a > b) { return 1; } else if (a < b) { return -1; } } return 0; }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
