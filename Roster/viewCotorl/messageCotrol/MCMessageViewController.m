//
//  MCMessageViewController.m
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//
#ifdef DEBUG
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
#import "MCMessageViewController.h"
#import "MCHomePageTableViewCell.h"
#import "MCWebViewController.h"
#import "NSArray+deleteNill.h"
#import "UITabBar+MCTabBar.h"
#import "MCMessageListViewController.h"
#import "MCSearchViewController.h"
#import "JPUSHService.h"
#import "MCSalaryViewController.h"
#import "SPTabBarController.h"
@interface MCMessageViewController ()<UISearchBarDelegate>
@property(nonatomic, strong) NSString *searchStr;
@property(nonatomic,strong)NSString *addressURL;
@end

@implementation MCMessageViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        
        listMutableArray = [NSMutableArray array];
        listOneMutableArray = [NSMutableArray array];
        listGDMutableArray = [NSMutableArray array];
         readMutableArray = [NSMutableArray array];
       
        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  
    [self VersionUpdate];
    [listGDMutableArray addObject:@{@"imageName":@"看板icon",@"title":@"暂无新消息",@"comefrom":@"数据看板",@"owner_name":@"暂无",@"client_code":@"sjkb",@"homePushTime":@"2000-06-10 17:57:11",@"notread":@"0"}];
    [listGDMutableArray addObject:@{@"imageName":@"工资查询icon",@"title":@"暂无新消息",@"comefrom":@"薪酬查询",@"owner_name":@"暂无",@"client_code":@"xccx",@"homePushTime":@"2000-06-10 17:57:11",@"notread":@"0"}];
    [listGDMutableArray addObject:@{@"imageName":@"审批icon",@"title":@"暂无新消息",@"comefrom":@"预算审批",@"owner_name":@"暂无",@"client_code":@"yssp",@"homePushTime":@"2000-06-10 17:57:11",@"notread":@"0"}];
    //[listGDMutableArray addObject:@{@"imageName":@"待办icon",@"title":@"暂无新消息",@"comefrom":@"提交预算",@"owner_name":@"暂无",@"client_code":@"tjys",@"homePushTime":@"2000-06-10 17:57:11",@"notread":@"0"}];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti1) name:@"pushList" object:nil];
    // 屏幕旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];

    //
  
    
    //添加搜索框
    UIView *searchBarView = [[UIView alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-50, 44)];
    [searchBarView addSubview:[self headView]];
    
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, SCREEN_WIDTH-50, 44)];
    [searchBarView addSubview:searchButton];
    [searchButton addTarget:self action:@selector(pushSearchVC) forControlEvents:UIControlEventTouchUpInside];
    
    //self.navigationItem.titleView = searchBarView;
    
   listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
   //[self.view addSubview:listTableView];
   [listTableView setBackgroundColor:[UIColor whiteColor]];
   [listTableView setBackgroundView:nil];
   [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   [listTableView setDelegate:self];
   [listTableView setDataSource:self];
    [self setBackUI];
    [self setAlias];//设置极光推送别名
    [self getUserInformation];//获取用户信息
    [self getArchives];//获取档案信息
    [self loadMassage];//获取首页消息列表
    

    // Do any additional setup after loading the view.
}
#pragma -mark设置背景图片
-(void)setBackUI{
    
    UIImageView *homeImageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:homeImageview];
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
         [homeImageview setImage:[UIImage imageNamed:@"homeC"]];
    }else{
        //iPad
         [homeImageview setImage:[UIImage imageNamed:@"homeCC"]];
       
    }
    
   
    homeImageview.contentMode =  UIViewContentModeScaleAspectFill;
}
//切屏重新设置frame
- (void)deviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    for (UIView *view in self.view.subviews) {
        
        [view removeFromSuperview];
    }
    [self setBackUI];
   
}

-(void)noti1{
    
    [self loadMassage];
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushList" object:nil];
}
#pragma 设置别名成功后的回调
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
    
    
}
#pragma mark--设置推送的标签及别名
-(void)setAlias{
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username =[NSString stringWithFormat:@"%@",[defaults objectForKey:@"username"]] ;
    [JPUSHService setAlias:username completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    if (iResCode == 0) {
          
           // [STTextHudTool showSuccessText:@"添加别名成功"];
        }
    } seq:1];

}
#pragma -mark 跳转搜索页面
-(void)pushSearchVC{
    
    
    MCSearchViewController *searcVC = [[MCSearchViewController alloc]init];
    searcVC.pushType = @"home";
    searcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searcVC animated:YES];
    
    
}
#pragma mark--获取消息列表
- (void)loadMassage{
    
    
   
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
  
    NSMutableDictionary *sendDict = [NSMutableDictionary dictionary];
    [sendDict setObject:@"1" forKey:@"page"];
    [sendDict setObject:@"10" forKey:@"pagesize"];
    [sendDict setObject:username forKey:@"username"];
   
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/homepush" parameters:sendDict success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
       
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            if ([dicDictionary[@"content"] isKindOfClass:[NSDictionary class]])
            {
                

                [self->listMutableArray setArray:dicDictionary[@"content"][@"data"]];
                [self->readMutableArray setArray:dicDictionary[@"content"][@"data"]];
                
                NSArray *array = dicDictionary[@"content"][@"data"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                
                //存数据，不需要设置路劲，NSUserDefaults将数据保存在preferences目录下
                NSArray *array1 = [NSArray removeNullFromArray:array];
                [userDefaults setObject:array1 forKey:@"homelist"];
                [userDefaults synchronize];
                
                [self setListArray];
                [self->listTableView reloadData];
                //[self setRedView];
                
                
                NSString *notreadsum = [NSString stringWithFormat:@"%@",dicDictionary[@"content"][@"notreadsum"]];
                if (!(kStringIsEmpty(notreadsum))) {
                    
                    if ([notreadsum integerValue]>0) {
                        [self.tabBarController.tabBar showBadgeOnItmIndex:1];
                    }else{
                        [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
                    }
                }else{
                    
                    [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
                }
                
                
                
            }
            
        }else{
            
           
            [self->listMutableArray removeAllObjects];
            [self->readMutableArray removeAllObjects];
            [self setListArray];
            
           
                
            [self.tabBarController.tabBar hideBadgeOnItemIndex:0];
            
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
       
        NSLog(@"****%@", error);
             
    }];
    
    
    
    
}

#pragma mark--消息列表数据处理
- (void)setListArray{
    [listOneMutableArray removeAllObjects];
    [listMutableArray addObjectsFromArray:listGDMutableArray];
    
    
    NSMutableArray *dateKeys = [NSMutableArray array];
    for (NSDictionary *dic in listMutableArray) {
        NSString *dateKey = dic[@"client_code"];
        if (![dateKeys containsObject:dateKey]) {
            [dateKeys addObject:dateKey];
        }
    }
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < dateKeys.count; i++) {
        
        NSMutableArray *values = [NSMutableArray array];
        NSString *key = (NSString *)dateKeys[i];
        for (NSDictionary *dic in listMutableArray) {
            
            if ([dic[@"client_code"] isEqualToString: key]) {
                [values addObject:dic];
            }
        }
        
        [mutableDic setValue:[values objectAtIndex:0] forKey:key];
    }
    
    listOneMutableArray = [NSMutableArray arrayWithArray:mutableDic.allValues];
   
    for (int i=0; i<listOneMutableArray.count-1; i++){
        
        for (int j=i+1; j<listOneMutableArray.count; j++) {
            
            if ([[self ConvertStrToTime:[[listOneMutableArray objectAtIndex:i]objectForKey:@"homePushTime"] ] longLongValue]<[[self ConvertStrToTime:[[listOneMutableArray objectAtIndex:j]objectForKey:@"homePushTime"] ] longLongValue]) {
                
                
                NSMutableDictionary *TempDic=[listOneMutableArray objectAtIndex:i];
                
                //[listOneMutableArray replaceObjectAtIndex:i withObject:TempDic];
                listOneMutableArray[i]=[listOneMutableArray objectAtIndex:j];
                //
                listOneMutableArray[j] = TempDic;
                
            }
            
        }
        
    }
    
    
    
    
    
    [listTableView reloadData];
    //[self setRedView];
    
    
    
}
-(NSString *)ConvertStrToTime:(NSString *)timeStr
//timeStr毫秒字段
{
    
    //首先创建格式化对象
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //然后创建日期对象
    
    NSDate *date1 = [dateFormatter dateFromString:timeStr];
    
    NSDate *date = [NSDate date];
    
    //计算时间间隔（单位是秒）
    
    NSTimeInterval time = [date1 timeIntervalSinceDate:date];
    
    //计算天数、时、分、秒
    
    int days = ((int)time)/(3600*24);
    
    int hours = ((int)time)%(3600*24)/3600;
    
    int minutes = ((int)time)%(3600*24)%3600/60;
    
    
    int num = +(days)*60*60 + +(hours)*60 + minutes;
    
    NSString *dateContent = [[NSString alloc] initWithFormat:@"%d",num];
    
    return dateContent;
    
}
#pragma -mark获取个人信息
-(void)getArchives{

   
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"uuid"];
   
    NSString *string = [NSString stringWithFormat:@"/archives/%@",UUID];
    
    [MCHttpManager GETWithIPString:BASEURL_USER urlMethod:string parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        NSLog(@"档案%@",dicDictionary);
       
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"];
            
            if ([dicDictionary[@"content"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
            {
                
                
                NSDictionary *dic = array[0];
                NSString *uuidstring =[NSString stringWithFormat:@"%@",dic[@"uuid"]];
                if (!kStringIsEmpty(string)) {
                    
                    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                    [defaults setObject:uuidstring forKey:@"dauuid"];
                    [defaults synchronize];
                }
                
               
                
                
                
            }else{
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:@"" forKey:@"dauuid"];
                [defaults synchronize];
               //[STTextHudTool showErrorText:@"未获取到个人档案数据"];
            }
            
            
        }else{
            
            [STTextHudTool showErrorText:dicDictionary[@"message"]];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"" forKey:@"dauuid"];
            [defaults synchronize];
            
            
        }
        
        
        
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        [STTextHudTool showErrorText:@"网络不给力!"];
      
        
        
    }];
    
    
    
   
    
}
-(void)getUserInformation{
    
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"uuid"];
    
    NSString *string = [NSString stringWithFormat:@"/adminuser/adminuser/%@",UUID];
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:string parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        NSLog(@"操作员%@",dicDictionary);
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"];
            
            if ([dicDictionary[@"content"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
            {
                
                
                
                
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setObject:[self removeNullFromDictionary:dicDictionary[@"content"][0]] forKey:@"info"];
                [defaults synchronize];
                
                
                
            }else{
                
                [STTextHudTool showErrorText:@"未获取到个人档案数据"];
            }
            
            
        }else{
            
            [STTextHudTool showErrorText:dicDictionary[@"message"]];
            
            
            
        }
        
        
        
        
        
        
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        [STTextHudTool showErrorText:@"网络不给力!"];
        
        
        
    }];
    
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    bgView.backgroundColor = [UIColor whiteColor];
    return bgView;
    
}- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return listOneMutableArray.count;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *indentifier = @"cell";
    MCHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    NSDictionary *dataDictionary = [listOneMutableArray objectAtIndex:indexPath.row];
   
   
   
    [cell.titleLabel setText:[NSString stringWithFormat:@"%@", [dataDictionary objectForKey:@"comefrom"]]];
    [cell.contentLabel setText:[NSString stringWithFormat:@"%@", [dataDictionary objectForKey:@"title"]]];
    NSString *datastring = [NSString stringWithFormat:@"%@",dataDictionary[@"homePushTime"]];
    if (!(kStringIsEmpty(datastring))) {
        
     
    if ([datastring containsString:@"2000-06-10"] ) {
        [cell.dateLabel setText:@""] ;
    }else{
         [cell.dateLabel setText:[self compareCurrentTime:datastring]];
    }
    }else{
        
        ;
        [cell.dateLabel setText:@""] ;
    }
    
    [cell.contentLabel setText:[NSString stringWithFormat:@"%@", [dataDictionary objectForKey:@"title"]]];
   
   
    
   
    
    
    
    if ([self getNotReadSum:[NSString stringWithFormat:@"%@",dataDictionary[@"client_code"]]] >0) {
       
        cell.noReadImageView.hidden = NO;
        
        [cell.numberLabel setText:[NSString stringWithFormat:@"%d",[self getNotReadSum:[NSString stringWithFormat:@"%@",dataDictionary[@"client_code"]]]]];
        
    }else{
         
        cell.noReadImageView.hidden = YES;
        
    }
    
   

    

   
    
    if ([dataDictionary[@"client_code"] isEqualToString:@"sjkb"]) {
        
        [cell.iconImageView setImage:[UIImage imageNamed:@"看板icon"]];
    }else
    if ([dataDictionary[@"client_code"] isEqualToString:@"xccx"]) {
            [cell.iconImageView setImage:[UIImage imageNamed:@"工资查询icon"]];
        }
    else if ([dataDictionary[@"client_code"] isEqualToString:@"yssp"]) {
                [cell.iconImageView setImage:[UIImage imageNamed:@"审批icon"]];
            }
    else if ([dataDictionary[@"client_code"] isEqualToString:@"tjys"]) {
                    [cell.iconImageView setImage:[UIImage imageNamed:@"待办icon"]];
                }
    else{
        
     [cell.iconImageView setImage:[UIImage imageNamed:@"TZ_fuwu"]];
        
    }
    
    

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    if (listOneMutableArray.count>0) {
        NSDictionary *dataDictionary = [listOneMutableArray objectAtIndex:indexPath.row];
        
        
        
        
        NSString *code = [NSString stringWithFormat:@"%@",dataDictionary[@"client_code"]];
        
        if ([code isEqualToString:@"yssp"]) {
            
            NSString *access_token = [Defaults objectForKey:@"access_token"];
            NSString *uuid = [Defaults objectForKey:@"uuid"];
            
            NSString *urlString = [NSString stringWithFormat:@"http://139.9.32.247:40091/#/approval/index?access_token=%@&uuid=%@",access_token,uuid];
            
            MCWebViewController *webViewController = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:urlString]  titleString:@"审批"];
            webViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webViewController animated:YES];
            
            [self changgeIsRed];
            
        }else if([code isEqualToString:@"xccx"]){
            
            MCSalaryViewController *salryVC = [[MCSalaryViewController alloc]init];
            salryVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:salryVC animated:YES];
            
            
            
        }else if ([code isEqualToString:@"sjkb"]){
            
            SPTabBarController *tabbar = [[SPTabBarController alloc]init];
            UIWindow * window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController = tabbar;
            [window makeKeyWindow];
            [self.navigationController popToRootViewControllerAnimated:NO];
            tabbar.selectedIndex = 1;
            
        }else{
            
            MCMessageListViewController *listVC = [[MCMessageListViewController alloc]init];
            listVC.code = code;
            listVC.title = dataDictionary[@"comefrom"];
            listVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:listVC animated:YES];
            
        }
        
      
        
    }
    
}
- (void)changgeIsRed{
    
    NSMutableDictionary *sendDictionary = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];
    
    [sendDictionary setValue:@"yssp" forKey:@"client_code"];
    [sendDictionary setValue:username forKey:@"username"];
    
    
    
    [MCHttpManager PutWithIPString:BASEURL_ROSTER urlMethod:@"/homepush/readhomePush" parameters:sendDictionary success:^(id responseObject)
     
     {
         NSLog(@"设置已读****%@", responseObject);
         
     } failure:^(NSError *error) {
         
         NSLog(@"****%@", error);
         
     }];
    
    
    
}
#pragma -mark 计算每个code值下的未读数
-(int)getNotReadSum:(NSString *)code{
    
     int summ = 0;
    NSMutableArray *array  = [NSMutableArray array];
    for (int i= 0; i<readMutableArray.count; i++) {
        NSString *stringcode = [NSString stringWithFormat:@"%@",readMutableArray[i][@"client_code"]];
        if ([stringcode  isEqualToString:code]) {
            
            [array addObject:readMutableArray[i]];
        }
    }
   
   
    for (int j= 0; j<array.count; j++) {
        NSString *notread = [NSString stringWithFormat:@"%@",array[j][@"notread"]];
        
        if ([notread isEqualToString:@"0"]) {
       
          summ = summ +1;
        }
        
    }
    
    return summ;
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
    
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

//UISearchBar初始化
-(UIView *)headView{
    
    
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    
    
    searchBar.frame=CGRectMake(0, 0, SCREEN_WIDTH-50, 44);
    searchBar.keyboardType = UIKeyboardTypeWebSearch;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    //[searchBar becomeFirstResponder];
   
    //底部的颜色
    NSString *version= [UIDevice currentDevice].systemVersion;
    if(version.doubleValue >=10.0) {
        // 针对 10.0 以上的iOS系统进行处理
    }else{
        // 针对 10.0 以下的iOS系统进行处理
        [[[[ searchBar . subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
    }
    searchBar.backgroundColor  = [UIColor whiteColor];
    UITextField *textfield = [[[searchBar.subviews firstObject] subviews] lastObject];
    textfield.backgroundColor =[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240/ 255.0 alpha:1];
    searchBar.searchBarStyle = UISearchBarStyleDefault;
    textfield.font = [UIFont systemFontOfSize:13];
    textfield.inputAccessoryView = self.customView;
    textfield.textColor = [UIColor blackColor];
    searchBar.barStyle = UIBarStyleDefault;
    self.navigationController.hidesBarsWhenKeyboardAppears = NO;
    
    
    
    return searchBar;
}

- (void)VersionUpdate{
   
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
                    
                }
                else if (result == -1) { NSLog(@"V1 < V2");
                    NSString *titelStr = @"检查更新";
                    NSString *messageStr = changelog;
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:titelStr message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
                    alert.tag = 1001;
                    [alert show];
                    
                    
                } else if (result ==0 ) { NSLog(@"V1 = V2"); }
                
                
                
                
            }
            
            
            if (!jsonError && [result isKindOfClass:[NSDictionary class]]) {
                //do something
                
            }
        }
    }];
    
}
- (int)compareArray1:(NSMutableArray *)array1 andArray2:(NSMutableArray *)array2 { for (int i = 0; i< array2.count; i++) { NSInteger a = [[array1 objectAtIndex:i] integerValue]; NSInteger b = [[array2 objectAtIndex:i] integerValue]; if (a > b) { return 1; } else if (a < b) { return -1; } } return 0; }

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag - 1000 == 1)
    {
        if (buttonIndex ==1)
        {
            
            NSString *URLencodeString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self.addressURL, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
            NSString *installURL = [NSString stringWithFormat:@"itms-services://?action=download-manifest&url=%@", URLencodeString];
            NSURL *openURL = [NSURL URLWithString:installURL];
            [[UIApplication sharedApplication] openURL:openURL];
           
        }
        
    }
    
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self loadMassage];
    
    
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
