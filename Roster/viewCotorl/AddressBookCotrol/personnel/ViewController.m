//
//  ViewController.m
//  AddressBook
//
//  Created by YaSha_Tom on 2017/8/21.
//  Copyright © 2017年 YaSha-Tom. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"
#import "DingDingHeader.h"
#import "MyTableViewCell.h"
#import "MCMacroDefinitionHeader.h"
#import "MCersonnelTableViewCell.h"
#import "MCBusinessViewController.h"
#import "MCSearchViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UISearchBarDelegate>

@property(nonatomic, strong) NSString *searchStr;
@property (nonatomic,strong) UITableView *table;
@property(strong,nonatomic)MyScrollView * mScrollView;//导航栏标题
@property(nonatomic,assign)BOOL isBack;



@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
   
    __weak typeof(self) weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    //判断是否为rootViewController
    if (self.navigationController && self.navigationController.viewControllers.count == 1) {
        return NO;
    }else{
        if ([DingDingHeader shareHelper].titleList.count > 1) {
            [[DingDingHeader shareHelper].titleList removeObjectAtIndex:[DingDingHeader shareHelper].titleList.count-1];
        }
        if ([DingDingHeader shareHelper].titleList.count == 1) {
            [[DingDingHeader shareHelper].titleList removeAllObjects];
        }
        return YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [backView addSubview:[self headView]];
    
    pushButton = [[UIButton alloc]initWithFrame:CGRectMake(19, 0, SCREEN_WIDTH-38, 44)];
    [backView addSubview:pushButton];
    [pushButton addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"左箭头"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backOnView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
   

    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20   ) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[MCersonnelTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.table];
    [self.table setTableHeaderView:backView];
    [self.table  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[DingDingHeader shareHelper].titleList addObject:self.title];
    
    [self getPersonnelandUUID:self.organizatinUUID];
   
    
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
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [backView addSubview:[self headView]];
        
        pushButton = [[UIButton alloc]initWithFrame:CGRectMake(19, 0, SCREEN_WIDTH-38, 44)];
        [backView addSubview:pushButton];
        [pushButton addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
        
        [self.table setTableHeaderView:backView];
        self.table.frame = CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT-44-20);
        [self.table reloadData];
        
    } else {
        // 竖屏布局 balabala
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [backView addSubview:[self headView]];
        
        pushButton = [[UIButton alloc]initWithFrame:CGRectMake(19, 0, SCREEN_WIDTH-38, 44)];
        [backView addSubview:pushButton];
        [pushButton addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
        
         [self.table setTableHeaderView:backView];
         self.table.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20);
        [self.table reloadData];
    }
}
#pragma -mark获取组织架构信息列表ting
-(void)getPersonnelandUUID:(NSString *)uuidSting{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     [dic setObject:UUID forKey:@"adminid"];
    
    
   
   
    if (_isHomePage) {
        
        if ([self.navigationItem.title isEqualToString:@"组织架构"]) {
           
            [dic setObject:@"0" forKey:@"uuid"];
        }else{
            
            
            [dic setObject:_pushOrgid forKey:@"uuid"];
        }
        
        
       
    }else{
        
         [dic setObject:uuidSting forKey:@"uuid"];
    }
     NSLog(@"参数%@",dic);
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/framework/getframeworkcontacts" parameters:dic success:^(id responseObject) {
        
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
                
                
                [self.table  reloadData];
                
                
                
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
- (UIScrollView *)mScrollView {
    if (!_mScrollView) {
        _mScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        _mScrollView.backgroundColor = [UIColor whiteColor];
        _mScrollView.delegate = self;
        
        _mScrollView.showsHorizontalScrollIndicator = NO;
        _mScrollView.showsVerticalScrollIndicator = NO;
        __weak typeof(self) weakSelf = self;
        [_mScrollView setBtnClick:^(NSString * title, NSInteger tag) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil];
            if (tag==0) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                [[DingDingHeader shareHelper].titleList removeAllObjects];
            }
            else{
                
                [[DingDingHeader shareHelper].titleList removeObjectsInRange:NSMakeRange(tag+1, [DingDingHeader shareHelper].titleList.count-tag-1)];
                [weakSelf.navigationController.viewControllers
                 enumerateObjectsUsingBlock:^(id obj, NSUInteger idx,
                                              BOOL *stop) {
                     if ([obj isKindOfClass:ViewController
                          .class]) {
                         
                         for (int i=0; i<[DingDingHeader shareHelper].titleList.count; i++) {
//                             NSLog(@"--%@,%d------%@",[[DingDingHeader shareHelper].titleList objectAtIndex:i],i,title);
//                             NSLog(@"=========%@",weakSelf.navigationController
//                                   .viewControllers);
                             if ([title isEqualToString:[[DingDingHeader shareHelper].titleList objectAtIndex:i]]) {
                                 idx = i;
                                 [weakSelf.navigationController
                                  popToViewController:weakSelf.navigationController
                                  .viewControllers[idx]
                                  animated:YES];
                                 
                                 return ;
                                 
                             }
                         }
                     }
                 }];
                weakSelf.mScrollView.titleArr = [DingDingHeader shareHelper].titleList;
            }
        }];
        
    }
    return _mScrollView;
}
- (void)backOnView {
    if ([DingDingHeader shareHelper].titleList.count > 0) {
        [[DingDingHeader shareHelper].titleList removeObjectAtIndex:[DingDingHeader shareHelper].titleList.count-1];
    }
    if ([DingDingHeader shareHelper].titleList.count == 1) {
        [[DingDingHeader shareHelper].titleList removeAllObjects];
    }
    [self.navigationController popViewControllerAnimated:YES];

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

-(void)pushVC{
    
    MCSearchViewController *searcVC = [[MCSearchViewController alloc]init];
    searcVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searcVC animated:YES];
    
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


//搜框中输入关键字的事件响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.searchStr = [NSString stringWithFormat:@"%@",searchText];
    
    
}

//搜索的响应事件
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    
    
}



//键盘上搜索事件的响应
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"键盘上的");
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.organizatinArray.count;
    }else{
        return self.peopleArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }else{
        return 68;
    }
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
    
    return 0.01;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 2) {
        if (self.peopleArray.count==0&&self.organizatinArray.count==0) {
            
            UIView *webbackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
            
            UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-142)/2, 100, 142, 114)];
            [webbackView addSubview:backImageView];
            [backImageView setImage:[UIImage imageNamed:@"暂无内容"]];
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, 230, 200, 20)];
            titleLabel.text = @"暂无架构和人员";
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = COLOR_164_COLOER;
            titleLabel.font = [UIFont systemFontOfSize:14];
            [webbackView addSubview:titleLabel];
            
            return webbackView;
        }
    }
   
    UIView *footView = [[UIView alloc]init];
    return footView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    NSString *indentifier = [NSString stringWithFormat:@"cell%@%@",@(indexPath.section), @(indexPath.row)];
    MCersonnelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[MCersonnelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
   
    
   
    if (indexPath.section == 1) {
       
       
        for (UIView *view in cell.subviews) {
            
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
        cell.nameLabel.text = self.organizatinArray[indexPath.row][@"name"];
        cell.nameLabel.frame = CGRectMake(19, 24, [[UIScreen mainScreen] bounds].size.width - 130, 20);
        cell.lineView.frame = CGRectMake(0, 67, SCREEN_WIDTH, 1);
        UIImageView * arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 29, 26.5, 8, 15)];
        [cell addSubview:arrowImageView];
        [arrowImageView  setImage:[UIImage imageNamed:@"更多"]];
        
       
       
        
    }else if (indexPath.section == 2) {
        
        UIImageView * arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 29, 26.5, 8, 15)];
        [cell addSubview:arrowImageView];
        [arrowImageView  setImage:[UIImage imageNamed:@"更多"]];
        
        cell.nameLabel.text = self.peopleArray[indexPath.row][@"realname"];
        NSString *iconsting = [NSString stringWithFormat:@"%@",self.peopleArray[indexPath.row][@"icon"]];

        [cell.iconImageView setImageWithURL:[NSURL URLWithString:iconsting] placeholderImage:[UIImage imageNamed:@"默认头像"]];

         cell.jibLabel.text = [NSString stringWithFormat:@"%@|%@",self.peopleArray[indexPath.row][@"orgname"],self.peopleArray[indexPath.row][@"jobname"]];;
    }else {
        [cell.jibLabel removeFromSuperview];
        [cell.arrowImageView removeFromSuperview];
        [cell.nameLabel removeFromSuperview];
        [cell.contentView addSubview:self.mScrollView];
        self.mScrollView.titleArr = [DingDingHeader shareHelper].titleList;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
       
        [self getAddressBookData:@"TwoPageData" isTop:NO getName:self.organizatinArray[indexPath.row][@"name"] getUUid:self.organizatinArray[indexPath.row][@"uuid"]];
        
    }else if (indexPath.section == 2){
       
        MCBusinessViewController *businessVC = [[MCBusinessViewController alloc]init];
        businessVC.dataDic = self.peopleArray[indexPath.row];
        [self.navigationController pushViewController:businessVC animated:YES];
       
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
