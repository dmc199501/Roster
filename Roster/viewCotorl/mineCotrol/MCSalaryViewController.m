//
//  MCSalaryViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/14.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCSalaryViewController.h"
#import "MCSalaryTableViewCell.h"
#import "XTImaginaryLine.h"
#import "JLDatePickerView.h"
@interface MCSalaryViewController ()<JLDatePickerDelegate>
@property(nonatomic,strong)NSString *yearString;
@property(nonatomic,strong)NSString *mothString;
@property(nonatomic,strong)NSDictionary *dic;
@end

@implementation MCSalaryViewController
-(id)init{
    
   self = [super init];
    if (self) {
         listMutableArray = [NSMutableArray array];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"薪酬查询";
    
    heardView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    
    
    
    dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    [dateLabel setFont:[UIFont systemFontOfSize:14]];
    dateLabel.text = [NSString stringWithFormat:@"%@薪资",[self setupRequestMonth]];
    dateLabel.textColor = COLOR_56_COLOER;
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [heardView addSubview:dateLabel];
    
    NSString *dataSting = [NSString stringWithFormat:@"%@",[self setupRequestMonth]];
    _yearString = [dataSting substringToIndex:4];
    _mothString = [dataSting substringFromIndex:5];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 20)];
    label1.text = @"实际发薪(元)";
    label1.textColor  = COLOR_164_COLOER;
    [label1 setFont:[UIFont systemFontOfSize:14]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [heardView addSubview:label1];
  
    
    
    UIButton *dataButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    [dataButton setBackgroundColor:[UIColor clearColor]];
    [heardView addSubview:dataButton];
    [dataButton addTarget:self action:@selector(dataView) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLabel];
    
    sjMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 30)];
    sjMoneyLabel.text = @"0.00";
    sjMoneyLabel.textColor  = COLOR_56_COLOER;
    [sjMoneyLabel setFont:[UIFont systemFontOfSize:30]];
    [sjMoneyLabel setTextAlignment:NSTextAlignmentCenter];
    [heardView addSubview:sjMoneyLabel];
    
    
    
   
    
    
    
    
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64-120) style:UITableViewStyleGrouped];
    [self.view addSubview:listTableView];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [listTableView setBackgroundView:nil];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    listTableView.scrollEnabled = YES;
    [listTableView setTableHeaderView:heardView];
    
    
    
    [self getXcData];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [footView removeFromSuperview];
}

-(void)setCzUI:(NSString *)state{
    
    [footView removeFromSuperview];
   
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT -120, SCREEN_WIDTH, 120)];
    [[UIApplication sharedApplication].keyWindow addSubview:footView];
    
    
    NSString *isconfirm = [NSString stringWithFormat:@"%@",state];
   
    if ([isconfirm isEqualToString:@"0"]) {
        
        
        
        
        UIButton *YesButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 -157)/2, 30, 157, 40)];
        YesButton.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:98 / 255.0 blue:82/ 255.0 alpha:1];
        [YesButton setTitle:@"未收到!" forState:UIControlStateNormal];
        [YesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [YesButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        YesButton.tag = 1008;
        [YesButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:YesButton];
        
        
        
        
        
        UIButton *NoButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 -157)/2 +SCREEN_WIDTH/2, 30, 157, 40)];
        NoButton.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251/ 255.0 alpha:1];
        [NoButton setTitle:@"到账确认无误!" forState:UIControlStateNormal];
        NoButton.tag = 1009;
        [NoButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [NoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [NoButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [footView addSubview:NoButton];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
        label2.text = [NSString stringWithFormat:@"发薪人:%@",_dic[@"operator"]];
        label2.textColor  = COLOR_164_COLOER;
        [label2 setFont:[UIFont systemFontOfSize:14]];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label2];
    }else if ([isconfirm isEqualToString:@"1"]){
        
        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 20)];
        label3.text = @"到账确认无误!";
        label3.textColor  = [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251/ 255.0 alpha:1];
        [label3 setFont:[UIFont systemFontOfSize:14]];
        [label3 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label3];
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
        label5.text = [NSString stringWithFormat:@"发薪人:%@",_dic[@"operator"]];
        label5.textColor  = COLOR_164_COLOER;
        [label5 setFont:[UIFont systemFontOfSize:14]];
        [label5 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label5];
        
        
    }else{
        
        UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 20)];
        label4.text = @"未到账!";
        label4.textColor  = [UIColor colorWithRed:236 / 255.0 green:98 / 255.0 blue:82/ 255.0 alpha:1];
        [label4 setFont:[UIFont systemFontOfSize:14]];
        [label4 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label4];
        
        UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
        label6.text = [NSString stringWithFormat:@"发薪人:%@",_dic[@"operator"]];
        label6.textColor  = COLOR_164_COLOER;
        [label6 setFont:[UIFont systemFontOfSize:14]];
        [label6 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label6];
        
        
    }
   
    
}


#pragma 提交操作
-(void)submit:(UIButton *)button{
    
     NSMutableDictionary *sendDictionary = [NSMutableDictionary dictionary];
    
    if (button.tag==1008) {
        
        [sendDictionary setValue:_dic[@"id"] forKey:@"id"];
        [sendDictionary setValue:@(-1) forKey:@"isconfirm"];
    }else{
        [sendDictionary setValue:_dic[@"id"] forKey:@"id"];
        [sendDictionary setValue:@(1) forKey:@"isconfirm"];
        
    }
   
    
    
   
    
    
    
    [MCHttpManager PutWithIPString:BASEURL_GZMX urlMethod:@"/payrollall" parameters:sendDictionary success:^(id responseObject)
     
     {
         NSDictionary *dicDictionary = responseObject;
         
         if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"])
         {
             if (button.tag==1008) {
                 
                 [self setCzUI:@"-1"];
             }else{
                 
                 [self setCzUI:@"1"];
                 
             }
             
             
         }else{
             
             [STTextHudTool showErrorText:@"操作失败"];
             
         }
     } failure:^(NSError *error) {
         
         NSLog(@"****%@", error);
         
     }];

}
#pragma -mark按年月查询薪资
-(void)getXcData{
    
   
    
    NSMutableDictionary *sendDict = [NSMutableDictionary dictionary];
    [sendDict setObject:_yearString forKey:@"year"];
    [sendDict setObject:_mothString forKey:@"month"];
    [sendDict setObject:[Defaults objectForKey:@"uuid"] forKey:@"uuid"];
  
    
    [MCHttpManager GETWithIPString:BASEURL_GZMX urlMethod:@"/payrollall" parameters:sendDict success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"])
        {
            NSArray *array = dicDictionary[@"content"][@"data"];
            if ([array isKindOfClass:[NSArray class]] &&[array count]>0 )
            {
                
                
                self->_dic = dicDictionary[@"content"][@"data"][0];
                [self->sjMoneyLabel setText:[NSString stringWithFormat:@"%.2f",[[self->_dic objectForKey:@"salary"] doubleValue]]];
                [self->listTableView reloadData];
                NSString *isconfirm = [NSString stringWithFormat:@"%@",self->_dic[@"isconfirm"]];
                [self setCzUI:isconfirm];
               
                
                
                
                
            }else{
                
                self->_dic = [NSDictionary dictionary];
                [self->sjMoneyLabel setText:[NSString stringWithFormat:@"%@",@"0.00"]];
                [self->listTableView reloadData];
                [self setCzUI:@"-1"];
                
            }
            
        }else{
            
            
            self->_dic = [NSDictionary dictionary];
            [self->sjMoneyLabel setText:[NSString stringWithFormat:@"%@",@"0.00"]];
             [self->listTableView reloadData];
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        
        
        
        
    }];
    
}
#pragma -mark获取当前年月的上一个月份
- (NSString *)setupRequestMonth
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:-1];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    return dateStr;
   
}

#pragma -mark年月选择
-(void)dataView{
    
    
    JLDatePickerView *picker = [JLDatePickerView pickerViewWithType:JLDatePickerModeYearAndMonth];
    picker.delegate = self;
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"YYYY-MM"];
    //当前月
    picker.time = [formatter stringFromDate:[NSDate date]];
    [picker show];
}
-(void)JLDatePickerViewDidDismissWithConfirm:(JLDatePickerView *)pickerView string:(NSString *)string {
    if (pickerView.type == JLDatePickerModeYear || pickerView.type == JLDatePickerModeYearAndMonth || pickerView.type == JLDatePickerModeNomal) {
        
        [dateLabel setText:[NSString stringWithFormat:@"%@薪资",string]];
        _yearString = [string substringToIndex:4];
        _mothString = [string substringFromIndex:5];
        [self setLabel];
       
       
        [self getXcData];
        
       
    }
}
-(void)setLabel{
    
    NSTextAttachment *attach = [[NSTextAttachment alloc]init];
    attach.image = [UIImage imageNamed:@"2345日历"];
    attach.bounds = CGRectMake(-5, -3, 20, 20) ;
    
    NSTextAttachment *attach2 = [[NSTextAttachment alloc]init];
    attach2.image = [UIImage imageNamed:@"更多"];
    attach2.bounds = CGRectMake(10, -2, 7, 13) ;
    
    NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attach];
    NSAttributedString *imageStr2 = [NSAttributedString attributedStringWithAttachment:attach2];
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:dateLabel.text];
    [abs appendAttributedString:imageStr2];
    [abs insertAttributedString:imageStr atIndex:0];
   
    dateLabel.attributedText = abs ;
                     
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    switch (section)
    {
        case 0:
        {
            return 0.000001;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    switch (section)
    {
        case 0:
        {
            return 11;
        }
            break;
        case 1:
        {
            return 16;
        }
            break;
        default:
        {
            return 1;
        }
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString *indentifier = @"cell";
    MCSalaryTableViewCell *cell =   [[MCSalaryTableViewCell alloc]init];
    if (cell == nil)
    {
        cell = [[MCSalaryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
       
        
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 1)];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(23, 1, SCREEN_WIDTH-23, 1)];
    line2.backgroundColor = COLOR_LINE_MC;
    [XTImaginaryLine drawImaginaryLineByCAShapeLayer:line lineLength:3 lineSpacing:2 lineColor:COLOR_LINE_MC lineDirection:YES];

    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                    
                case 0:{
                    
                    cell.titleLabel.text = @"基本工资";
                    
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"basicWage"] doubleValue]]];
                }
                    break;
                case 1:{
                    
                    cell.titleLabel.text = @"岗位补贴";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"jobSubsidy"] doubleValue]]];
                }
                    break;
                case 2:{
                    
                    cell.titleLabel.text = @"加班费（平时）";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"overtimePay1"] doubleValue]]];
                }
                    break;
                case 3:{
                    
                    cell.titleLabel.text = @"加班费（周末）";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"overtimePay2"] doubleValue]]];
                }
                    break;
                case 4:{
                    
                    cell.titleLabel.text = @"加班费（节假日）";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"overtimePay3"] doubleValue]]];
                }
                    break;
                case 5:{
                    
                    cell.titleLabel.text = @"绩效";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"performance"] doubleValue]]];
                }
                    break;
                case 6:{
                    
                    cell.titleLabel.text = @"奖励";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"reward"] doubleValue]]];
                }
                    break;
                case 7:{
                    
                    cell.titleLabel.text = @"高温补贴";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"highTemperature"] doubleValue]]];
                }
                    break;
                case 8:{
                    
                    cell.titleLabel.text = @"其他补贴";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"otherSubsidy"] doubleValue]]];
                }
                    break;
                case 9:{
                    
                    cell.titleLabel.text = @"补发";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"leave"] doubleValue]]];
                }
                    break;
                case 10:{
                    
                    cell.titleLabel.text = @"应发合计";
                    
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"sumsalary"] doubleValue]]];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                    [cell addSubview:line2];
                    cell.titleLabel.text = @"实发";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"salary"] doubleValue]]];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            cell.moneyLabel.textColor = [UIColor colorWithRed:229 / 255.0 green:62 / 255.0 blue:42/ 255.0 alpha:1];
            switch (indexPath.row) {
                case 0:
                {
                    
                    [cell addSubview:line2];
                    cell.titleLabel.text = @"事假扣款";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"reissue"] doubleValue]]];
                    
                }
                    break;
                    
                case 1:
                {
                    
                    
                    cell.titleLabel.text = @"迟到/早退";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"lateEarly"] doubleValue]]];
                    
                }
                    break;
                case 2:
                {
                    
                    
                    cell.titleLabel.text = @"病假扣款";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"sickLeave"] doubleValue]]];
                    
                }
                    break;
                case 3:
                {
                    
                    
                    cell.titleLabel.text = @"缺勤扣款";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"absence"] doubleValue]]];
                    
                }
                    break;
                case 4:
                {
                    
                    
                    cell.titleLabel.text = @"爱心互助扣款";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"contribution"] doubleValue]]];
                    
                }
                    break;
                case 5:
                {
                    
                    
                    cell.titleLabel.text = @"其他扣费";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"oherdeduction"] doubleValue]]];
                    
                }
                    break;
                case 6:
                {
                    
                    
                    cell.titleLabel.text = @"扣保险费";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"insurance"] doubleValue]]];
                    
                }
                    break;
                case 7:
                {
                    
                    
                    cell.titleLabel.text = @"责任处罚";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"punish"] doubleValue]]];
                    
                }
                    break;
                case 8:
                {
                    
                    
                    cell.titleLabel.text = @"社保(个人承担部分)";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"socialsecurity2"] doubleValue]]];
                    
                }
                    break;
                case 9:
                {
                    
                    
                    cell.titleLabel.text = @"子女教育扣除项";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"znjy"] doubleValue]]];
                    
                }
                    break;
                case 10:
                {
                    
                    
                    cell.titleLabel.text = @"住房贷款利息扣除项";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"zfdk"] doubleValue]]];
                    
                }
                    break;
                case 11:
                {
                    
                    
                    cell.titleLabel.text = @"租房租金扣除项";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"zfzj"] doubleValue]]];
                    
                }
                    break;
                case 12:
                {
                    
                    
                    cell.titleLabel.text = @"赡养老人扣除项";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"sylr"] doubleValue]]];
                    
                }
                    break;
                case 13:
                {
                    
                    
                    cell.titleLabel.text = @"继续教育扣除项";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"jxjy"] doubleValue]]];
                    
                }
                    break;
                case 14:
                {
                    
                    
                    cell.titleLabel.text = @"扣税";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"tax"] doubleValue]]];
                    
                }
                    break;
                case 15:
                {
                    
                    
                    cell.titleLabel.text = @"补扣";
                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"buckle"] doubleValue]]];
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
   
    
    return cell;
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
