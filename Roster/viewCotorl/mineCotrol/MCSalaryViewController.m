//
//  MCSalaryViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/1/14.
//  Copyright © 2019 邓梦超. All rights reserved.
//
#ifdef DEBUG
#define NSLog(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
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
        list = [NSMutableArray array];
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
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 20)];
    label1.text = @"实际发薪(元)";
    label1.textColor  = COLOR_164_COLOER;
    [label1 setFont:[UIFont systemFontOfSize:14]];
    [label1 setTextAlignment:NSTextAlignmentCenter];
    [heardView addSubview:label1];
    
    
    
  dataButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
    
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
    
    [self setUI];
  
    [self getXcData];
    
    // Do any additional setup after loading the view.
}

-(void)setUI{
    
   
    
    
    listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -64-120) style:UITableViewStyleGrouped];
    [listTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:listTableView];
    [listTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [listTableView setDelegate:self];
    [listTableView setDataSource:self];
    listTableView.scrollEnabled = YES;
    [listTableView setTableHeaderView:heardView];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    
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
        listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height -64-120);
        [listTableView reloadData];
        label1.frame = CGRectMake(0, 90, SCREEN_WIDTH, 20);
        heardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        dateLabel.frame =CGRectMake(0, 20, SCREEN_WIDTH, 20);
        dataButton.frame = CGRectMake(0, 20, SCREEN_WIDTH, 20);
        sjMoneyLabel.frame = CGRectMake(0, 50, SCREEN_WIDTH, 30);
         footView.frame =CGRectMake(0, SCREEN_HEIGHT -120, SCREEN_WIDTH, 120);
         label3.frame = CGRectMake(0, 50, SCREEN_WIDTH, 20);
        YesButton.frame = CGRectMake((SCREEN_WIDTH/2 -157)/2, 30, 157, 40);
        NoButton.frame = CGRectMake((SCREEN_WIDTH/2 -157)/2 +SCREEN_WIDTH/2, 30, 157, 40);
        ;
    } else {
        // 竖屏布局 balabala
         listTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height -64-120);
         [listTableView reloadData];
       label1.frame = CGRectMake(0, 90, SCREEN_WIDTH, 20);
        heardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
        dateLabel.frame =CGRectMake(0, 20, SCREEN_WIDTH, 20);
        dataButton.frame = CGRectMake(0, 20, SCREEN_WIDTH, 20);
        sjMoneyLabel.frame = CGRectMake(0, 50, SCREEN_WIDTH, 30);
        footView.frame =CGRectMake(0, SCREEN_HEIGHT -120, SCREEN_WIDTH, 120);
         label3.frame = CGRectMake(0, 50, SCREEN_WIDTH, 20);
        YesButton.frame = CGRectMake((SCREEN_WIDTH/2 -157)/2, 30, 157, 40);
        NoButton.frame = CGRectMake((SCREEN_WIDTH/2 -157)/2 +SCREEN_WIDTH/2, 30, 157, 40);
        
       
    }
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
        
        
        
        
        YesButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 -157)/2, 30, 157, 40)];
        YesButton.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:98 / 255.0 blue:82/ 255.0 alpha:1];
        [YesButton setTitle:@"未收到!" forState:UIControlStateNormal];
        [YesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [YesButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        YesButton.tag = 1008;
        [YesButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:YesButton];
        
        
        
        
        
        NoButton = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2 -157)/2 +SCREEN_WIDTH/2, 30, 157, 40)];
        NoButton.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251/ 255.0 alpha:1];
        [NoButton setTitle:@"到账确认无误!" forState:UIControlStateNormal];
        NoButton.tag = 1009;
        [NoButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [NoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [NoButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [footView addSubview:NoButton];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
        //label2.text = [NSString stringWithFormat:@"发薪人:%@",_dic[@"operator"]];
        label2.textColor  = COLOR_164_COLOER;
        [label2 setFont:[UIFont systemFontOfSize:14]];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label2];
    }else if ([isconfirm isEqualToString:@"1"]){
        
       label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 20)];
        label3.text = @"到账确认无误!";
        label3.textColor  = [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251/ 255.0 alpha:1];
        [label3 setFont:[UIFont systemFontOfSize:14]];
        [label3 setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:label3];
        
        UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20)];
        //label5.text = [NSString stringWithFormat:@"发薪人:%@",_dic[@"operator"]];
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
        //label6.text = [NSString stringWithFormat:@"发薪人:%@",_dic[@"operator"]];
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
      [self->listMutableArray removeAllObjects];
    [self->list removeAllObjects];
   
    
    
    NSMutableDictionary *sendDict = [NSMutableDictionary dictionary];
    [sendDict setObject:_yearString forKey:@"year"];
    [sendDict setObject:_mothString forKey:@"month"];
    [sendDict setObject:[Defaults objectForKey:@"uuid"] forKey:@"uuid"];
  
    NSLog(@"参数%@",sendDict);
    [MCHttpManager GETWithIPString:BASEURL_GZMX urlMethod:@"/payrollall" parameters:sendDict success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
       
        if ([[NSString stringWithFormat:@"%@",dicDictionary[@"code"]] isEqualToString:@"0"])
        {
            NSArray *array = dicDictionary[@"content"][@"data"];
            if ([array isKindOfClass:[NSArray class]] &&[array count]>0 )
            {
                
              
                self->_dic = dicDictionary[@"content"][@"data"][0];
                 NSLog(@"------%@",self->_dic);
                NSArray *keyArray = [self->_dic allKeys];
                NSLog(@"优质的key%@",keyArray);
                for (int i= 0; i<keyArray.count; i++) {

                    NSString *string = [NSString stringWithFormat:@"%@",[self->_dic objectForKey:keyArray[i]]];
                   
                      NSLog(@"便利的值%@",string);
                    //去除公司扣除部分
                    if (!([keyArray[i] isEqualToString:@"socialsecurity1"]||[keyArray[i] isEqualToString:@"accumulationFund1"]|| [keyArray[i] isEqualToString:@"costTotal"]||[keyArray[i] isEqualToString:@"id"]||[keyArray[i] isEqualToString:@"queueId"]||[keyArray[i] isEqualToString:@"year"]||[keyArray[i] isEqualToString:@"month"]||[keyArray[i] isEqualToString:@"aid"]||[keyArray[i] isEqualToString:@"idcard"])){
                        
                        //如果金额等于0不加入数组
                        if (!([string isEqualToString:@"0"] || kStringIsEmpty(string))) {
                            
                            //去除不是数字部分
                            if ([self isNumber:string ]) {
                             
                                 [self->listMutableArray addObject:keyArray[i]];
                            }
                            
                           
                        }
                    }
                   
                }
                NSArray *zwarray = @[@"basicWage",@"reissueBasicWage",@"buckleBasicWage",@"jobSubsidy",@"overtimePay1",@"overtimePay2",@"overtimePay3", @"rewardMonthMy",@"rewardMonthCompany",@"performance",@"reward",@"rewardPayback",@"rewardPartner",@"rewardExcitation",@"rewardPercentage",@"rewardOther1",@"rewardOther2",@"rewardOther3",@"rewardOther4",@"rewardOther5",@"rewardGroup",@"reissueReward",@"buckleReward",@"plannedIncome",@"stockExercise",@"otherIncome",@"cityRenewalBonus",@"rewardAssets",@"rewardInvestment",@"rewardBusiness",@"rewardSpecial1",@"rewardSpecial2",@"rewardSpecial3",@"rewardBalance",@"rewardFormerYear",@"highTemperature",@"housingSubsidy",@"trafficSubsidy",@"mealSubsidy",@"otherSubsidy",@"reissue",@"sumsalary",@"feastFee",@"executiveTrafficSubsidy",@"executiveByCarSubsidy",@"phoneSubsidy",@"startWorkFee",@"otherWelfare",@"buckle",@"lateEarly",@"sickLeave",@"leave",@"absence",@"entry",@"become",@"adjust",@"dimission",@"contribution",@"oherdeduction",@"insurance",@"punish",@"socialsecurity2",@"accumulationFund2",@"incomeTax",@"taxReissue",@"tax",@"salary"];
                self->list = [NSMutableArray array];
                for (int k= 0; k<zwarray.count; k++) {
                    
                    NSString *string = zwarray[k];
                
                    for (int i= 0; i<self->listMutableArray.count; i++) {
                        
                        NSString *stringkey = self->listMutableArray[i];
                        if ([stringkey isEqualToString:string]) {
                            
                            [self->list addObject:stringkey];
                        }
                        
                    }
                    
                }
                
                NSLog(@"排序前%@", self->listMutableArray);
                NSLog(@"排序后%@", self->list);
                 NSLog(@"排序后%@", self->_dic);
                
                [self->sjMoneyLabel setText:[NSString stringWithFormat:@"%.2f",[[self->_dic objectForKey:@"salary"] doubleValue]]];
                [self->listTableView reloadData];
                NSString *isconfirm = [NSString stringWithFormat:@"%@",self->_dic[@"isconfirm"]];
                [self setCzUI:isconfirm];
               
                
                
                
                
            }else{
                [STTextHudTool showErrorText:@"未到账"];
                self->_dic = [NSDictionary dictionary];
                [self->sjMoneyLabel setText:[NSString stringWithFormat:@"%@",@"0.00"]];
                [self->listTableView reloadData];
                [self setCzUI:@"-1"];
                
                
            }
            
        }else{
            
            
            self->_dic = [NSDictionary dictionary];
            [self->sjMoneyLabel setText:[NSString stringWithFormat:@"%@",@"0.00"]];
             [self->list removeAllObjects];
             [self->listTableView reloadData];
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"****%@", error);
        
        
        
        
    }];
    
}

- (BOOL)isNumber:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    
    return list.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    static NSString *indentifier = @"cell";
    MCSalaryTableViewCell *cell =   [[MCSalaryTableViewCell alloc]init];
    if (cell == nil)
    {
        cell = [[MCSalaryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
       
        
    }else{
        
       
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, 1)];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(23, 1, SCREEN_WIDTH-23, 1)];
    line2.backgroundColor = COLOR_LINE_MC;
    [XTImaginaryLine drawImaginaryLineByCAShapeLayer:line lineLength:3 lineSpacing:2 lineColor:COLOR_LINE_MC lineDirection:YES];
    NSString *keyString = [NSString stringWithFormat:@"%@",[list objectAtIndex:indexPath.row]];
    [cell.textLabel setText:[NSString stringWithFormat:@"%@",keyString]];
    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:keyString] doubleValue]]];
        [cell.moneyLabel setBackgroundColor:[UIColor clearColor]];
        if (SCREEN_WIDTH>SCREEN_HEIGHT) {
            NSLog(@"--%f--%f--",SCREEN_HEIGHT-50,SCREEN_WIDTH);
              cell.moneyLabel.frame = CGRectMake(SCREEN_WIDTH-220, 10, 200, 20);
        }else{
             NSLog(@"00000");
            cell.moneyLabel.frame = CGRectMake(SCREEN_WIDTH-220, 10, 200, 20);
        }
  
   
    if ([keyString isEqualToString:@"basicWage"]) {
        
        cell.textLabel.text = @"基本工资";
    }else if ([keyString isEqualToString:@"reissueBasicWage"]){
        cell.textLabel.text = @"补发固定月薪";
    }else if ([keyString isEqualToString:@"buckleBasicWage"]){
        cell.textLabel.text = @"补扣固定月薪";
    }else if ([keyString isEqualToString:@"jobSubsidy"]){
        cell.textLabel.text = @"岗位补贴";
    }else if ([keyString isEqualToString:@"overtimePay1"]){
        cell.textLabel.text = @"加班费（平时)";
    }else if ([keyString isEqualToString:@"overtimePay2"]){
        cell.textLabel.text = @"加班费（周末)";
    }else if ([keyString isEqualToString:@"overtimePay3"]){
        cell.textLabel.text = @"加班费（节假日)";
    }else if ([keyString isEqualToString:@"rewardMonthMy"]){
        cell.textLabel.text = @"月度个人奖金";
    }else if ([keyString isEqualToString:@"rewardMonthCompany"]){
        cell.textLabel.text = @"月度公司奖金";
    }else if ([keyString isEqualToString:@"performance"]){
        cell.textLabel.text = @"绩效";
    }else if ([keyString isEqualToString:@"reward"]){
        cell.textLabel.text = @"奖励";
    }else if ([keyString isEqualToString:@"rewardPayback"]){
        cell.textLabel.text = @"月度超额回款奖金";
    }else if ([keyString isEqualToString:@"rewardPartner"]){
        cell.textLabel.text = @"月度营销合伙人奖金";
    }else if ([keyString isEqualToString:@"rewardExcitation"]){
        cell.textLabel.text = @"月度营销考核激励奖";
    }else if ([keyString isEqualToString:@"rewardPercentage"]){
        cell.textLabel.text = @"佣金提成";
    }else if ([keyString isEqualToString:@"rewardOther1"]){
        cell.textLabel.text = @"其他奖金1";
    }else if ([keyString isEqualToString:@"rewardOther2"]){
        cell.textLabel.text = @"其他奖金2";
    }else if ([keyString isEqualToString:@"rewardOther3"]){
        cell.textLabel.text = @"其他奖金3";
    }else if ([keyString isEqualToString:@"rewardOther4"]){
        cell.textLabel.text = @"其他奖金4";
    }else if ([keyString isEqualToString:@"rewardOther5"]){
        cell.textLabel.text = @"其他奖金5";
    }else if ([keyString isEqualToString:@"rewardGroup"]){
        cell.textLabel.text = @"回款小组专项奖金";
    }else if ([keyString isEqualToString:@"reissueReward"]){
        cell.textLabel.text = @"补发奖金";
    }else if ([keyString isEqualToString:@"buckleReward"]){
        cell.textLabel.text = @"补扣奖金";
    }else if ([keyString isEqualToString:@"plannedIncome"]){
        cell.textLabel.text = @"花火计划收益";
    }else if ([keyString isEqualToString:@"stockExercise"]){
        cell.textLabel.text = @"股票行权";
    }else if ([keyString isEqualToString:@"otherIncome"]){
        cell.textLabel.text = @"其他合并计税收益";
    }else if ([keyString isEqualToString:@"cityRenewalBonus"]){
        cell.textLabel.text = @"城市更新奖金";
    }else if ([keyString isEqualToString:@"rewardAssets"]){
        cell.textLabel.text = @"轻资产业务专项奖金";
    }else if ([keyString isEqualToString:@"rewardInvestment"]){
        cell.textLabel.text = @"投资拓展奖金";
    }else if ([keyString isEqualToString:@"rewardBusiness"]){
        cell.textLabel.text = @"非地产经营单位奖金";
    }else if ([keyString isEqualToString:@"rewardSpecial1"]){
        cell.textLabel.text = @"其他专项奖金1";
    }else if ([keyString isEqualToString:@"rewardSpecial2"]){
        cell.textLabel.text = @"其他专项奖金2";
    }else if ([keyString isEqualToString:@"rewardSpecial3"]){
        cell.textLabel.text = @"其他专项奖金3";
    }else if ([keyString isEqualToString:@"rewardBalance"]){
        cell.textLabel.text = @"营销费用结余奖";
    }else if ([keyString isEqualToString:@"rewardFormerYear"]){
        cell.textLabel.text = @"其他往年奖金";
    }else if ([keyString isEqualToString:@"highTemperature"]){
        cell.textLabel.text = @"高温补贴";
    }else if ([keyString isEqualToString:@"housingSubsidy"]){
        cell.textLabel.text = @"住房补贴";
    }else if ([keyString isEqualToString:@"trafficSubsidy"]){
        cell.textLabel.text = @"交通补贴";
    }else if ([keyString isEqualToString:@"mealSubsidy"]){
        cell.textLabel.text = @"伙食补贴";
    }else if ([keyString isEqualToString:@"otherSubsidy"]){
        cell.textLabel.text = @"其他补贴";
    }else if ([keyString isEqualToString:@"reissue"]){
        cell.textLabel.text = @"补发";
    }else if ([keyString isEqualToString:@"buckle"]){
        cell.textLabel.text = @"补扣";
    }else if ([keyString isEqualToString:@"lateEarly"]){
        cell.textLabel.text = @"迟到/早退";
    }else if ([keyString isEqualToString:@"sickLeave"]){
        cell.textLabel.text = @"病假扣款";
    }else if ([keyString isEqualToString:@"leave"]){
        cell.textLabel.text = @"事假扣款";
    }else if ([keyString isEqualToString:@"absence"]){
        cell.textLabel.text = @"缺勤扣款";
    }else if ([keyString isEqualToString:@"entry"]){
        cell.textLabel.text = @"新入职扣款";
    }else if ([keyString isEqualToString:@"become"]){
        cell.textLabel.text = @"转正扣款";
    }else if ([keyString isEqualToString:@"adjust"]){
        cell.textLabel.text = @"晋升/薪酬调整扣款（晋升前差额";
    }else if ([keyString isEqualToString:@"dimission"]){
        cell.textLabel.text = @"离职扣款";
    }else if ([keyString isEqualToString:@"contribution"]){
        cell.textLabel.text = @"爱心互助扣款";
    }else if ([keyString isEqualToString:@"oherdeduction"]){
        cell.textLabel.text = @"其他扣费";
    }else if ([keyString isEqualToString:@"insurance"]){
        cell.textLabel.text = @"扣保险费";
    }else if ([keyString isEqualToString:@"punish"]){
        cell.textLabel.text = @"责任处罚";
    }else if ([keyString isEqualToString:@"sumsalary"]){
        cell.textLabel.text = @"应发合计";
    }else if ([keyString isEqualToString:@"socialsecurity2"]){
        cell.textLabel.text = @"社保(个人承担部分)";
    }else if ([keyString isEqualToString:@"accumulationFund2"]){
        cell.textLabel.text = @"公积金（个人承担部分";
    }else if ([keyString isEqualToString:@"incomeTax"]){
        cell.textLabel.text = @"个人所得税扣除标准";
    }else if ([keyString isEqualToString:@"valorem"]){
        cell.textLabel.text = @"合并计税项目";
    }else if ([keyString isEqualToString:@"znjy"]){
        cell.textLabel.text = @"子女教育扣除项";
    }else if ([keyString isEqualToString:@"zfdk"]){
        cell.textLabel.text = @"住房贷款利息扣除项";
    }else if ([keyString isEqualToString:@"zfzj"]){
        cell.textLabel.text = @"租房租金扣除项";
    }else if ([keyString isEqualToString:@"sylr"]){
        cell.textLabel.text = @"赡养老人扣除项";
    }else if ([keyString isEqualToString:@"jxjy"]){
        cell.textLabel.text = @"继续教育扣除项";
    }else if ([keyString isEqualToString:@"otherItem"]){
        cell.textLabel.text = @"允许税前扣除的其他费用";
    }else if ([keyString isEqualToString:@"taxable"]){
        cell.textLabel.text = @"应纳税所得额";
    }else if ([keyString isEqualToString:@"taxrate"]){
        cell.textLabel.text = @"税率";
    }else if ([keyString isEqualToString:@"quickNumber"]){
        cell.textLabel.text = @"速算扣除数";
    }else if ([keyString isEqualToString:@"taxDeduction"]){
        cell.textLabel.text = @"税后扣除";
    }else if ([keyString isEqualToString:@"taxReissue"]){
        cell.textLabel.text = @"税后发放";
    }else if ([keyString isEqualToString:@"tax"]){
        cell.textLabel.text = @"扣税";
    }else if ([keyString isEqualToString:@"salary"]){
        cell.textLabel.text = @"实发合计";
    }else if ([keyString isEqualToString:@"feastFee"]){
        cell.textLabel.text = @"过节费";
    }else if ([keyString isEqualToString:@"executiveTrafficSubsidy"]){
        cell.textLabel.text = @"高管交通补贴";
    }else if ([keyString isEqualToString:@"executiveByCarSubsidy"]){
        cell.textLabel.text = @"高管购车补贴";
    }else if ([keyString isEqualToString:@"phoneSubsidy"]){
        cell.textLabel.text = @"通讯补贴";
    }else if ([keyString isEqualToString:@"startWorkFee"]){
        cell.textLabel.text = @"开工利是";
    }else if ([keyString isEqualToString:@"otherWelfare"]){
        cell.textLabel.text = @"税其他福利补贴发放";
    }
    }
//    switch (indexPath.section) {
//        case 0:
//        {
//            switch (indexPath.row) {
//
//                case 0:{
//
//                    cell.titleLabel.text = @"基本工资";
//
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"basicWage"] doubleValue]]];
//                }
//                    break;
//                case 1:{
//
//                    cell.titleLabel.text = @"岗位补贴";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"jobSubsidy"] doubleValue]]];
//                }
//                    break;
//                case 2:{
//
//                    cell.titleLabel.text = @"加班费（平时）";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"overtimePay1"] doubleValue]]];
//                }
//                    break;
//                case 3:{
//
//                    cell.titleLabel.text = @"加班费（周末）";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"overtimePay2"] doubleValue]]];
//                }
//                    break;
//                case 4:{
//
//                    cell.titleLabel.text = @"加班费（节假日）";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"overtimePay3"] doubleValue]]];
//                }
//                    break;
//                case 5:{
//
//                    cell.titleLabel.text = @"绩效";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"performance"] doubleValue]]];
//                }
//                    break;
//                case 6:{
//
//                    cell.titleLabel.text = @"奖励";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"reward"] doubleValue]]];
//                }
//                    break;
//                case 7:{
//
//                    cell.titleLabel.text = @"高温补贴";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"highTemperature"] doubleValue]]];
//                }
//                    break;
//                case 8:{
//
//                    cell.titleLabel.text = @"其他补贴";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"otherSubsidy"] doubleValue]]];
//                }
//                    break;
//                case 9:{
//
//                    cell.titleLabel.text = @"补发";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"leave"] doubleValue]]];
//                }
//                    break;
//                case 10:{
//
//                    cell.titleLabel.text = @"应发合计";
//
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"sumsalary"] doubleValue]]];
//                }
//                    break;
//
//                default:
//                    break;
//            }
//        }
//            break;
//        case 2:
//        {
//            switch (indexPath.row) {
//                case 0:
//                {
//
//                    [cell addSubview:line2];
//                    cell.titleLabel.text = @"实发";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"salary"] doubleValue]]];
//
//                }
//                    break;
//
//                default:
//                    break;
//            }
//        }
//            break;
//        case 1:
//        {
//            cell.moneyLabel.textColor = [UIColor colorWithRed:229 / 255.0 green:62 / 255.0 blue:42/ 255.0 alpha:1];
//            switch (indexPath.row) {
//                case 0:
//                {
//
//                    [cell addSubview:line2];
//                    cell.titleLabel.text = @"事假扣款";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"reissue"] doubleValue]]];
//
//                }
//                    break;
//
//                case 1:
//                {
//
//
//                    cell.titleLabel.text = @"迟到/早退";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"lateEarly"] doubleValue]]];
//
//                }
//                    break;
//                case 2:
//                {
//
//
//                    cell.titleLabel.text = @"病假扣款";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"sickLeave"] doubleValue]]];
//
//                }
//                    break;
//                case 3:
//                {
//
//
//                    cell.titleLabel.text = @"缺勤扣款";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"absence"] doubleValue]]];
//
//                }
//                    break;
//                case 4:
//                {
//
//
//                    cell.titleLabel.text = @"爱心互助扣款";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"contribution"] doubleValue]]];
//
//                }
//                    break;
//                case 5:
//                {
//
//
//                    cell.titleLabel.text = @"其他扣费";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"oherdeduction"] doubleValue]]];
//
//                }
//                    break;
//                case 6:
//                {
//
//
//                    cell.titleLabel.text = @"扣保险费";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"insurance"] doubleValue]]];
//
//                }
//                    break;
//                case 7:
//                {
//
//
//                    cell.titleLabel.text = @"责任处罚";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"punish"] doubleValue]]];
//
//                }
//                    break;
//                case 8:
//                {
//
//
//                    cell.titleLabel.text = @"社保(个人承担部分)";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"socialsecurity2"] doubleValue]]];
//
//                }
//                    break;
//                case 9:
//                {
//
//
//                    cell.titleLabel.text = @"个人所得税扣除";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"incomeTax"] doubleValue]]];
//
//                }
//                    break;
//                case 10:
//                {
//
//
//                    cell.titleLabel.text = @"子女教育扣除项";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"znjy"] doubleValue]]];
//
//                }
//                    break;
//                case 11:
//                {
//
//
//                    cell.titleLabel.text = @"住房贷款利息扣除项";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"zfdk"] doubleValue]]];
//
//                }
//                    break;
//                case 12:
//                {
//
//
//                    cell.titleLabel.text = @"租房租金扣除项";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"zfzj"] doubleValue]]];
//
//                }
//                    break;
//                case 13:
//                {
//
//
//                    cell.titleLabel.text = @"赡养老人扣除项";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"sylr"] doubleValue]]];
//
//                }
//                    break;
//                case 14:
//                {
//
//
//                    cell.titleLabel.text = @"继续教育扣除项";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"jxjy"] doubleValue]]];
//
//                }
//                    break;
//                case 15:
//                {
//
//
//                    cell.titleLabel.text = @"扣税";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"tax"] doubleValue]]];
//
//                }
//                    break;
//                case 16:
//                {
//
//
//                    cell.titleLabel.text = @"补扣";
//                    [cell.moneyLabel setText:[NSString stringWithFormat:@"%.2f",[[_dic objectForKey:@"buckle"] doubleValue]]];
//
//                }
//                    break;
//
//
//                default:
//                    break;
//            }
//        }
//            break;
//
//        default:
//            break;
//    }
   
    
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
