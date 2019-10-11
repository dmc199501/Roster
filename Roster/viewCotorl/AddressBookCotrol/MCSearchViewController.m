//
//  MCSearchViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/3/12.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCSearchViewController.h"
#import "MCersonnelTableViewCell.h"
#import "MCBusinessViewController.h"
#import "MCHomePageTableViewCell.h"
#import "MCWebViewController.h"
#import "ViewController.h"
@interface MCSearchViewController ()<UISearchBarDelegate>
@property(nonatomic, strong) NSString *searchStr;

@end

@implementation MCSearchViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        listMutableArray = [NSMutableArray array];
       
      
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加搜索框
//   [self.view addSubview:[self headView]];
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setTableHeaderView:[self headView]];
    [listTableView setDataSource:self];
  
   
    // Do any additional setup after loading the view.
}

#pragma 搜索的数据
-(void)getSearchData{
    NSString *urlString =@"";
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
   
    
    if ([_pushType isEqualToString:@"home"]) {
        
        urlString = @"/homepush";
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSString *username = [defaults objectForKey:@"username"];
        [dic setObject:_searchStr forKey:@"keyword"];
        [dic setObject:@"1" forKey:@"page"];
        [dic setObject:username forKey:@"username"];
        [dic setObject:@"999" forKey:@"pagesize"];
        
        [STTextHudTool showWaitText:@"卖力搜索中..."];
        [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:urlString parameters:dic success:^(id responseObject) {
            
            [STTextHudTool hideSTHud];
            NSDictionary *dicDictionary = responseObject;
            
            
            
            if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
            {
                NSArray *array = dicDictionary[@"content"][@"data"];
                
                if ([dicDictionary[@"content"][@"data"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
                {
                    
                    
                    
                    
                    [self->listMutableArray setArray:array];
                    [self->listTableView reloadData];
                    
                    
                    
                    
                }else{
                    
                    [STTextHudTool showErrorText:@"未找到您要搜索的内容"];
                }
                
                
            }else{
                
                [STTextHudTool showErrorText:dicDictionary[@"message"]];
                
                
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            [STTextHudTool hideSTHud];
            NSLog(@"****%@", error);
            [STTextHudTool showErrorText:@"网络不给力!"];
            
            
            
        }];
        
    }else{
        
        urlString = @"/framework/getframeworkcontacts";
        [dic setObject:_searchStr forKey:@"keyword"];
          [STTextHudTool showWaitText:@"卖力搜索中..."];
        [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:urlString parameters:dic success:^(id responseObject) {
            [STTextHudTool hideSTHud];
            NSDictionary *dicDictionary = responseObject;
            
            
            NSLog(@"%@",dicDictionary);
            if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
            {
                
                
                if ([dicDictionary[@"content"] isKindOfClass:[NSDictionary class]])
                {
                    
                    
                    NSArray *array1 = dicDictionary[@"content"][@"orgdata"];
                    NSArray *array2 = dicDictionary[@"content"][@"userdata"];
                    self.peopleArray = [NSMutableArray array];
                    self.organizatinArray = [NSMutableArray array];
                    
                    if ([dicDictionary[@"content"][@"orgdata"] isKindOfClass:[NSArray class]] &&array1.count>0) {
                        
                        [self.organizatinArray setArray:array1];
                        
                    }
                    
                    if ([dicDictionary[@"content"][@"userdata"] isKindOfClass:[NSArray class]] &&array2.count>0) {
                        
                        [self.peopleArray setArray:array2];
                    }
                    
                    
                    [self->listTableView  reloadData];
                    
                    
                    
                }else{
                    
                    [STTextHudTool showErrorText:@"暂无数据"];
                }
                
                
            }else{
                
                [STTextHudTool showErrorText:dicDictionary[@"message"]];
                
                
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            
            NSLog(@"****%@", error);
            [STTextHudTool showErrorText:@"网络不给力!"];
            
            
            
        }];
       
        
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if ([_pushType isEqualToString:@"home"]) {
        
        return 68;
    }else{
        
        if (indexPath.section == 0) {
            return 60;
        }else{
           return 68;
        }
    }
    
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
   UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200, 20)];
   
//    label.textColor= [UIColor blackColor];
//    if (section==0) {
//
//        if (_organizatinArray.count>0) {
//
//
//            label.text = @"---组织架构---";
//        }
//
//    }else{
//
//        if (_peopleArray.count>0) {
//
//
//            label.text = @"---人员---";
//        }
//
//    }
//
//
    
    return label;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if ([_pushType isEqualToString:@"home"]) {
        
        return 1;
    }else{
        
        return 2;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ([_pushType isEqualToString:@"home"]) {
        
        return listMutableArray.count;
    }else{
        
        if (section == 0) {
            return self.organizatinArray.count;
        }else{
            return self.peopleArray.count;
        }
    }
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([_pushType isEqualToString:@"home"]) {
        
        static NSString *indentifier = @"cell1";
        MCHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[MCHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
            
        }
         NSDictionary *dataDictionary =[listMutableArray  objectAtIndex:indexPath.row];
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
        cell.noReadImageView.hidden = YES;
        cell.numberLabel.hidden = YES;
        
    
        
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
        
    }else{
        
        NSString *indentifier = [NSString stringWithFormat:@"cell%@%@",@(indexPath.section), @(indexPath.row)];
        MCersonnelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[MCersonnelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            
            cell.nameLabel.text = self.organizatinArray[indexPath.row][@"name"];
            cell.nameLabel.frame = CGRectMake(19, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20);
            cell.lineView.frame = CGRectMake(0, 67, SCREEN_WIDTH, 1);
        }else if (indexPath.section == 1) {
            cell.nameLabel.text = self.peopleArray[indexPath.row][@"realname"];
            NSString *iconsting = [NSString stringWithFormat:@"%@",self.peopleArray[indexPath.row][@"icon"]];
            [cell.iconImageView setImageWithURL:[NSURL URLWithString:iconsting] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            cell.jibLabel.text = [NSString stringWithFormat:@"%@|%@",self.peopleArray[indexPath.row][@"orgname"],self.peopleArray[indexPath.row][@"jobname"]];;
        }
        
        return cell;
    }
        
    
    return nil;
    
    
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if (![_pushType isEqualToString:@"home"]) {
        
        if (indexPath.section == 0) {
            
            [self getAddressBookData:@"TwoPageData" isTop:NO getName:self.organizatinArray[indexPath.row][@"name"] getUUid:self.organizatinArray[indexPath.row][@"uuid"]];
            
        }else if (indexPath.section == 1){
            
            MCBusinessViewController *businessVC = [[MCBusinessViewController alloc]init];
            businessVC.dataDic = self.peopleArray[indexPath.row];
            [self.navigationController pushViewController:businessVC animated:YES];
            
        }
        
    }else{
        
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
        
        
        NSString * URLString = [NSString stringWithFormat:@"%@",dataDictionary[@"url"]];
        MCWebViewController *webVC = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:URLString] titleString:@""];
        [self.navigationController pushViewController:webVC animated:YES];
        
    }
   
    
    
    
    
}



- (void)getAddressBookData:(NSString *)str isTop:(BOOL )top getName:(NSString *)name  getUUid:(NSString *)uuid{
    
    
    if (top) {
        
        
        
    }else {
        
        
        ViewController *vc = [[ViewController alloc]init];
        
        vc.title = name;
        vc.isHomePage = NO;
        vc.organizatinUUID = uuid;
        [self.navigationController pushViewController:vc animated:YES];
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
    
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

//UISearchBar初始化
-(UIView *)headView{
    
    
    searchBar = [[UISearchBar alloc]init];
    
    
    searchBar.frame=CGRectMake(0, 40, SCREEN_WIDTH, 44);
    searchBar.keyboardType = UIKeyboardTypeWebSearch;
    searchBar.placeholder = @"可输入组织架构名/岗位名/人员名查询相关数据";
    searchBar.delegate = self;
    [searchBar becomeFirstResponder];
    
    //底部的颜色
    searchBar.backgroundColor  = [UIColor whiteColor];
    UITextField *textfield = [[[searchBar.subviews firstObject] subviews] lastObject];
    textfield.backgroundColor =[UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240/ 255.0 alpha:1];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    textfield.font = [UIFont systemFontOfSize:15];
    //textfield.inputAccessoryView = self.customView;
    textfield.textColor = [UIColor blackColor];
    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.barStyle = UIBarStyleDefault;
    self.navigationController.hidesBarsWhenKeyboardAppears = YES;
    
    
    
    
    
    return searchBar;
}
#pragma mark-searchBarDelegate

//在搜索框中修改搜索内容时，自动触发下面的方法
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    
    return YES;
    
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
    searchBar.showsCancelButton = YES;//取消的字体颜色，
    [searchBar setShowsCancelButton:YES animated:YES];
    
    //改变取消的文本
    for(UIView *view in [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:COLOR_56_COLOER forState:UIControlStateNormal];
        }
    }
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    for (UIView *searchbuttons in [searchBar subviews]){
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            // 修改文字颜色
            [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            
            
        }
    }
    
   
}
//搜框中输入关键字的事件响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.searchStr = [NSString stringWithFormat:@"%@",searchText];
    
    
}

//搜索的响应事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
   
    [self getSearchData];
    searchBar.userInteractionEnabled = YES;
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
