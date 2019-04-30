//
//  MCMyDepartmentViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/11.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCMyDepartmentViewController.h"
#import "MCersonnelTableViewCell.h"
#import "MCSearchViewController.h"
@interface MCMyDepartmentViewController ()<UISearchBarDelegate>
@property(nonatomic, strong) NSString *searchStr;
@end

@implementation MCMyDepartmentViewController
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
    self.navigationItem.title = @"所属部门";
    
    //添加搜索框
    
    [self.view addSubview:[self headView]];

    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(19, 0, SCREEN_WIDTH-38, 44)];
    [self.view addSubview:pushButton];
    [pushButton addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT -64 -60 ) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    // Do any additional setup after loading the view.
}


-(void)pushVC{
    
    MCSearchViewController *searcVC = [[MCSearchViewController alloc]init];
    searcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searcVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    
    return 50;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
{
    return 0.00001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
    
    //    return listMutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (section)
    {
        case 0:
        {
            return 5;
        }
            break;
        case 1:
        {
            return 5;
        }
            break;
        case 2:
        {
            return 5;
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
    MCersonnelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCersonnelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    [cell.iconImageView setImage:[UIImage imageNamed:@"TZ_fuwu"]];
    [cell.nameLabel setText:@"张朝阳"];
    [cell.jibLabel setText:@"产品设计部"];
    
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    static NSString *headerIdentifier = @"header";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    
    if (headerView == nil)
    {
        headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerIdentifier];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = COLOR_248_COLOER;
        [headerView addSubview:backView];
        
        UILabel *titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(19, 15, tableView.frame.size.width - 50, 20)];
        [headerView addSubview:titleLabel];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        [titleLabel setTextColor:COLOR_56_COLOER];
        [titleLabel setTag:1213];
        
      

        
    }

    
    
    NSString *titleString = nil;
    
    switch (section)
    {
        case 0:
        {
            titleString = @"上级";
            
        }
            break;
        case 1:
        {
            titleString = @"平级";
            
            
        }
            break;
        case 2:
        {
            titleString = @"下级";
           
        }
            break;
            
        default:
            break;
    }
    
    UILabel *titleLabel = (UILabel *)[headerView viewWithTag:1213];
    [titleLabel setText:titleString];
    
    
    return headerView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
  
    
    
}
//UISearchBar初始化
-(UIView *)headView{
    
    
    UISearchBar *searchBar = [[UISearchBar alloc]init];
    
    
    searchBar.frame=CGRectMake(19, 0, SCREEN_WIDTH-38, 44);
    searchBar.keyboardType = UIKeyboardTypeWebSearch;
    searchBar.placeholder = @"搜索";
    searchBar.delegate = self;
    //[searchBar becomeFirstResponder];
    [[[[ searchBar.subviews objectAtIndex : 0 ] subviews ] objectAtIndex : 0 ] removeFromSuperview ];
    searchBar.userInteractionEnabled = NO;
   
    
   
    //底部的颜色
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
#pragma mark-searchBarDelegate

//在搜索框中修改搜索内容时，自动触发下面的方法
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    
    
    return YES;
    
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
}



//搜框中输入关键字的事件响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.searchStr = [NSString stringWithFormat:@"%@",searchText];
    
    
}

//搜索的响应事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
   
    
    
}



//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
   
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
