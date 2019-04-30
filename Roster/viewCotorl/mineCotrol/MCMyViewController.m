//
//  MCMyViewController.m
//  TgVideo
//
//  Created by 邓梦超 on 2018/10/13.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCMyViewController.h"
#import "MCMemberCenterTableViewCell.h"
#import "MCGmjlViewController.h"
#import "MCChangePswViewController.h"
#import "MCSetViewController.h"
#import "MCWtjyViewController.h"
#import "MCWebViewController.h"
#import "MCUserInfoViewController.h"
#import "MCBdyxViewController.h"
#import "MCTgShareViewController.h"
#import "MCDhVIPViewController.h"
#import "MCHqVIPViewController.h"
#import "MCLoginViewControler.h"
#import "MCQhViewController.h"
#import "MCTxViewController.h"
#import "MCtest1ViewController.h"
@interface MCMyViewController ()

@end

@implementation MCMyViewController


            
    
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.view.backgroundColor = [UIColor colorWithRed:15/255.0 green:14/255.0 blue:28/255.0 alpha:1];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 264)];
    [self.view addSubview:backView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 254)];
    [imageView setImage:[UIImage imageNamed:@"我的-head-bg"]];
    [imageView setUserInteractionEnabled:YES];
    [backView addSubview:imageView];
    
    iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 50, 80, 80)];
    [backView addSubview:iconImageView];
     [iconImageView.layer setCornerRadius:iconImageView.frame.size.width / 2];
    [iconImageView setImage:[UIImage imageNamed:@"默认头像"]];
     [iconImageView setClipsToBounds:YES];
    
    UIButton *gerenButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-80)/2, 50, 80, 80)];
    [backView addSubview:gerenButton];
    [gerenButton addTarget:self action:@selector(puGr) forControlEvents:UIControlEventTouchUpInside];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BOTTOM_Y(iconImageView)+5, SCREEN_WIDTH, 20)];
    nameLabel.text = @"";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:20];
    [backView addSubview:nameLabel];
    
    vipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BOTTOM_Y(nameLabel)+10, SCREEN_WIDTH, 20)];
    vipLabel.text = @"普通会员";
    vipLabel.textColor = [UIColor whiteColor];
    vipLabel.textAlignment = NSTextAlignmentCenter;
    vipLabel.font = [UIFont systemFontOfSize:12];
    [backView addSubview:vipLabel];
    
    vipButton  = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-111)/2,  BOTTOM_Y(vipLabel)+5, 111, 30)];
    [backView addSubview:vipButton];
    [vipButton setTitle:@"开通VIP会员" forState:UIControlStateNormal];
    [vipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [vipButton setBackgroundColor:[UIColor colorWithRed:245 / 255.0 green:42 / 255.0 blue:98/ 255.0 alpha:1]];
    [vipButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [vipButton.layer setCornerRadius:5];
    [vipButton addTarget:self action:@selector(goVip) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 254, SCREEN_WIDTH, 10)];
    [backView addSubview:lineView];
    lineView.backgroundColor =  [UIColor colorWithRed:15/255.0 green:14/255.0 blue:28/255.0 alpha:1];
    
    [self getUserInformation];
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -(getRectNavAndStatusHight), self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setTableHeaderView:backView];
    [listTableView setDataSource:self];
    
    qhButton  = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-130,  17.5, 80, 25)];
    [qhButton setTitle:@"切换账号" forState:UIControlStateNormal];
    [qhButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [qhButton setBackgroundColor:[UIColor colorWithRed:245 / 255.0 green:42 / 255.0 blue:98/ 255.0 alpha:1]];
    [qhButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [qhButton.layer setCornerRadius:5];
    [qhButton addTarget:self action:@selector(leave) forControlEvents:UIControlEventTouchUpInside];
    
    bdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-50, 20)];
    bdLabel.text = @"绑定账号更安全,可多设备同步记录";
    bdLabel.textColor = [UIColor colorWithRed:120 / 255.0 green:122 / 255.0 blue:127/ 255.0 alpha:1];
    bdLabel.textAlignment = NSTextAlignmentRight;
    bdLabel.font = [UIFont systemFontOfSize:12];
    
    fxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-50, 20)];
    fxLabel.text = @"推广分享,开启快乐之旅";
    fxLabel.textColor = [UIColor colorWithRed:245 / 255.0 green:42 / 255.0 blue:98/ 255.0 alpha:1];
    fxLabel.textAlignment = NSTextAlignmentRight;
    fxLabel.font = [UIFont systemFontOfSize:12];
    
    dhLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-50, 20)];
    dhLabel.text = @"剩余兑换天数:1天";
    dhLabel.textColor = [UIColor colorWithRed:120 / 255.0 green:122 / 255.0 blue:127/ 255.0 alpha:1];
    dhLabel.textAlignment = NSTextAlignmentRight;
    dhLabel.font = [UIFont systemFontOfSize:12];
    
    srLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH-50, 20)];
    srLabel.text = @"输入邀请码,1日VIP送给你";
    srLabel.textColor = [UIColor colorWithRed:120 / 255.0 green:122 / 255.0 blue:127/ 255.0 alpha:1];
    srLabel.textAlignment = NSTextAlignmentRight;
    srLabel.font = [UIFont systemFontOfSize:12];
    
    emaillabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 20, 100, 20)];
    emaillabel.text = @"";
    emaillabel.textColor = RED_COLOER_ZZ;
    emaillabel.textAlignment = NSTextAlignmentLeft;
    emaillabel.font = [UIFont systemFontOfSize:12];
   
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20, 150, 100, 40)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    //[backView addSubview:button];
    [button addTarget:self action:@selector(putest) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)putest{
    MCtest1ViewController *testVC = [[MCtest1ViewController alloc]init];
    testVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:testVC animated:YES];
    
}
#pragma -mark切换账号
- (void)leave{
    
    
    MCQhViewController *qhVC = [[MCQhViewController alloc]init];
    qhVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:qhVC animated:YES];
    
    
    
}
#pragma -mark点击头像跳转个人页面
-(void)puGr{
    
    MCUserInfoViewController *userVC = [[MCUserInfoViewController alloc]init];
    userVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userVC animated:YES];
    
}
-(void)goVip{
    
    MCWebViewController *webVC = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:[NSString stringWithFormat:@"http://vip.cszb.info/vip?uid=%@",[Defaults objectForKey:@"uid"]]] titleString:@""];
   
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
    
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
    switch (section)
    {
        case 0:
        {
            return 0.00001;
        }
            break;
            
        default:
        {
            return 10;
        }
            break;
    }
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
    MCMemberCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCMemberCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
        [cell.iconImageView setImage:[UIImage imageNamed:[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"icon"]]];
        [cell.titleLabel setText:[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"title"]];
        
        switch (indexPath.row) {
            case 0:
                {
                    [cell addSubview:qhButton];
                    [cell addSubview:emaillabel];
                }
                break;
            case 1:
            {
                [cell addSubview:bdLabel];
                
            }
                break;
            case 2:
            {
                [cell addSubview:fxLabel];
                
            }
                break;
            case 3:
            {
                [cell addSubview:dhLabel];
                
            }
                break;
            case 4:
            {
                [cell addSubview:srLabel];
                
            }
                break;
                
                
            default:
                break;
        }
       
        NSDictionary *infoDic = [Defaults objectForKey:@"info"];
        NSString *iscps = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"iscps"]];
        if ([iscps isEqualToString:@"1"]) {
            if (!(indexPath.row ==9)) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 59, SCREEN_WIDTH-50, 1)];
                view.backgroundColor = [UIColor colorWithRed:41 / 255.0 green:41 / 255.0 blue:54/ 255.0 alpha:1];
                [cell addSubview:view];
            }
        }else{
            
            if (!(indexPath.row ==8)) {
                UIView *view = [[UIView alloc]initWithFrame:CGRectMake(50, 59, SCREEN_WIDTH-50, 1)];
                view.backgroundColor = [UIColor colorWithRed:41 / 255.0 green:41 / 255.0 blue:54/ 255.0 alpha:1];
                [cell addSubview:view];
            }
        }
        
       
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    MCMemberCenterTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    
    if ([cell.titleLabel.text isEqualToString:@"绑定账号"])
    {
        MCBdyxViewController *bdVC = [[MCBdyxViewController alloc]init];
        bdVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bdVC animated:YES];
    }
    
    if ([cell.titleLabel.text isEqualToString:@"推广分享"])
    {
        MCTgShareViewController *tgVC = [[MCTgShareViewController alloc]init];
        tgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:tgVC animated:YES];
    }
    if ([cell.titleLabel.text isEqualToString:@"兑换VIP"])
    {
        NSDictionary *dic = [Defaults objectForKey:@"info"];
        NSString *invitationnum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"invitationnum"]];
        
        MCDhVIPViewController *dhVC = [[MCDhVIPViewController alloc]init];
        dhVC.num = invitationnum;
        dhVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:dhVC animated:YES];
    }
    if ([cell.titleLabel.text isEqualToString:@"输入邀请码"])
    {
        MCHqVIPViewController *hqVC = [[MCHqVIPViewController alloc]init];
        hqVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hqVC animated:YES];
    }
    if ([cell.titleLabel.text isEqualToString:@"购买记录"])
    {
        MCGmjlViewController *gmVC = [[MCGmjlViewController alloc]init];
        gmVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:gmVC animated:YES];
    }
    if ([cell.titleLabel.text isEqualToString:@"修改密码"])
    {
         NSDictionary *dic = [Defaults objectForKey:@"info"];
        NSString *email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
        if (!(kStringIsEmpty(email))) {
            MCChangePswViewController *pswVC = [[MCChangePswViewController alloc]init];
            pswVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pswVC animated:YES];
        }else{
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您未绑定邮箱,无法修改密码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
       
       
    }
    if ([cell.titleLabel.text isEqualToString:@"系统设置"])
    {
        MCSetViewController *setVC = [[MCSetViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
        
    }
    if ([cell.titleLabel.text isEqualToString:@"问题建议"])
    {
        MCWtjyViewController *wtVC = [[MCWtjyViewController alloc]init];
        wtVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wtVC animated:YES];
       
    }
    if ([cell.titleLabel.text isEqualToString:@"政策条款"])
    {
        
        [self TextButtonAction];
    }
    if ([cell.titleLabel.text isEqualToString:@"推广提现"])
    {
        MCTxViewController *txVC = [[MCTxViewController alloc]init];
        txVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:txVC animated:YES];
       
    }
    
   
    
    
    
    
    
    
    
    
    
}
#pragma -mark获取个人信息
- (void)getUserInformation
{
    
    
    NSMutableDictionary *sendDict = [NSMutableDictionary dictionary];
    
    NSString *urlString = [NSString stringWithFormat:@"/user/%@",[Defaults objectForKey:@"uid"]];
    [sendDict setObject:[Defaults objectForKey:@"uid"] forKey:@"uid"];
    
    
    [MCHttpManager GETWithIPString:BASEURL_VIDOE urlMethod:urlString parameters:sendDict success:^(id responseObject) {
        
        
        NSDictionary *dicDictionary = responseObject;
       
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"];
            
            if ([dicDictionary[@"content"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0) {
                
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[self removeNullFromDictionary:dicDictionary[@"content"][0]] forKey:@"info"];
                [defaults synchronize];
                
                listMutableArray = [NSMutableArray array];
                NSDictionary *infoDic = [Defaults objectForKey:@"info"];
                NSString *iscps = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"iscps"]];
                
                if ([iscps isEqualToString:@"1"]) {
                    [listMutableArray addObject:@[@{@"icon": @"账号", @"title":@"账号"},@{@"icon": @"绑定账号", @"title":@"绑定账号"},@{@"icon": @"推广分享", @"title":@"推广分享"},@{@"icon": @"兑换VIP", @"title":@"兑换VIP"},@{@"icon": @"输入邀请码", @"title":@"输入邀请码"},@{@"icon": @"修改密码", @"title":@"修改密码"},@{@"icon": @"系统设置", @"title":@"系统设置"},@{@"icon": @"问题建议", @"title":@"问题建议"},@{@"icon": @"正常条款", @"title":@"政策条款"},@{@"icon": @"推广提现", @"title":@"推广提现"}]];
                    
                }else{
                    
                    [listMutableArray addObject:@[@{@"icon": @"账号", @"title":@"账号"},@{@"icon": @"绑定账号", @"title":@"绑定账号"},@{@"icon": @"推广分享", @"title":@"推广分享"},@{@"icon": @"兑换VIP", @"title":@"兑换VIP"},@{@"icon": @"输入邀请码", @"title":@"输入邀请码"},@{@"icon": @"修改密码", @"title":@"修改密码"},@{@"icon": @"系统设置", @"title":@"系统设置"},@{@"icon": @"问题建议", @"title":@"问题建议"},@{@"icon": @"正常条款", @"title":@"政策条款"}]];}
                
                
                
                [self setUserUI];
                
                
            }
            
            
            
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:dicDictionary[@"message"]];
            
            
        }
        
        
        
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
        
      
        
        [SVProgressHUD showErrorWithStatus:@"网络不给力!"];
        
        
    }];
    
    
    
    
}
-(void)setUserUI{
    
    
    
    [listTableView reloadData];
    NSDictionary *dic = [Defaults objectForKey:@"info"];
    NSString *iconString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]];
    
    NSString *nameString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickname"]];
    NSString *userString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]];
    
    NSString *groupid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"groupid"]];
    NSString *vipendtime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"vipendtime"]];
    NSString *invitationnum = [NSString stringWithFormat:@"%@",[dic objectForKey:@"invitationnum"]];
     NSString *email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"email"]];
   
    if ([groupid isEqualToString:@"1"]) {
    //会员
        vipLabel.text =[NSString stringWithFormat:@"会员到期时间:%@",vipendtime] ;
        [vipButton setTitle:@"续费VIP会员" forState:UIControlStateNormal];
        
        
    }else{
    //非会员
         vipLabel.text =[NSString stringWithFormat:@"%@",@"普通会员"] ;
        [vipButton setTitle:@"开通VIP会员" forState:UIControlStateNormal];
    }
    emaillabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"uid"]];
    
    if (!(kStringIsEmpty(nameString))) {
        
        [nameLabel setText:nameString];
    }else{
        [nameLabel setText:@"暂无昵称"];
        
    }
    if (!(kStringIsEmpty(iconString))) {
        
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        
        [iconImageView setImage:[UIImage imageNamed:@"默认头像"]];
        
    }
    
    dhLabel.text = [NSString stringWithFormat:@"剩余兑换天数:%@天",invitationnum];
    
    if (!(kStringIsEmpty(email))) {
        
        bdLabel.text = email;
    }else{
        
        bdLabel.text = @"绑定账号更安全,可多设备同步记录";
    }
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
   
   
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getUserInformation];
   
    
    UIImage *image = [[UIImage alloc] init];
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    
    [self.navigationController.navigationBar setShadowImage:image];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.translucent = YES;
    
}




- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
   
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:nil];
    
    //self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    self.navigationController.navigationBar.translucent = NO;
    
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
