//
//  MCAddressBookViewController.m
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

#import "MCAddressBookViewController.h"
#import "MCOrganizationTableViewCell.h"
#import "MCersonnelTableViewCell.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import "MCMyDepartmentViewController.h"
#import "ViewController.h"
#import "DingDingHeader.h"
#import "MCBusinessViewController.h"
#import "MCSearchViewController.h"
@interface MCAddressBookViewController ()<CNContactPickerDelegate,ABPeoplePickerNavigationControllerDelegate,MCMCBusinessViewControllerDelegate>


@end

@implementation MCAddressBookViewController
- (id)init
{
    self = [super init];
    if (self)
    {
        listMutableArray = [NSMutableArray array];
        [listMutableArray addObject:@[@{@"icon": @"组织架构", @"title":@"组织架构"}]];
        [listMutableArray addObject:@[@{@"icon": @"组织架构-下一级", @"title":@"我的部门"}]];
        [listMutableArray addObject:@[@{@"icon": @"手机通讯录", @"title":@"手机通讯录"}]];
        
        contactListMutableArray = [NSMutableArray array];
        
        
        
    }
    return  self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"通讯录" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(pushSearch)];
    
   
   
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 204   ) style:UITableViewStyleGrouped];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    listTableView.scrollEnabled = NO;
    
    float hight = getRectNavAndStatusHight +self.tabBarController.tabBar.bounds.size.height;
    contactListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT -hight) style:UITableViewStyleGrouped];
    [self.view addSubview:contactListTableView];
    
    [contactListTableView setBackgroundColor:[UIColor clearColor]];
    [contactListTableView setBackgroundView:nil];
    [contactListTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [contactListTableView setDelegate:self];
    [contactListTableView setDataSource:self];
    [contactListTableView setTableHeaderView:listTableView];
   
    [self getContacts];
    // Do any additional setup after loading the view.
}
#pragma -mark跳转搜索界面
-(void)pushSearch{
  
    MCSearchViewController *searcVC = [[MCSearchViewController alloc]init];
    searcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searcVC animated:YES];
    
   
    
}
#pragma -mark获取常用联系人列表数据
-(void)getContacts{
    [self->webbackView removeFromSuperview];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:UUID forKey:@"adminid"];//本人id
    [dic setObject:@"1" forKey:@"iscollection"];//是否查收藏过得联系人1是0否
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/contacts" parameters:dic success:^(id responseObject) {

        NSDictionary *dicDictionary = responseObject;
       
        NSLog(@"联系人%@",dicDictionary);
       
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"][@"data"];
            
            if ([dicDictionary[@"content"][@"data"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
            {
                
                
                
                
                [self->contactListMutableArray setArray:array];
                [self->contactListTableView reloadData];
               
                
                
                
            }else{
                
               
                [self->contactListMutableArray removeAllObjects];
                 [self->contactListTableView reloadData];
               
            }
            
            
        }else{
            
            
            [STTextHudTool showErrorText:dicDictionary[@"message"]];
           
            
            
        }
        
    
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        //[STTextHudTool showErrorText:@"网络不给力!"];
        
        
        
    }];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    [super viewDidAppear:YES];
    [self getContacts];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([tableView isEqual:listTableView]) {
        
        return 68;
        
    }
    
    else if ([tableView isEqual:contactListTableView])
    {
        
        return 68;
        
    }
    
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([tableView isEqual:listTableView]) {
        
        
    }
    
    else if ([tableView isEqual:contactListTableView])
        
    {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        headerView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = COLOR_248_COLOER;
        [headerView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(19, 20, 100, 20)];
        titleLabel.text = @"常用联系人";
        titleLabel.textColor = COLOR_56_COLOER;
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:titleLabel];
        
        
        return headerView;
        
    }
    
   
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if ([tableView isEqual:listTableView]) {
        
        
    }
    
    else if ([tableView isEqual:contactListTableView])
        
    {
        
        if (!(contactListMutableArray.count>0)) {
            
            webbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
            
            UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-45)/2, 70, 45, 45)];
            [webbackView addSubview:backImageView];
            [backImageView setImage:[UIImage imageNamed:@"路径 29.png"]];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 140, 200, 20)];
            titleLabel.text = @"您还没有添加常用联系人";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = COLOR_164_COLOER;
            titleLabel.font = [UIFont systemFontOfSize:14];
            [webbackView addSubview:titleLabel];
            
            return webbackView;
        }
       
        
    }
    
    
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    if ([tableView isEqual:listTableView]) {
        
       
    }
    
    else if ([tableView isEqual:contactListTableView])
        
    {
        
        return 50;
        
    }
    
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    
    
    if ([tableView isEqual:listTableView]) {
        
        
    }
    
    else if ([tableView isEqual:contactListTableView])
        
    {
        
        return 100;
        
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if ([tableView isEqual:listTableView]) {
        
        return listMutableArray.count;;
        
    }
    
    else if ([tableView isEqual:contactListTableView])
        
    {
        
        return 1;
        
    }
    
    return 0;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if ([tableView isEqual:listTableView]) {
        
        return ((NSArray *)([listMutableArray objectAtIndex:section])).count;
        
    }
    
    else if ([tableView isEqual:contactListTableView])
        
    {
        
        return contactListMutableArray.count;
        
        
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([tableView isEqual:listTableView]) {
        NSString *indentifier = [NSString stringWithFormat:@"cell%@%@",@(indexPath.section), @(indexPath.row)];
        MCOrganizationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[MCOrganizationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
            
            [cell.iconImageView setImage:[UIImage imageNamed:[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"icon"]]];
            [cell.titleLabel setText:[NSString stringWithFormat:@"%@",[[[listMutableArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] objectForKey:@"title"]]];
            
            switch (indexPath.section)
            {
                case 0:
                {
                    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(75, 67, SCREEN_WIDTH-75, 1)];
                    [cell addSubview:line];
                    line.backgroundColor =  COLOR_LINE_MC;
                }
                    break;
                case 1:
                {
                    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(75, 67, SCREEN_WIDTH-75, 1)];
                    [cell addSubview:line];
                    line.backgroundColor =  COLOR_LINE_MC;
                    
                    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-240, 24, 200, 20)];
                    titleLabel.textAlignment = NSTextAlignmentRight;
                    titleLabel.textColor = COLOR_164_COLOER;
                    titleLabel.font = [UIFont systemFontOfSize:16];
                    [cell addSubview:titleLabel];
                    NSDictionary *dic = [Defaults objectForKey:@"info"];
                    titleLabel.text = [NSString stringWithFormat:@"%@",dic[@"orgname"]];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                    
              
            }
            
            
        }
        
        return cell;
        
    } else{
        
        
        static NSString *indentifier = @"cell2";
        MCersonnelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
        if (cell == nil)
        {
            cell = [[MCersonnelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
            
        }
        
        NSDictionary *dataDictionary =[contactListMutableArray  objectAtIndex:indexPath.row];
        NSString *iconString = [NSString stringWithFormat:@"%@",dataDictionary[@"Icon"]];
        [cell.iconImageView setImageWithURL:[NSURL URLWithString:iconString] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        [cell.nameLabel setText:[NSString stringWithFormat:@"%@",dataDictionary[@"realname"]]];
        [cell.jibLabel setText:[NSString stringWithFormat:@"%@",dataDictionary[@"orgname"]]];
        
       
        return cell;
        
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if ([tableView isEqual:listTableView]){
        
        MCOrganizationTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:NO animated:YES];
        
        switch (indexPath.section)
        {
            case 0:
            {
               
                ViewController *VC = [[ViewController alloc]init];
                VC.hidesBottomBarWhenPushed = YES;
                VC.isHomePage = YES;
                VC.title = @"组织架构";
                [[DingDingHeader shareHelper].titleList removeAllObjects];
                [[DingDingHeader shareHelper].titleList addObject:@"通讯录"];
                [self.navigationController pushViewController:VC animated:YES];
            }
                break;
            case 1:
            {
                NSDictionary *dic = [Defaults objectForKey:@"info"];
                NSString *titileString = [NSString stringWithFormat:@"%@",dic[@"orgname"]];
                NSString *orgString = [NSString stringWithFormat:@"%@",dic[@"orguuid"]];
                ViewController *VC = [[ViewController alloc]init];
                VC.hidesBottomBarWhenPushed = YES;
                VC.isHomePage = YES;
                VC.pushOrgid = orgString;
                VC.title = titileString;
                [[DingDingHeader shareHelper].titleList removeAllObjects];
                [[DingDingHeader shareHelper].titleList addObject:@"通讯录"];
                [self.navigationController pushViewController:VC animated:YES];
                
//                MCMyDepartmentViewController *deparVC = [[MCMyDepartmentViewController alloc]init];
//                deparVC.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:deparVC animated:YES];
            }
                break;
            case 2:
            {
                [self touchesBegan];
            }
                break;
                
           
        }
        
    }else if ([tableView isEqual:contactListTableView]){
        NSDictionary *dataDictionary =[contactListMutableArray  objectAtIndex:indexPath.row];
        MCBusinessViewController *buVC = [MCBusinessViewController alloc];
        buVC.delegate = self;
        buVC.dataDic = dataDictionary;
        buVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:buVC animated:YES];
        
    }
    
    
}

#pragma -mark是否修改了收藏代理方法
-(void)delegateViewControllerDidClickiscollection:(NSString *)string{
    
    [self getContacts];
    
    
}

- (void)touchesBegan
{
    // 1.创建选择联系人的控制器
    CNContactPickerViewController *contactVc = [[CNContactPickerViewController alloc] init];
    
    // 2.设置代理
    contactVc.delegate = self;
    
    // 3.弹出控制器
    [self presentViewController:contactVc animated:YES completion:nil];
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
