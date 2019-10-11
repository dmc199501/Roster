//
//  MCMineViewController.m
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCMineViewController.h"
#import "MCMineTableViewCell.h"
#import "MCSalaryViewController.h"
#import "MCUserInfoViewController.h"
#import "MCSetViewController.h"
#import "MCWebViewController.h"
#import "XBase64WithString.h"
#import "DownListViewController.h"
@interface MCMineViewController ()<MCUserDelegateViewControllerDelegate>

@end

@implementation MCMineViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        listMutableArray = [NSMutableArray array];
        [listMutableArray addObject:@[@{@"icon": @"我的-个人档案", @"title":@"个人档案"}]];
        [listMutableArray addObject:@[@{@"icon": @"我的-薪酬查询", @"title":@"薪酬查询"}]];
        
        [listMutableArray addObject:@[@{@"icon": @"download", @"title":@"我的下载"}]];
        [listMutableArray addObject:@[@{@"icon": @"我的-设置", @"title":@"系统设置"}]];
        
       
        
        
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // 屏幕旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];

  
    
  
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    //[backView setBackgroundColor: YELLOW_COLOER_ZZ];
    [self.view addSubview:backView];
    
    
    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(19, 25, 60, 60)];
    [backView addSubview:iconImageView];
    [iconImageView.layer setCornerRadius:5];
    [iconImageView setImage:[UIImage imageNamed:@"默认头像"]];
    [iconImageView setClipsToBounds:YES];
    
    UIButton *gerenButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 50, 80, 80)];
    [backView addSubview:gerenButton];
    //[gerenButton addTarget:self action:@selector(puGr) forControlEvents:UIControlEventTouchUpInside];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 40, SCREEN_WIDTH-90, 20)];
    nameLabel.text = @"无";
    nameLabel.textColor = COLOR_56_COLOER;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:18];
    [backView addSubview:nameLabel];
    
    jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 60, SCREEN_WIDTH-90, 20)];
    jobLabel.text = @"无";
    jobLabel.textColor = COLOR_164_COLOER;
    jobLabel.textAlignment = NSTextAlignmentLeft;
    jobLabel.font = [UIFont systemFontOfSize:12];
    [backView addSubview:jobLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 10)];
    [backView addSubview:line];
    line.backgroundColor = COLOR_248_COLOER;
    
    UIButton *userVcButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    [backView addSubview:userVcButton];
    [userVcButton addTarget:self action:@selector(pushUserVC) forControlEvents:UIControlEventTouchUpInside];
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setTableHeaderView:backView];
    [listTableView setDataSource:self];
    
    [self setUserIcon];
    // Do any additional setup after loading the view.
}

//切屏重新设置frame
- (void)deviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    for (UIView *view in self.view.subviews) {
        
        [view removeFromSuperview];
    }
    [self viewDidLoad];
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma -mark设置用户头像等信息
-(void)setUserIcon{
    
    NSDictionary *userDic = [Defaults objectForKey:@"info"];
    
    NSString *iconString = [NSString stringWithFormat:@"%@",userDic[@"icon"]];
    if (!kStringIsEmpty(iconString)) {

        [iconImageView setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    }else{

        [iconImageView setImage:[UIImage imageNamed:@"默认头像"]];
    }
    
    [nameLabel  setText:[NSString stringWithFormat:@"%@",userDic[@"realname"]]];
    [jobLabel  setText:[NSString stringWithFormat:@"%@|%@",userDic[@"orgname"],userDic[@"jobname"]]];
    
    
    
}

-(void)pushUserVC{
    
    MCUserInfoViewController *userVC = [[MCUserInfoViewController alloc]init];
    userVC.delegate = self;
    userVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userVC animated:YES];
    
    
}

#pragma -mark修改信息后刷新UI
-(void)delegateViewControllerDidClickIconString:(NSString *)string{
    
    [self getUserInformation];
    
}

#pragma -mark获取个人信息
-(void)getUserInformation{
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"uuid"];
    NSString *string = [NSString stringWithFormat:@"/adminuser/adminuser//%@",UUID];
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:string parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"];
            
            if ([dicDictionary[@"content"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
            {
                
                
                
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[self removeNullFromDictionary:dicDictionary[@"content"][0]] forKey:@"info"];
                [defaults synchronize];
                [self setUserIcon];
                
                
            }else{
                
              
            }
            
            
        }else{
            
           
            
            
        }
        

        
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 60;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return listMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return ((NSArray *)([listMutableArray objectAtIndex:section])).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *indentifier = [NSString stringWithFormat:@"cell%@%@",@(indexPath.section), @(indexPath.row)];
    MCMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCMineTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
        [cell.iconImageView setImage:[UIImage imageNamed:[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"icon"]]];
        [cell.titleLabel setText:[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"title"]];
        if (indexPath.section==2) {
            cell.iconImageView.frame = CGRectMake(19, 20, 24, 19);
        }
       
        
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    MCMineTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if ([cell.titleLabel.text isEqualToString:@"薪酬查询"])
    {
        NSString *dauuid = [Defaults objectForKey:@"dauuid"];
        NSLog(@"%@",dauuid);
        if (!kStringIsEmpty(dauuid)) {
           
            MCSalaryViewController *salryVC = [[MCSalaryViewController alloc]init];
            salryVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:salryVC animated:YES];
            
            
        }else{
            
            [STTextHudTool showErrorText:@"未绑定档案信息" withSecond:2];
        }
       
        
        
        
    }
    if ([cell.titleLabel.text isEqualToString:@"个人档案"])
    {
         NSString *dauuid = [Defaults objectForKey:@"dauuid"];
        if (!kStringIsEmpty(dauuid)) {
           
            NSString * current = [NSString stringWithFormat:@"%@",[Defaults objectForKey:@"current"]];
            NSString * endTime = [NSString stringWithFormat:@"%@",[self getCurrentTimes]];
            NSDate* date1 =[self dateFromString:current];//登录时保存的时间
            NSDate*date2 =[self dateFromString:endTime];//当前的时间
            NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
            
            double secondsInAnHour =-1;// 除以3600是把秒化成小时，除以60得到结果为相差的分钟数
            NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
            
            NSString *exp_in = [NSString stringWithFormat:@"%@",EXPIRES_IN];//获取的过期值
            
            //-30：表示时间误差值
            if (hoursBetweenDates >([exp_in integerValue] -300))
            {
                //表示token已经过期,刷新token值刷新url
                //[self getOuth];
                [self pushGrdnVC];
            }
            else
            {
                //表示token还可以使用
                
                [self pushGrdnVC];
            }
        }else{
            
            [STTextHudTool showErrorText:@"未绑定档案信息" withSecond:2];
        }
        
        
      
       
        
        
    }
    if ([cell.titleLabel.text isEqualToString:@"系统设置"])
    {
        
        MCSetViewController *setVC = [[MCSetViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
        
        
        
    }
    if ([cell.titleLabel.text isEqualToString:@"我的下载"])
    {
        
        
        
        DownListViewController *setVC = [[DownListViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
        
        
        
    }
    
    
    
    
}
-(void)pushGrdnVC{
    
    NSString *access_token = [Defaults objectForKey:@"access_token"];
    NSString *uuid = [Defaults objectForKey:@"uuid"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://139.9.32.247:40091/#/record/record?access_token=%@&uuid=%@",access_token,uuid];
  
    MCWebViewController *webViewController = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:urlString]  titleString:@"个人档案"];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
    
    
    
}
#pragma -mark授权请求
-(void)getOuth{
    
    
    NSMutableDictionary *sendDict  = [NSMutableDictionary dictionary];
    NSString *outhString = @"5c0f6d86dfcab93ea4647926:0851b6b0f79911e89ed4d55d20b6473d";
    //请求头参数公式 Basic+空格+outhString(base64加密)
    NSString *Authorization = [NSString stringWithFormat:@"Basic %@",[XBase64WithString base64StringFromText:outhString]];
    
    
    [sendDict setObject:REFRESH_TOKEN  forKey:@"refresh_token"];
    [sendDict setObject:@"refresh_token" forKey:@"grant_type"];
    [STTextHudTool showText:@"授权认证中..."];
    //http://192.168.2.168:6001
    [MCHttpManager PostOuthWithIPString:BASEURL_OUTH urlMethod:@"/oauth2/token" parameters:sendDict outhWithString:Authorization success:^(id responseObject) {
        [STTextHudTool hideSTHud];
        NSDictionary *dicDictionary = responseObject;
        
        if ([dicDictionary isKindOfClass:[dicDictionary class]]) {
            
            
           
            
            NSString * access_token = [NSString stringWithFormat:@"%@",dicDictionary[@"access_token"]];
            NSString * expires_in = [NSString stringWithFormat:@"%@",dicDictionary[@"expires_in"]];
            NSString * refresh_token = [NSString stringWithFormat:@"%@",dicDictionary[@"refresh_token"]];
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:access_token forKey:@"access_token"];
            [defaults setObject:expires_in forKey:@"expires_in"];
            [defaults setObject:refresh_token forKey:@"refresh_token"];
            
            
            NSString *Current = [NSString stringWithFormat:@"%@",[self getCurrentTimes]] ;
            [defaults setObject:Current forKey:@"current"];
            
            
            [defaults synchronize];
            
            [self pushGrdnVC];
            
            
        }else{
            
             [STTextHudTool hideSTHud];
            [STTextHudTool showErrorText:@"授权失败" withSecond:2];
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
         [STTextHudTool hideSTHud];
        NSLog(@"%@",error);
        
    }];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    UIImage *image = [[UIImage alloc] init];
//
//    //设置导航栏背景图片为一个空的image，这样就透明
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//
//    //去掉透明后导航栏下边的黑边
//
//    [self.navigationController.navigationBar setShadowImage:image];
//
//    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//
//    self.navigationController.navigationBar.translucent = YES;
     [self.navigationController setNavigationBarHidden:YES animated:YES];
}




- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//
//    [self.navigationController.navigationBar setShadowImage:nil];
//
//   self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
////
//   self.navigationController.navigationBar.translucent = NO;
    
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
