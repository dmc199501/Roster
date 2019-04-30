//
//  MCMessageListViewController.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 2017/6/27.
//  Copyright © 2017年 邓梦超. All rights reserved.
//

#import "MCMessageListViewController.h"
#import "MCWebViewController.h"
#import "MCHomePageTableViewCell.h"
#import "MJRefresh.h"
@interface MCMessageListViewController ()
@property (nonatomic, assign) int page;  //请求页码
@end

@implementation MCMessageListViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        listMutableArray = [NSMutableArray array];
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    self.navigationItem.title = self.title;
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor whiteColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    
    __unsafe_unretained __typeof(self) weakSelf = self;
   
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self loadMassage];
    
    
    //[listTableView setTableHeaderView:headerView];
    // Do any additional setup after loading the view.
}
- (void)changgeIsRed{

    NSMutableDictionary *sendDictionary = [NSMutableDictionary dictionary];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];

    [sendDictionary setValue:self.code forKey:@"client_code"];
    [sendDictionary setValue:username forKey:@"username"];
    


    [MCHttpManager PutWithIPString:BASEURL_ROSTER urlMethod:@"/homepush/readhomePush" parameters:sendDictionary success:^(id responseObject)

     {
     NSLog(@"****%@", responseObject);

     } failure:^(NSError *error) {

         NSLog(@"****%@", error);

     }];



}
- (void)therRefresh{
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMassage)];
    
    // 设置文字
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松手立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"努力刷新中" forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置颜色
    header.stateLabel.textColor = [UIColor grayColor];
    // 马上进入刷新状态
    [header beginRefreshing];
    
    // 设置刷新控件
    listTableView.mj_header = header;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    listTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 10)];
    bgView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245/ 255.0 alpha:1];
    return bgView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (!(listMutableArray.count>0)) {
        
        UIView *webbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-142)/2, 100, 142, 114)];
        [webbackView addSubview:backImageView];
        [backImageView setImage:[UIImage imageNamed:@"暂无内容"]];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 230, 200, 20)];
        titleLabel.text = @"暂无内容";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = COLOR_164_COLOER;
        titleLabel.font = [UIFont systemFontOfSize:14];
        [webbackView addSubview:titleLabel];
        
        return webbackView;
    }
    
    return [[UIView alloc]init];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return listMutableArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *indentifier = @"cell";
    MCHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    
    
    NSDictionary *dataDictionary = [listMutableArray objectAtIndex:indexPath.row];
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
    cell.noReadImageView.hidden = nil;
    
    cell.noReadImageView.frame = CGRectMake(SCREEN_WIDTH-36, 39, 11, 11);
    [cell.noReadImageView.layer setCornerRadius:5.5];
    cell.numberLabel.hidden = YES;
    NSString *noRead = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"notread"]];
    if ([noRead isEqualToString:@"0"]) {
        
       
            
    cell.noReadImageView.hidden = NO;
        
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
    MCHomePageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
   
    cell.noReadImageView.hidden = YES;
    NSDictionary *dataDictionary = [listMutableArray objectAtIndex:indexPath.row];
   
    //修改字典值
//    NSDictionary *item = [listMutableArray objectAtIndex:indexPath.row];
//    NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
//    [mutableItem setObject:@"1" forKey:@"notread"];
//    [listMutableArray setObject:mutableItem atIndexedSubscript:indexPath.row];
//    [tableView reloadData];
    
//
//    NSString * URLString = [NSString stringWithFormat:@"%@",dataDictionary[@"url"]];
//    MCWebViewController *webVC = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:@""] titleString:@""];
//    [self.navigationController pushViewController:webVC animated:YES];
    [STTextHudTool showErrorText:@"功能暂未开放" withSecond:1];
    [self changgeIsRed];
   
  
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
{
    return @"删除";
}

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return YES;
}
// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        NSDictionary *dataDictionary = [listMutableArray objectAtIndex:indexPath.row];
        
        //        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        //        //    [hub setLabelText:@""];
        //        [hub setDetailsLabelText:@"正在删除......"];
        //        __weak  MBProgressHUD *weakHub = hub;
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        
        NSString *username = [defaults objectForKey:@"username"];
        NSMutableDictionary *sendMutabelDictionary = [NSMutableDictionary dictionary];
        NSString * messageID = [NSString stringWithFormat:@"%@",[dataDictionary objectForKey:@"id"]];
        
        [sendMutabelDictionary setValue:messageID forKey:@"msgid"];
        [sendMutabelDictionary setValue:username forKey:@"username"];
       
      
        //userToken	否	登录的时效身份标识  deviceSN	是	设备唯一序列号   deviceType	否	设备类型   pushID	是	pushID>0只删除当前pushID，不考虑删除全部  deleteAll	是	等于0时，删除pushID数据
        [MCHttpManager DeleteWithIPString:BASEURL_ROSTER urlMethod:@"/homepush" parameters:sendMutabelDictionary success:^(id responseObject) {
            
            NSDictionary *dicDictionary = responseObject;
        
            if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
            {
                
               
                
                [self loadMassage];
                
                return;
                
                
                
                
            }
            
    
            
        } failure:^(NSError *error) {
            
            NSLog(@"****%@", error);
            
        }];
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMassage{
    
    
    
   
    
    
    NSDictionary *sendDict = @{
                               @"page":@"1",
                               @"pagesize":@"10",
                               @"client_code":_code,
                               @"username":[Defaults objectForKey:@"username"]
                               };
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/homepush" parameters:sendDict success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
      
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            if ([dicDictionary[@"content"] isKindOfClass:[NSDictionary class]])
            {
                
                
                [self->listMutableArray setArray:dicDictionary[@"content"][@"data"]];
    
                [self->listTableView reloadData];
                //[self setRedView];
                
                
                
                
            }else{
                
                
            }
            
        }else{
            
            
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        [STTextHudTool showErrorText:@"暂无内容" withSecond:1];
        NSLog(@"****%@", error);
        
        
        
        
    }];
    
    
    
}

- (void)loadMoreData{
    
    
    _page += 1;
    NSDictionary *sendDict = @{
                               @"page":@(_page),
                               @"pagesize":@"10",
                                @"client_code":_code,
                                @"username":[Defaults objectForKey:@"username"]
                               };
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/homepush" parameters:sendDict success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            if ([dicDictionary[@"content"] isKindOfClass:[NSDictionary class]])
            {
                
                
                [self->listMutableArray addObjectsFromArray:dicDictionary[@"content"][@"data"]];
                
                [self->listTableView reloadData];
                [self->listTableView.mj_footer endRefreshing];
                //[self setRedView];
                
                
                
                
            }else{
                
                self->listTableView.mj_footer.state = MJRefreshStateNoMoreData;
                
                
            }
            
            
        }else{
            
            self->listTableView.mj_footer.state = MJRefreshStateNoMoreData;
          
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        self->listTableView.mj_footer.state = MJRefreshStateNoMoreData;
        
        
        
    }];
    
   [self->listTableView.mj_footer endRefreshing];
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
