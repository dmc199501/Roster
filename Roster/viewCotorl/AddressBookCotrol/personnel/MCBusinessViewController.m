//
//  MCBusinessViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/15.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCBusinessViewController.h"
#import "MyTableViewCell.h"
#import "MCWebViewController.h"
#import "ViewController.h"
#import "DingDingHeader.h"
#import "XBase64WithString.h"
@interface MCBusinessViewController ()

@end

@implementation MCBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"员工名片";
    self.view.backgroundColor = COLOR_248_COLOER;
    [self getYgData];
    
    

    
    iconImgeView = [[UIImageView alloc]initWithFrame:CGRectMake(19, 20, 60, 60)];
    [iconImgeView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataDic[@"Icon"]]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    [iconImgeView.layer setCornerRadius:5];
    [iconImgeView setClipsToBounds:YES];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(83, 30, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
    [nameLabel setTextColor:[UIColor colorWithRed:56 / 255.0 green:56 / 255.0 blue:56/ 255.0 alpha:1]];
    [nameLabel setFont:[UIFont systemFontOfSize:16]];
   
    
    jobLabel = [[UILabel alloc]initWithFrame:CGRectMake(83, 55, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
    [jobLabel setTextColor:COLOR_164_COLOER];
   
    [jobLabel setFont:[UIFont systemFontOfSize:14]];
    
    
    
//    stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 30, [[UIScreen mainScreen] bounds].size.width - 130, 20)];
//    [stateLabel setTextColor:COLOR_164_COLOER];
//    [stateLabel setText:@"请假11/1-11/3"];
//    [stateLabel setFont:[UIFont systemFontOfSize:14]];
//    CGSize size =   [self sizeWithText:stateLabel.text font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    stateLabel.frame =CGRectMake(170, 26.5, size.width+50, 20);
//     [self setLabel];
//
//    maskView = [[UIView alloc]initWithFrame:CGRectMake(150, 25, stateLabel.frame.size.width+40, 26)];
//    maskView.backgroundColor = [UIColor colorWithRed:235 / 255.0 green:235 / 255.0 blue:235/ 255.0 alpha:1];
//    maskView.layer.cornerRadius = 13;
//    maskView.layer.masksToBounds = YES;
    
    

   
    
    
    
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
        listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [listTableView reloadData];
        
        
    } else {
        // 竖屏布局 balabala
        listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [listTableView reloadData];
       
        
    }
}

-(void)getYgData{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"adminid"];//本人id
    [dic setObject:_dataDic[@"adminid"] forKey:@"uid"];//
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/contacts/getcontacts" parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        NSLog(@"员工信息%@",dicDictionary);
       
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSString *iscollection = [NSString stringWithFormat:@"%@",dicDictionary[@"content"][0][@"iscollection"]];
            
           // [self setItem:iscollection];
            [self setData:dicDictionary[@"content"][0]];
            
           
            
        }else{
            
            
          
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        
       
        
    }];
    
    
}

-(void)setData:(NSDictionary *)dic{
    
     [nameLabel setText:[NSString stringWithFormat:@"%@",dic[@"realname"]]];
     [jobLabel setText:[NSString stringWithFormat:@"%@|%@",dic[@"orgname"],dic[@"jobname"]]];
    
}
-(void)setItem:(NSString *)iscollection{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setFrame:CGRectMake(0, 0, 20, 20)];
   
    
    if (!(kStringIsEmpty(iscollection))) {
        
        if ([iscollection isEqualToString:@"1"]) {
           
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"start-fill"] forState:UIControlStateNormal];
             [rightBtn addTarget:self action:@selector(cancelCollection) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            
            [rightBtn setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
           
        }
    }else{
        
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(collection) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = searchButton;
}

#pragma mark-收藏联系人
-(void)collection{
    
    [self setItem:@"1"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"adminid"];//本人id
    [dic setObject:_dataDic[@"adminid"] forKey:@"uid"];
     [dic setObject:@"1" forKey:@"iscollection"];
    
    [MCHttpManager PutWithIPString:BASEURL_ROSTER urlMethod:@"/contacts/collectioncontacts" parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            
            
            if ([self.delegate respondsToSelector:@selector(delegateViewControllerDidClickiscollection:)]) {
                [self.delegate delegateViewControllerDidClickiscollection:@"YES"];
            }
        }else{
            
            [STTextHudTool showErrorText:@"收藏失败"];
            
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        
        
        
    }];
    
    
    
    
}
#pragma mark-取消收藏联系人
-(void)cancelCollection{
    [self setItem:@"0"];
    
   
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"adminid"];//本人id
    [dic setObject:_dataDic[@"adminid"] forKey:@"uid"];
    [dic setObject:@"0" forKey:@"iscollection"];
    
    [MCHttpManager PutWithIPString:BASEURL_ROSTER urlMethod:@"/contacts/collectioncontacts" parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            
            if ([self.delegate respondsToSelector:@selector(delegateViewControllerDidClickiscollection:)]) {
                [self.delegate delegateViewControllerDidClickiscollection:@"YES"];
            }
        }else{
            
            [STTextHudTool showErrorText:@"取消收藏失败"];
            
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        
        
        
    }];
    
}
-(void)setLabel{
    
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"默认头像"];
    attach.bounds = CGRectMake(-5, -2, 20, 20) ;
   
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
   
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:stateLabel.text];
   
    [abs insertAttributedString:imageStr atIndex:0];
    
    stateLabel.attributedText = abs ;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case 0:
            {
              return 100;
            }
            break;
        case 1:
        {
          return 68;
        }
            break;
        case 2:
        {
            return 50;
        }
            break;
            
        default:
            break;
    }
    return 0;
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
            return 1;
        }
            break;
        case 1:
        {
            return 5;
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
   
    if (indexPath.section == 0) {
        [cell.titleLabel removeFromSuperview];
        [cell.contentLabel removeFromSuperview];
        [cell addSubview:nameLabel];
        [cell addSubview:jobLabel];
        [cell addSubview:maskView];
        [cell addSubview:stateLabel];
         [cell addSubview:iconImgeView];
        
        maskView.frame = CGRectMake(150, 25, stateLabel.frame.size.width+30, 26);
        
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                {
                
                    NSString *string = [NSString stringWithFormat:@"%@",_dataDic[@"secretary"]];
                    if (!(kStringIsEmpty(string))) {
                        [cell.titleLabel setText:[NSString stringWithFormat:@"%@",_dataDic[@"secretary"]]];
                    }else{
                        
                        [cell.titleLabel setText:[NSString stringWithFormat:@"%@",@""]];
                    }
                   
                    NSString *string2 = [NSString stringWithFormat:@"%@",_dataDic[@"secretarytel"]];
                    if (!(kStringIsEmpty(string2))) {
                        [cell.contentLabel setText:[NSString stringWithFormat:@"秘书:%@",_dataDic[@"secretarytel"]]];
                    }else{
                        
                        [cell.contentLabel setText:[NSString stringWithFormat:@"秘书:%@",@"无"]];
                    }
                   
                    
                   
                }
                break;
            case 1:
            {
                NSString *string = [NSString stringWithFormat:@"%@",_dataDic[@"mobile"]];
                if (!(kStringIsEmpty(string))) {
                     [cell.titleLabel setText:[NSString stringWithFormat:@"%@",_dataDic[@"mobile"]]];
                }else{
                    
                     [cell.titleLabel setText:[NSString stringWithFormat:@"%@",@"无"]];
                }
                [cell.contentLabel setText:@"手机号码"];
               
                
            }
                break;
            case 2:
            {
                NSString *string = [NSString stringWithFormat:@"%@",_dataDic[@"enterprise_cornet"]];
                if (!(kStringIsEmpty(string))) {
                    [cell.titleLabel setText:[NSString stringWithFormat:@"%@",_dataDic[@"enterprise_cornet"]]];
                }else{
                    
                    [cell.titleLabel setText:[NSString stringWithFormat:@"%@",@"无"]];
                }
               
                [cell.contentLabel setText:@"座机号码"];
            }
                break;
            case 3:
            {
                
                NSString *string = [NSString stringWithFormat:@"%@",_dataDic[@"email"]];
                if (!(kStringIsEmpty(string))) {
                    [cell.titleLabel setText:[NSString stringWithFormat:@"%@",_dataDic[@"email"]]];
                }else{
                    
                    [cell.titleLabel setText:[NSString stringWithFormat:@"%@",@"无"]];
                }
               
                [cell.contentLabel setText:@"邮箱"];
            }
                break;
            case 4:
            {
                [cell.titleLabel setText:[NSString stringWithFormat:@"%@",_dataDic[@"orgname"]]];
                [cell.contentLabel setText:@"所属部门"];
                for (UIView *view in cell.subviews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        [view removeFromSuperview];
                    }
                }
                UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width- 29, 26.5, 8, 15)];
                [cell addSubview:arrowImageView];
                [arrowImageView  setImage:[UIImage imageNamed:@"更多"]];
            }
                break;
                
                
            default:
                break;
        }
       
    }else{
        
        for (UIView *view in cell.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                [view removeFromSuperview];
            }
        }
        NSString *purviewArchives = [NSString stringWithFormat:@"%@", [Defaults objectForKey:@"purviewArchives"]];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, [[UIScreen mainScreen] bounds].size.width, 20)];
        label.textAlignment  = NSTextAlignmentCenter;
        [label setFont:[UIFont systemFontOfSize:18]];
         [label setTextColor:COLOR_56_COLOER];
        [cell addSubview:label];
        if ([purviewArchives isEqualToString:@"1"]) {
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"查看员工档案(有权限查看)"];
            
            //小数点前面的字体大小
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont boldSystemFontOfSize:18]
                                  range:NSMakeRange(0, 6)];
            
            //小数点后面的字体大小
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont boldSystemFontOfSize:14]
                                  range:NSMakeRange(6, 7)];
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
                                  value:COLOR_164_COLOER
                                  range:NSMakeRange(6, 7)];
             label.attributedText = AttributedStr ;
            
        }else{
            
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"查看员工档案(无权限查看)"];
            
            //小数点前面的字体大小
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont boldSystemFontOfSize:18]
                                  range:NSMakeRange(0, 6)];
            
            //小数点后面的字体大小
            [AttributedStr addAttribute:NSFontAttributeName
                                  value:[UIFont boldSystemFontOfSize:14]
                                  range:NSMakeRange(6, 7)];
            label.attributedText = AttributedStr ;
             [label setTextColor:COLOR_164_COLOER];
        }
        
       
    }
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                [self call:@""];
               
            }
                break;
            case 1:
            {
               [self call:_dataDic[@"mobile"]];
            }
                break;
            case 2:
            {
               [self call:_dataDic[@"enterprise_cornet"]];
            }
                break;
            case 3:
            {
               
            }
                break;
            case 4:
            {
                
              
                
                ViewController *VC = [[ViewController alloc]init];
                VC.hidesBottomBarWhenPushed = YES;
                VC.isHomePage = YES;
                VC.pushOrgid = _dataDic[@"orguuid"];
                VC.title = _dataDic[@"orgname"];
                [[DingDingHeader shareHelper].titleList removeAllObjects];
                [[DingDingHeader shareHelper].titleList addObject:@"员工名片"];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
                break;
                
                
            default:
                break;
        }
        
        
    }else if (indexPath.section == 2){
        
        NSString *purviewArchives = [NSString stringWithFormat:@"%@", [Defaults objectForKey:@"purviewArchives"]];
        if ([purviewArchives isEqualToString:@"1"]) {
            
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
                // [self getOuth];
                [self pushGrdnVC];
            }
            else
            {
                //表示token还可以使用
                [self pushGrdnVC];
            }
        }else{
            
            
        }
        
      
        
        
    }
    
    
}
-(void)pushGrdnVC{
    
    NSString *access_token = [Defaults objectForKey:@"access_token"];
    NSString *uuid = _dataDic[@"uuid"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://139.9.32.247:40091/#/record/record?access_token=%@&uuid=%@",access_token,uuid];
    NSLog(@"跳转的UT了===%@",urlString);
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
    [sendDict setObject:@"refreshtoken" forKey:@"grant_type"];
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
-(void)call:(NSString *)callSting{
    
    if (!(kStringIsEmpty(callSting))){
        
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",callSting];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
        
    }else{
        
        [STTextHudTool showErrorText:@"号码为空" withSecond:2];
        
    }
    
   
    
   
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
