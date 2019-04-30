//
//  LeftMenuViewDemo.m
//  MenuDemo
//
//  Created by Lying on 16/6/12.
//  Copyright © 2016年 Lying. All rights reserved.
//
#define ImageviewWidth    18
#define Frame_Width       self.frame.size.width//200

#import "LeftMenuViewDemo.h"
#import "AppDelegate.h"
#import "otherViewController.h"
#import "MyModel.h"
#import "MCHttpManager.h"
#import "MCMacroDefinitionHeader.h"
#import "LeftTableViewCell.h"
#import "STTextHudTool.h"
@interface LeftMenuViewDemo ()<UITableViewDataSource,UITableViewDelegate,LeftTableViewCellDelegate>

@property (nonatomic ,strong)UITableView    *contentTableView;
@property (nonatomic, strong) NSMutableArray <MyModel *>* dataArray;
@property (nonatomic, assign) NSString * isJG;
@end

@implementation LeftMenuViewDemo


-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
        listMutableArray = [NSMutableArray array];
        xjlistMutableArray = [NSMutableArray array];
        [self initView];
    }
    return  self;
}

-(void)initView{

     self.backgroundColor = [UIColor whiteColor];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, 200, 30)];
    label.text = @"全集团";
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont systemFontOfSize:20]];
    label.textColor = COLOR_56_COLOER;
    [bgView addSubview:label];
    
    UIButton *qjtbutton  = [UIButton buttonWithType:UIButtonTypeSystem];
    qjtbutton.frame = CGRectMake(0, 60, SCREEN_WIDTH, 30);
    [bgView addSubview:qjtbutton];
    [qjtbutton addTarget:self action:@selector(pushData) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,Frame_Width , SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self addSubview:TableView];
    [TableView setBackgroundColor:[UIColor whiteColor]];
    [TableView setBackgroundView:nil];
    [TableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [TableView setDelegate:self];
    [TableView setDataSource:self];
    [TableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [TableView setTableHeaderView:bgView];
    [self addSubview:TableView];
    
    [self getOrgData];
}

-(void)pushData{
    
    NSDictionary *dic = @{@"name":@"全集团",@"orguuid":@""};
    NSDictionary *dataDic = [NSDictionary dictionaryWithObject:dic forKey:@"orginfo"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"infoNotification" object:nil userInfo:dataDic];
    
  
    [self.customDelegate LeftMenuViewClick:0];
    
    
}
-(void)getOrgData{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //[dic setObject:orguuid forKey:@"parentId"];
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/framework/getframeworkall" parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
      
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"][@"data"];
            
            if ([dicDictionary[@"content"][@"data"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
            {
                
                [self->listMutableArray setArray:array];
                
                
                [self loadData];
                
                
                
                
                
            }
            
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        
        
        
        
    }];
}
-(void)getOrgData:(NSString *)orguuid{
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:orguuid forKey:@"parentId"];
    
    [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/framework/getframeworkall" parameters:dic success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
        {
            NSArray *array = dicDictionary[@"content"][@"data"];
            
            if ([dicDictionary[@"content"][@"data"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
            {
                
                [self->xjlistMutableArray setArray:array];
                
                
                
            }
            
            
        }
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        
        
        
        
    }];
}
- (void)loadData {
    dispatch_async(dispatch_queue_create(0, 0), ^{
        if (!self.dataArray) {
            self.dataArray = [NSMutableArray array];
        }
        
        for (int i = 1; i < self->listMutableArray.count+1; i++) {
            MyModel *model = [[MyModel alloc] init];
            model.title = [NSString stringWithFormat:@"%@", [self->listMutableArray objectAtIndex:i-1][@"name"]];
            model.orguuid = [NSString stringWithFormat:@"%@", [self->listMutableArray objectAtIndex:i-1][@"uuid"]];
            model.level = 0;
            model.haveSubLevel = YES;
            model.expand = NO;
            [self.dataArray addObject:model];
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->TableView reloadData];
        });
    });
}

#pragma mark - Table view data source
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView = [[UIView alloc]init];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    //    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    //    bgView.backgroundColor = [UIColor whiteColor];
    //
    //    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 60, 200, 30)];
    //    label.text = @"组织架构";
    //    label.textAlignment = NSTextAlignmentLeft;
    //    [label setFont:[UIFont systemFontOfSize:20]];
    //    label.textColor = COLOR_56_COLOER;
    //    [bgView addSubview:label];
    
    return [[UIView alloc]init];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentifier = @"cell";
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil)
    {
        cell = [[LeftTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.delegate = self;
    }
    
    MyModel *model = self.dataArray[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@",model.title];
    
    
    
    NSString *str1 = model.expand ? @"更多" : @"更多下";
    
    
    [cell.fxImageView setImage:[UIImage imageNamed:str1]];
    if ([str1 isEqualToString:@"更多下"]) {
        cell.fxImageView.frame = CGRectMake(SCREEN_WIDTH*0.8 -75, 30, 15, 8);
    }else{
        
        cell.fxImageView.frame = CGRectMake(SCREEN_WIDTH*0.8 -70, 26.5, 8, 15);
    }
    // cell.textLabel.text = [(model.haveSubLevel ? str1 : @"") stringByAppendingString:model.title];
    //    cell.detailTextLabel.text = [NSString stringWithFormat:@"第 %ld 级", model.level];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 68;
}
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row].level;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyModel *model = self.dataArray[indexPath.row];
   
    NSDictionary *dic = @{@"name":model.title,@"orguuid":model.orguuid};
    NSDictionary *dataDic = [NSDictionary dictionaryWithObject:dic forKey:@"orginfo"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"infoNotification" object:nil userInfo:dataDic];
    
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
    
}

- (void)expandWithIndexPath:(NSIndexPath *)indexPath {
    //NSDictionary *dicc = listMutableArray[indexPath.row];
    MyModel *model = self.dataArray[indexPath.row];
    NSMutableArray *tempArray = [NSMutableArray array];
    [TableView beginUpdates];
    if (!model.expand) {
        
        //[self getOrgData:dic[@"uuid"]];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:model.orguuid forKey:@"parentId"];
        
        [MCHttpManager GETWithIPString:BASEURL_ROSTER urlMethod:@"/framework/getframeworkall" parameters:dic success:^(id responseObject) {
            
            NSDictionary *dicDictionary = responseObject;
            
            
            
            if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"] )
            {
                NSArray *array = dicDictionary[@"content"][@"data"];
                NSString *zwfString = @"";
                switch (model.level) {
                    case 0:
                    {
                        zwfString = @"    ";
                    }
                        break;
                    case 1:
                    {
                        zwfString = @"       ";
                    }
                        break;
                    case 2:
                    {
                        zwfString = @"            ";
                    }
                        break;
                    case 3:
                    {
                        zwfString = @"                ";
                    }
                        break;
                        
                    default:
                        break;
                }
                
                if ([dicDictionary[@"content"][@"data"] isKindOfClass:[NSArray class]] && kArrayIsEmpty(array) == 0)
                {
                    [self->xjlistMutableArray setArray:array];
                    
                    
                    
                    for (int i = 1; i <array.count+1; i++) {
                        MyModel *tempModel = [[MyModel alloc] init];
                        tempModel.title =[NSString stringWithFormat:@"%@%@",zwfString,[array objectAtIndex:i-1][@"name"]] ;
                        tempModel.orguuid =[NSString stringWithFormat:@"%@",[array objectAtIndex:i-1][@"uuid"]] ;
                        tempModel.level = model.level + 1;
                        tempModel.haveSubLevel = YES;
                        tempModel.expand = NO;
                        [self.dataArray insertObject:tempModel atIndex:(indexPath.row + i)];
                        [tempArray addObject:[NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section]];
                    }
                    [self->TableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationTop];
                    model.expand = !model.expand;
                    [self->TableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self->TableView endUpdates];
                    
                }else{
                    //                    array = @[@{@"name":@"无下级架构!",@"uuid":@"00"}];
                    //                    for (int i = 1; i <array.count+1; i++) {
                    //                        MyModel *tempModel = [[MyModel alloc] init];
                    //                        tempModel.title =[NSString stringWithFormat:@"%@%@",zwfString,[array objectAtIndex:i-1][@"name"]] ;
                    //                        tempModel.orguuid =[NSString stringWithFormat:@"%@",[array objectAtIndex:i-1][@"uuid"]] ;
                    //                        tempModel.level = model.level + 1;
                    //                        tempModel.haveSubLevel = YES;
                    //                        tempModel.expand = NO;
                    //                        [self.dataArray insertObject:tempModel atIndex:(indexPath.row +1)];
                    //                        [tempArray addObject:[NSIndexPath indexPathForRow:(indexPath.row) inSection:indexPath.section]];
                    //                    }
                    //[tempArray removeAllObjects];
                    [STTextHudTool showErrorText:@"无下级架构" withSecond:0.5];
                    [self->TableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationTop];
                    // model.expand = !model.expand;
                    [self->TableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self->TableView endUpdates];
                    
                }
                
                
            }
            
            
            
        } failure:^(NSError *error) {
            
            
            NSLog(@"****%@", error);
            
            
            
            
        }];
        
       
        
    } else {
        
        
        
        NSUInteger index = indexPath.row;
        NSUInteger total = self.dataArray.count;
        //            NSLog(@"第111一--%ld--%ld",index,total);
        //            NSLog(@"第222一--%ld--%ld",model.level,self.dataArray[indexPath.row + 1].level);
        while (model.level < self.dataArray[indexPath.row + 1].level) {
            [self.dataArray removeObjectAtIndex:indexPath.row + 1];
            [tempArray addObject:[NSIndexPath indexPathForRow:++index inSection:0]];
            if (total <= (index + 1)) {
                break;
            }
        }
        [TableView deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationTop];
        
        model.expand = !model.expand;
        [TableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [TableView endUpdates];
        
        
        
    }
    
}

-(void)LeftTableViewCellDelegate:(LeftTableViewCell *)LeftTableViewCell next:(UIButton *)Button{
    NSIndexPath *indexPath = [TableView indexPathForCell:LeftTableViewCell];
    MyModel *model = self.dataArray[indexPath.row];
    if (model.level == 3 || [_isJG isEqualToString:@"noMC"]) {
        
        [STTextHudTool showErrorText:@"无下级架构" withSecond:1.0];
    }else{
        
        [self expandWithIndexPath:indexPath];
    }
    
    
    
    
}



@end
