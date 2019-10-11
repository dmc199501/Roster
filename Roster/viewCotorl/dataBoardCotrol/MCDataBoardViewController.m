//
//  MCDataBoardViewController.m
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//
#define SELF_WIDTH self.bounds.size.width

#define kBtn_Num 6  // 一页显示的button数
#define kBtn_Margin 20  // button 的间距
#define kBtn_Width ((SELF_WIDTH - 20 - kBtn_Margin * (kBtn_Num - 1)) / kBtn_Num)
#import "MCDataBoardViewController.h"
#import "AppDelegate.h"
#import "QFDatePickerView.h"
#import "XBase64WithString.h"
#import "LeftSortsViewController.h"
#import "MenuView.h"
#import "LeftMenuViewDemo.h"
@interface MCDataBoardViewController ()<UIWebViewDelegate,HomeMenuViewDelegate>
@property(nonatomic,strong)UIScrollView *class1ScrollView;
@property (nonatomic, strong) UIButton *class1SelectedButton;
@property(nonatomic,assign)NSInteger years;
@property(nonatomic,strong)UILabel *kfLabel;
@property(nonatomic,strong)NSString *urlStirng;
@property(nonatomic,strong)NSString *table;
@property(nonatomic,strong)NSString *jgName;
@property(nonatomic,strong)NSString *orgUuid;
@property(nonatomic,strong)NSString *year;
@property(nonatomic,strong)NSString *moth;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *orgName;
@property(nonatomic,strong)NSString *outhTonken;
@property (nonatomic ,strong)MenuView   * menu;
@property(nonatomic,assign)int page;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

@end
@implementation MCDataBoardViewController
- (id)init
{
    self = [super init];
    if (self)
    {
     
        mothArray = @[@"01月", @"02月", @"03月", @"04月", @"05月", @"06月", @"07月", @"08月", @"09月", @"10月", @"11月" ,@"12月"];
       
        
        
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 屏幕旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    _page = 0;
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
  
    LeftMenuViewDemo *demo = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.7, [[UIScreen mainScreen] bounds].size.height)];
    demo.customDelegate = self;
    
    self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:demo isShowCoverView:YES];

    //[self getOuth];
    self.view.tag = 999999;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"infoNotification" object:nil];
    
    
   

    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0, 0, 80, 29);
    [button setImage :[UIImage imageNamed:@"看板-更多"] forState:UIControlStateNormal];
    [button setTitle:@"类目" forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button addTarget:self action:@selector(screening) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton *button1 = [[UIButton alloc]init];
    button1.frame = CGRectMake(0, 0, 60, 21);
    [button1 setImage:[UIImage imageNamed:@"看板-向左滑"] forState:UIControlStateNormal];
    button1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button1 setTitle:@"架构" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(LeftMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button1];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"看板-更多"] style:UIBarButtonItemStylePlain target:self action:@selector(screening)];
   //  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"看板-向左滑"] style:UIBarButtonItemStylePlain target:self action:@selector(screening)];
    //[self.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1]];
   
//   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"看板-更多"] style:UIBarButtonItemStylePlain target:self action:@selector(screening)];
    
    _orgName = @"全集团";
    [self setUI];

   

    
   
    // Do any additional setup after loading the view.
}

//切屏重新设置frame
- (void)deviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
  
    
    [self.menu hidenWithAnimation];
    
    LeftMenuViewDemo *demo = [[LeftMenuViewDemo alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 0.7, [[UIScreen mainScreen] bounds].size.height)];
    demo.customDelegate = self;
    
    self.menu = [[MenuView alloc]initWithDependencyView:self.view MenuView:demo isShowCoverView:YES];
    float heights = getRectNavAndStatusHight+getTabBarHight;
    float heightt = SCREEN_HEIGHT -heights;
    _kfLabel.frame =CGRectMake((SCREEN_WIDTH-250)/2, 11, 250, 20);
    yearsButoon.frame =CGRectMake(10, BOTTOM_Y(_kfLabel)+3, 70, 20);
     monthButoon.frame =CGRectMake(80, BOTTOM_Y(_kfLabel)+3, 50, 20);
    lineV.frame = CGRectMake(130, BOTTOM_Y(_kfLabel)+3, 0.5, 20);
    self.class1ScrollView.frame = CGRectMake(140, BOTTOM_Y(_kfLabel)+3, 100, 20);
    webbackView.frame =CGRectMake((SCREEN_WIDTH-200)/2, BOTTOM_Y(_kfLabel)+60+150, 200, 100);
    formButoon.frame = CGRectMake(SCREEN_WIDTH-80, BOTTOM_Y(_kfLabel)+3, 60, 21);
     web.frame = CGRectMake(0, BOTTOM_Y(_kfLabel)+40, SCREEN_WIDTH,heightt-BOTTOM_Y(_kfLabel)-40);
    barButoon.frame= CGRectMake(SCREEN_WIDTH-120, BOTTOM_Y(_kfLabel)+3, 60, 21);
  
    
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender

{
    
    
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        
      
        if (_page == 4) {
            [STTextHudTool showErrorText:@"已经是最后一项" withSecond:1];
        }else{
            
            _page +=1;
            [self changgeURLTag:_page];
        }
        
        //添加要响应的方法
       
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
       
        if (_page == 0) {
            
            [STTextHudTool showErrorText:@"这是第一项" withSecond:1];
        }else{
            
            _page -=1;
            [self changgeURLTag:_page];
        }
        //添加要响应的方法
        
    }
    
}

-(void)zyChanggeURL:(UIButton *)button{
    
    if (button.tag == 889) {
        
        
        if (_page == 4) {
            [STTextHudTool showErrorText:@"已经是最后一项" withSecond:1];
        }else{
            
            _page +=1;
            [self changgeURLTag:_page];
        }
        
        //添加要响应的方法
        
    }else{
        
        if (_page == 0) {
            
            [STTextHudTool showErrorText:@"这是第一项" withSecond:1];
        }else{
            
            _page -=1;
            [self changgeURLTag:_page];
        }
        //添加要响应的方法
        
    }
}
#pragma -mark切换url
-(void)changgeURLTag:(int)tag{
    
   
    
   
   
    switch (tag) {
        case 0:
        {
            self.kfLabel.text =[NSString stringWithFormat:@"%@%@报表",_orgName,@"人员数量"] ;
            [self.navigationController.navigationBar addSubview: self.kfLabel];
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rysltab";
            }else{
                
                self->_jgName = @"ryslzxt";
            }
            
            [self loadWebURl];
        }
            break;
        case 1:
        {
            self.kfLabel.text =[NSString stringWithFormat:@"%@%@报表",_orgName,@"入离职"] ;
            [self.navigationController.navigationBar addSubview: self.kfLabel];
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rlztab";
            }else{
                
                self->_jgName = @"rlzzxt";
            }
            
            [self loadWebURl];
        }
            break;
            
            break; case 2:
        {
            self.kfLabel.text =[NSString stringWithFormat:@"%@%@报表",_orgName,@"人力成本"] ;
            [self.navigationController.navigationBar addSubview: self.kfLabel];
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rlcbtab";
            }else{
                
                self->_jgName = @"rlcbbt";
            }
            
            [self loadWebURl];
        }
            break; case 3:
        {
            self.kfLabel.text =[NSString stringWithFormat:@"%@%@报表",_orgName,@"人力效能"] ;
            [self.navigationController.navigationBar addSubview: self.kfLabel];
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rlxntab";
            }else{
                
                self->_jgName = @"rlxnzxt";
            }
            
            [self loadWebURl];
        }
            break; case 4:
        {
            self.kfLabel.text =[NSString stringWithFormat:@"%@%@报表",_orgName,@"经营数据"] ;
            [self.navigationController.navigationBar addSubview: self.kfLabel];
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"jysjtab";
            }else{
                
                self->_jgName = @"jysjzxt";
            }
            
            [self loadWebURl];
        }
            
            break;
            
        default:
            break;
    }
    
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
   
    [webbackView removeFromSuperview];
    
}

-(void)setUI{
    
    [_kfLabel removeFromSuperview];
    _kfLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-250)/2, 11, 250, 20)];
    _kfLabel.text = @"全集团人员数量报表";
    _kfLabel.font = [UIFont systemFontOfSize:18];
    _kfLabel.textColor = [UIColor blackColor];
    _kfLabel.textAlignment = NSTextAlignmentCenter;
   // [self.view addSubview:_kfLabel];
    [self.navigationController.navigationBar addSubview:_kfLabel];
    
    //sxArray =@[@"人员编制",@"人力成本",@"人力效能(营收)",@"人力效能(利润)",@"成本结构",@"职级结构",@"学历结构",@"年龄结构",@"司龄结构",@"工龄结构",@"收入结构",@"薪酬变动",@"职级变动",@"入离职"];
    sxArray =@[@"人员数量",@"入离职",@"人力成本",@"人力效能",@"经营数据"];
    
    
    view = [[kpengHorizontalView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-60, 40) andTitle:sxArray];
    __weak __typeof(self) weakSelf = self;
    
    //[self.navigationController.navigationBar addSubview:view];
    view.itemClickCallBack = ^(NSInteger itemIndex, NSString *title,float buttonx) {
       // NSLog(@"%ld---%@",itemIndex,title);
        weakSelf.kfLabel.text = [NSString stringWithFormat:@"%@%@报表",weakSelf.orgName,title];
        switch (itemIndex) {
            case 0:
                {
                    self->_jgName = @"rybz";
                    [weakSelf loadWebURl];
                }
                break;
            case 1:
            {
                self->_jgName = @"rlcb";
                [weakSelf loadWebURl];
            }
                break;
           
                case 2:
            {
               self->_jgName = @"rlxnys";
                [weakSelf loadWebURl];
            }
            case 3:
            {
                self->_jgName = @"rlxnlr";
                [weakSelf loadWebURl];
            }
                break; case 4:
            {
                self->_jgName = @"cbjg";
                [weakSelf loadWebURl];
            }
                break; case 5:
            {
                self->_jgName = @"zjjg";
                [weakSelf loadWebURl];
            }
                break; case 6:
            {
                self->_jgName = @"xljg";
                [weakSelf loadWebURl];
            }
                break; case 7:
            {
               self->_jgName = @"nljg";
                [weakSelf loadWebURl];
            }
                break; case 8:
            {
                self->_jgName = @"sljg";
                [weakSelf loadWebURl];
            }
                break; case 9:
            {
                self->_jgName = @"gljg";
                [weakSelf loadWebURl];
            }
                break; case 10:
            {
                self->_jgName = @"srjg-month";
                [weakSelf loadWebURl];
            }
            
                break; case 11:
            {
                self->_jgName = @"xcbd";
                [weakSelf loadWebURl];
            }
                break; case 12:
            {
                self->_jgName = @"zjbd";
                [weakSelf loadWebURl];
            }
                break;
                break; case 13:
            {
                self->_jgName = @"rlz";
                [weakSelf loadWebURl];
            }
                break;
                
           
                
            default:
                break;
        }
        CGPoint offset = self->view.contentOffset;
        if (itemIndex>1 && itemIndex< self->sxArray.count-1) {
            offset.x = buttonx-(SCREEN_WIDTH-60)/4;
        }else if(itemIndex == 1){
            offset.x = buttonx-(SCREEN_WIDTH-60)/4;
            
            
        }
        
        [UIView animateWithDuration:0.6 animations:^{
            self->view.contentOffset = offset;
            
        }];
        
    };
    
    
    view.localIndex = 0;//默认第0个
    
    
    //标题下方布局
    //(1).左侧菜单栏按钮
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, BOTTOM_Y(_kfLabel)+5, 40, 15)];
    //[self.view addSubview:button];
    button.tag = 9999999999;
    button.backgroundColor = [UIColor clearColor];
   // [button setBackgroundImage:[UIImage imageNamed:@"看板-向左滑"] forState:UIControlStateNormal];
    [button setTitle:@"架构" forState:UIControlStateNormal];
    [button setTitleColor:COLOR_56_COLOER forState:UIControlStateNormal];
    [button addTarget:self action:@selector(LeftMenu) forControlEvents:UIControlEventTouchUpInside];
    
    //(2)年选择button
    
    NSDate *newDate = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:newDate];
    
    NSInteger year = [dateComponent year];
    
    NSInteger month1 = [dateComponent month] ;
    NSInteger month = 0;
    if (month1==1) {
        month = 12;
    }else{
        
    month = month1 -1;
    }
   
    yearsButoon = [[UIButton alloc]initWithFrame:CGRectMake(10, BOTTOM_Y(_kfLabel)+3, 70, 20)];
    [yearsButoon setTitle:[NSString stringWithFormat:@"%ld年",year] forState:UIControlStateNormal];
    [self.view addSubview:yearsButoon];
    //[yearsButoon setBackgroundColor:[UIColor yellowColor]];
    [yearsButoon.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [yearsButoon setTitleColor:COLOR_56_COLOER forState:UIControlStateNormal];
    yearsButoon.tag = 2999;
    [yearsButoon addTarget:self action:@selector(changgeYears:) forControlEvents:UIControlEventTouchUpInside];
    
    monthButoon = [[UIButton alloc]initWithFrame:CGRectMake(80, BOTTOM_Y(_kfLabel)+3, 50, 20)];
    [monthButoon setTitle:[NSString stringWithFormat:@"%ld月",month] forState:UIControlStateNormal];
    [self.view addSubview:monthButoon];
    [monthButoon.titleLabel setTextAlignment:NSTextAlignmentLeft];
    //[monthButoon setBackgroundColor:[UIColor redColor]];
    monthButoon.tag = 2998;
    [monthButoon setTitleColor:COLOR_56_COLOER forState:UIControlStateNormal];
    [monthButoon addTarget:self action:@selector(changgeMoth:) forControlEvents:UIControlEventTouchUpInside];
    
    lineV = [[UIView alloc]initWithFrame:CGRectMake(130, BOTTOM_Y(_kfLabel)+3, 0.5, 20)];
    [self.view addSubview:lineV];
    lineV.backgroundColor = [UIColor colorWithRed:120 / 255.0 green:120 / 255.0 blue:120 / 255.0 alpha:1];
    
    //（3）当月累计按钮布局
    
    self.class1ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(140, BOTTOM_Y(_kfLabel)+3, 100, 20)];
    self.class1ScrollView.backgroundColor = [UIColor clearColor];
    self.class1ScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview: self.class1ScrollView];
    [self createButtonWithArray];
    
    //(4)表格 条形图切换布局
    formButoon = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-80, BOTTOM_Y(_kfLabel)+3, 60, 21)];
    [self.view addSubview:formButoon];
    

    formButoon.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [formButoon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [formButoon.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [formButoon setTitle:@"表" forState:UIControlStateNormal];
    [formButoon setImage:[UIImage imageNamed:@"看板-表"] forState:UIControlStateNormal];
    [formButoon setTitleColor:COLOR_56_COLOER forState:UIControlStateNormal];
    
    [formButoon addTarget:self action:@selector(qhBar:) forControlEvents:UIControlEventTouchUpInside];
    formButoon.tag = 1999;
    
    barButoon = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120, BOTTOM_Y(_kfLabel)+3, 60, 21)];
    barButoon.tag = 1998;
    barButoon.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [barButoon setTitle:@"图" forState:UIControlStateNormal];
     barButoon.titleLabel.font  = [UIFont systemFontOfSize: 16.0];
    [barButoon setTitleColor:[UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1] forState:UIControlStateNormal];
    [self.view addSubview:barButoon];
    [barButoon setImage:[UIImage imageNamed:@"看板-图-active"] forState:UIControlStateNormal];
    [barButoon addTarget:self action:@selector(qhBar:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _table = @"kpiGraph";
    _jgName = @"ryslzxt";
    _orgUuid = @"";
    _year = [NSString stringWithFormat:@"%ld",(long)year];
    _moth = [NSString stringWithFormat:@"%ld",(long)month];
    _type = @"0";

    _urlStirng = [NSString stringWithFormat:@"http://139.9.32.247:40091/#/%@/%@?orguuid=%@&year=%@&month=%@&type=%@",_table,_jgName,_orgUuid,_year,_moth,_type];
    
    NSLog(@"%@",_urlStirng);
    
   // NSString *urlString = @"http://192.168.2.175:8080/#/kpiGraph/rybz?year=2018&month=1&type=0";
    // 在 url 中,不能出现汉字,只能是 ASCII 吗! 如果 url 中出现了 汉字等特殊符号,必须使用百分号转译!
    //    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet letterCharacterSet]];
    NSURL *url = [NSURL URLWithString:_urlStirng];
    
    // 可变的网络请求!
    // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // cachePolicy: 网络缓存策略:枚举常量
    // timeoutInterval: 请求超时时间! 默认情况下,最大的请求超时时间是 1分钟! 在开发中,一般设 15S
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:10];
   
    float heights = getRectNavAndStatusHight+getTabBarHight;
    float heightt = SCREEN_HEIGHT -heights;
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, BOTTOM_Y(_kfLabel)+40, SCREEN_WIDTH,heightt-BOTTOM_Y(_kfLabel)-40)];
    [web loadRequest:request];
    web.delegate = self;
    web.backgroundColor = [UIColor clearColor];
    web.opaque = NO;
    [self.view addSubview:web];
    
    
    webbackView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, BOTTOM_Y(_kfLabel)+60+150, 200, 100)];
    [self.view addSubview:webbackView];
    
    
    UIButton *zButton = [[UIButton alloc]initWithFrame:CGRectMake(0, BOTTOM_Y(_kfLabel)+60+150, 50, 200)];
    [self.view addSubview:zButton];
    [zButton setImage:[UIImage imageNamed:@"left-circle-fill"] forState:UIControlStateNormal];
    zButton.tag = 888;
    [zButton addTarget:self action:@selector(zyChanggeURL:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *yButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, BOTTOM_Y(_kfLabel)+60+150, 50, 200)];
    [self.view addSubview:yButton];
    [yButton setImage:[UIImage imageNamed:@"right-circle-fill"] forState:UIControlStateNormal];
    yButton.tag = 889;
    [yButton addTarget:self action:@selector(zyChanggeURL:) forControlEvents:UIControlEventTouchUpInside];
    
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(70, 10, 45, 45)];
    [webbackView addSubview:backImageView];
    [backImageView setImage:[UIImage imageNamed:@"组 94.png"]];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 200, 20)];
    titleLabel.text = @"数据正在载入中...";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = COLOR_164_COLOER;
    [webbackView addSubview:titleLabel];
    
}
#pragma -mark授权请求
-(void)getOuth{
    
    
    NSMutableDictionary *sendDict  = [NSMutableDictionary dictionary];
    NSString *outhString = @"5c0f6d86dfcab93ea4647926:0851b6b0f79911e89ed4d55d20b6473d";
    //请求头参数公式 Basic+空格+outhString(base64加密)
    NSString *Authorization = [NSString stringWithFormat:@"Basic %@",[XBase64WithString base64StringFromText:outhString]];
    
    
    [sendDict setObject:REFRESH_TOKEN  forKey:@"refresh_token"];
    [sendDict setObject:@"refreshtoken" forKey:@"grant_type"];
    
    //http://192.168.2.168:6001
    [MCHttpManager PostOuthWithIPString:BASEURL_OUTH urlMethod:@"/oauth2/token" parameters:sendDict outhWithString:Authorization success:^(id responseObject) {
        
        NSDictionary *dicDictionary = responseObject;
        if ([dicDictionary isKindOfClass:[dicDictionary class]]) {
            
            
           self.outhTonken = [NSString stringWithFormat:@"%@",dicDictionary[@"access_token"]];
            
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
            
            [self loadWebURl];
            
            
        }else{
            
            
            [STTextHudTool showErrorText:@"授权失败" withSecond:2];
            
        }
        
        
       
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"%@",error);
        
    }];
    
    
    
}
#pragma -mark左侧菜单栏弹起点击事件
-(void)LeftMenu{
  [self.menu show];
//    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//
//
//    if (tempAppDelegate.LeftSlideVC.closed)
//    {
//        NSLog(@"来了老底");
//        [tempAppDelegate.LeftSlideVC openLeftView];
//    }
//    else
//    {
//
//
//        [tempAppDelegate.LeftSlideVC closeLeftView];
//    }
//
}

#pragma mark-关闭抽屉
-(void)LeftMenuViewClick:(NSInteger)tag{
    
    [self.menu hidenWithAnimation];
    
}
#pragma -mark刷新URl
-(void)loadWebURl{
    
    
    self.urlStirng = [NSString stringWithFormat:@"http://139.9.32.247:40091/#/%@/%@?orguuid=%@&year=%@&month=%@&type=%@",self.table,self.jgName,_orgUuid,self.year,self.moth,self.type];
     NSLog(@"---%@", self.urlStirng);
    if ([self.urlStirng containsString:@"月"]) {
        
        NSString *str2 = [self.urlStirng stringByReplacingOccurrencesOfString:@"月" withString:@""];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str2] cachePolicy:0 timeoutInterval:15];
        //[request addValue:@"head" forHTTPHeaderField:@"key"];
         [self->web loadRequest:request];
        NSLog(@"---%@",str2);
    }else{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlStirng] cachePolicy:0 timeoutInterval:15];
        //[request addValue:@"head" forHTTPHeaderField:@"key"];
        [self->web loadRequest:request];
        
        
        
    }
    
   
    
    
}

#pragma -mark年按钮点击事件
-(void)changgeYears:(UIButton *)button{
    QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initYearPickerWithView:self.view response:^(NSString *str) {
        NSString *string = str;
        
        [self->yearsButoon setTitle:[NSString stringWithFormat:@"%@年",string] forState:UIControlStateNormal];
         self.year = string;
        [self loadWebURl];
        
    }];
    
    [datePickerView show];
}


   
#pragma -mark月按钮点击事件
-(void)changgeMoth:(UIButton *)button{
   
    MCPickerView *pickerView = [[MCPickerView alloc]initWithFrame:self.view.bounds];
    pickerView.delegate = self;
    [pickerView showInView:[UIApplication sharedApplication].keyWindow animation:YES];
    [pickerView.choosePickerView  selectRow:[_moth intValue] inComponent:0 animated:YES];
}
#pragma -mark图表和柱状图切换
-(void)qhBar:(UIButton *)button{
    
    if (button.tag == 1999) {
     
        
        [formButoon setImage:[UIImage imageNamed:@"看板-表-active"] forState:UIControlStateNormal];
        [barButoon setImage:[UIImage imageNamed:@"看板-图"] forState:UIControlStateNormal];
        [formButoon setTitleColor:[UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1] forState:UIControlStateNormal];
        [barButoon setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
        
        self.table = @"kpiTable";
        if ([self.jgName containsString:@"zxt"]) {
            
            NSString *strUrl = [self.jgName stringByReplacingOccurrencesOfString:@"zxt" withString:@"tab"];
            self.jgName = strUrl;
        }else{
           
            NSString *strUrl = [self.jgName stringByReplacingOccurrencesOfString:@"bt" withString:@"tab"];
            self.jgName = strUrl;
        }
       
        [self loadWebURl];
    }else{
        [formButoon setImage:[UIImage imageNamed:@"看板-表"] forState:UIControlStateNormal];
        [barButoon setImage:[UIImage imageNamed:@"看板-图-active"] forState:UIControlStateNormal];
        [barButoon setTitleColor:[UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1] forState:UIControlStateNormal];
        [formButoon setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forState:UIControlStateNormal];
        
        self.table = @"kpiGraph";
        if ([self.jgName containsString:@"tab"]) {
            if ([self.jgName isEqualToString:@"rlcbtab"]) {
                NSString *strUrl = [self.jgName stringByReplacingOccurrencesOfString:@"tab" withString:@"bt"];
                self.jgName = strUrl;
            }else{
                NSString *strUrl = [self.jgName stringByReplacingOccurrencesOfString:@"tab" withString:@"zxt"];
                self.jgName = strUrl;
            }
          
        }else{
            
           
        }
        
        [self loadWebURl];
       
    }
    
}

#pragma -mark左菜单点击传值
-(void)receiveNotification:(NSNotification *)infoNotification {
    
    NSDictionary *dic = [infoNotification userInfo];
    NSString *nameStr = [dic objectForKey:@"orginfo"][@"name"];
    NSString *uuidStr = [dic objectForKey:@"orginfo"][@"orguuid"];
   
   
    NSString *titleString=[_kfLabel.text stringByReplacingOccurrencesOfString:_orgName withString:[NSString stringWithFormat:@"%@",nameStr]];
    _orgName = [NSString stringWithFormat:@"%@",nameStr];
    _orgUuid = [NSString stringWithFormat:@"%@",uuidStr];
    _kfLabel.text =[NSString stringWithFormat:@"%@",titleString];
    [self.navigationController.navigationBar addSubview:_kfLabel];
    [self loadWebURl];
    
}


#pragma -mark移除监听
- (void)didReceiveMemoryWarning {
  
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIWebViewDelegate

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error

{
    
   // [STTextHudTool showErrorText:@"加载超时！！" withSecond:2];
    
}
#pragma -mark设置导航栏按钮
- (void)createButtonWithArray{
    
    NSArray *array = @[@"当月",@"累计"];
    
    float buttonW =  50 ;
    
    for (int i = 0; i < array.count; i ++)
    {
        buttonss = [UIButton buttonWithType:UIButtonTypeCustom];
        
        buttonss.frame = CGRectMake(i*buttonW, 0, buttonW, 20);
        // NSDictionary * dict = (NSDictionary *)[array objectAtIndex:i] ;
        
        
        [buttonss setTitle:array[i]  forState:    UIControlStateNormal];
        [buttonss setTitleColor:COLOR_56_COLOER forState:UIControlStateNormal];
        [buttonss setTitleColor:[UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1] forState:UIControlStateSelected];
        buttonss.titleLabel.font  = [UIFont systemFontOfSize: 16.0];
        
        [buttonss addTarget:self action:@selector(classbuttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        buttonss.tag = 1000 + i;
        
        
        // button.backgroundColor = RED_COLOR_ZZ;
        [_class1ScrollView addSubview:buttonss];
        
        if (i == 0)
        {
            [self classbuttonClicked:buttonss];
        }
    
        
       
    }
    
    
    
}

#pragma -mark切换当月还是累计
- (void)classbuttonClicked:(UIButton *)button{
    
    
    _class1SelectedButton.selected = NO; //先取消上一个按钮的选择状态
    button.selected = YES;
    _class1SelectedButton = button;
    self.type = [NSString stringWithFormat:@"%ld",button.tag-1000];
    [self loadWebURl];
    
   
    
    
}
#pragma -mark右上角更多选择弹出框
-(void)screening{
    
    if ( self.navigationItem.rightBarButtonItem.tag == 0) {
        
        
        self.navigationItem.rightBarButtonItem.tag = 1;
       
        if (sxArray.count>0) {
            [self setSxUI];
        }else{
            [SVProgressHUD showErrorWithStatus:@"暂无选项"];
            
        }
        
        
        
    }else{
        self.navigationItem.rightBarButtonItem.tag = 0;
        [backView removeFromSuperview];
        [oderView removeFromSuperview];
        
    }
    
    
    
}
#pragma -markt数据看板弹框
-(void)setSxUI{
    
    //遮罩
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor =[UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0/ 255.0 alpha:0.1];
    backView.userInteractionEnabled = YES;
   [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    
    //遮罩按钮
    UIButton *zzButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backView addSubview:zzButton];
    [zzButton setBackgroundColor:[UIColor clearColor]];
    [zzButton addTarget:self action:@selector(canOder) forControlEvents:UIControlEventTouchUpInside];
    //数据选择
    
    
   
    oderView = [[UIView alloc]initWithFrame:CGRectMake(0, 1000, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    oderView.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:oderView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(20,20)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = oderView.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    oderView.layer.mask = maskLayer;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        // 设置view弹出来的位置
        if (getRectNavAndStatusHight == 88) {
             self->oderView.frame = CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT/2);
        }else{
            
             self->oderView.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT/2);
        }
       
        
    }];
    [backView addSubview:oderView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(00, 15, SCREEN_WIDTH, 20)];
    label.text = @"我的看板";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = COLOR_56_COLOER;
    label.font = [UIFont systemFontOfSize:16];
    [oderView addSubview:label];
    
    UIButton *canButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 30, 30)];
    [oderView addSubview:canButton];
    [canButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [canButton addTarget:self action:@selector(canOder) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    [oderView addSubview:line];
    line.backgroundColor= [UIColor colorWithRed:234 / 255.0 green:234/ 255.0 blue:234 / 255.0 alpha:1];
    
    [self setOderType];
    
}
-(void)canOder{
    
    self.navigationItem.rightBarButtonItem.tag = 0;
    [backView removeFromSuperview];
    [oderView removeFromSuperview];
    
}
-(void)setOderType{
    
    for (int i = 0; i < sxArray.count; i++)
    {
         UIButton *TtypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
       TtypeButton.frame= CGRectMake((i % 3) * (20+ (SCREEN_WIDTH-20*4)/3)+20,(i / 3)*(50*SCREEN_WIDTH/375) +60,(SCREEN_WIDTH-20*4)/3, 40*SCREEN_WIDTH/375);
        
       
        [oderView addSubview:TtypeButton];
        TtypeButton.backgroundColor =[UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        
        [TtypeButton setTitle:[sxArray objectAtIndex:i]  forState:UIControlStateNormal];
        [TtypeButton setTitleColor: [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1]  forState:UIControlStateNormal];
        
        [TtypeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [TtypeButton.layer setCornerRadius:5];
       
         [TtypeButton addTarget:self action:@selector(didBtnColorChange:) forControlEvents:UIControlEventTouchDown];
        
        [TtypeButton setTag:i];
        [TtypeButton addTarget:self action:@selector(clickTypeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    
    
}
-(void)didBtnColorChange:(UIButton *)securitycodeButton
{
    securitycodeButton.backgroundColor = [UIColor colorWithRed:51 / 255.0 green:150 / 255.0 blue:251 / 255.0 alpha:1]; //这里写上你想要改变的颜色就行了
     [securitycodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
}





#pragma -mark数据看板按钮点击事件
-(void)clickTypeButton:(UIButton *)button{
   
    self.navigationItem.rightBarButtonItem.tag = 0;
    [backView removeFromSuperview];
    [oderView removeFromSuperview];
    
    self.kfLabel.text =[NSString stringWithFormat:@"%@%@报表",_orgName,button.titleLabel.text] ;
    [self.navigationController.navigationBar addSubview: self.kfLabel];
    view.localIndex= button.tag;
    switch (button.tag) {
        case 0:
        {
            _page = 0;
            if ([self.table isEqualToString:@"kpiTable"]) {
                 self->_jgName = @"rysltab";
            }else{
                
                 self->_jgName = @"ryslzxt";
            }
           
            [self loadWebURl];
        }
            break;
        case 1:
        { _page = 1;
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rlztab";
            }else{
                
                self->_jgName = @"rlzzxt";
            }
           
            [self loadWebURl];
        }
            break;
            
            break; case 2:
        {
             _page = 2;
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rlcbtab";
            }else{
                
                self->_jgName = @"rlcbbt";
            }
           
            [self loadWebURl];
        }
            break; case 3:
        {
             _page = 3;
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"rlxntab";
            }else{
                
                self->_jgName = @"rlxnzxt";
            }
         
            [self loadWebURl];
        }
            break; case 4:
        {
             _page = 4;
            if ([self.table isEqualToString:@"kpiTable"]) {
                self->_jgName = @"jysjtab";
            }else{
                
                self->_jgName = @"jysjzxt";
            }
          
            [self loadWebURl];
        }
         
            break;
            
        default:
            break;
    }
//    switch (button.tag) {
//        case 0:
//        {
//            self->_jgName = @"rybz";
//            [self loadWebURl];
//        }
//            break;
//        case 1:
//        {
//            self->_jgName = @"rlcb";
//            [self loadWebURl];
//        }
//            break;
//
//            break; case 2:
//        {
//            self->_jgName = @"rlxnys";
//            [self loadWebURl];
//        }
//            break; case 3:
//        {
//            self->_jgName = @"rlxnlr";
//            [self loadWebURl];
//        }
//            break; case 4:
//        {
//            self->_jgName = @"cbjg";
//            [self loadWebURl];
//        }
//            break; case 5:
//        {
//            self->_jgName = @"zjjg";
//            [self loadWebURl];
//        }
//            break; case 6:
//        {
//            self->_jgName = @"xljg";
//            [self loadWebURl];
//        }
//            break; case 7:
//        {
//            self->_jgName = @"nljg";
//            [self loadWebURl];
//        }
//            break; case 8:
//        {
//            self->_jgName = @"sljg";
//            [self loadWebURl];
//        }
//            break; case 9:
//        {
//            self->_jgName = @"gljg";
//            [self loadWebURl];
//        }
//            break; case 10:
//        {
//            self->_jgName = @"srjg-month";
//            [self loadWebURl];
//        }
//
//            break; case 11:
//        {
//            self->_jgName = @"xcbd";
//            [self loadWebURl];
//        }
//            break;
//        case 12:
//        {
//            self->_jgName = @"zjbd";
//            [self loadWebURl];
//        }
//            break;
//        case 13:
//        {
//            self->_jgName = @"rlz";
//            [self loadWebURl];
//        }
//            break;
//
//
//        default:
//            break;
//    }
//    CGPoint offset = self->view.contentOffset;
//    if (button.tag>1 ) {
//        offset.x = button.tag*(SCREEN_WIDTH-60)/4 -(SCREEN_WIDTH-60)/4;
//    }else if(button.tag==1){
//
//         offset.x = button.tag*(SCREEN_WIDTH-60)/4 -(SCREEN_WIDTH-60)/4;
//
//    }else{
//
//         offset.x = 0;
//    }
//     CGPoint offset = self->view.contentOffset;
//     offset.x = button.tag*(SCREEN_WIDTH-60)/4 -(SCREEN_WIDTH-60)/4;
//    [UIView animateWithDuration:0.6 animations:^{
//        self->view.contentOffset = offset;
//
//    }];
    
   
    
}
#pragma -mark月份选择代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
   
        return mothArray.count;
    

}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 35;
}
#pragma -mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;
{
    NSString *string = nil;
    
    
   string = [mothArray objectAtIndex:row];
    
    // 设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor =  [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225/ 255.0 alpha:1];
        }
    }
    
 
    __unsafe_unretained Class labelClass = [UILabel class];
    if ([view isKindOfClass:labelClass])
    {
        [((UILabel *)view) setText:string];
    }
    else
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, -0, pickerView.frame.size.width, 30)];
        [label setFont:[UIFont systemFontOfSize:20]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:COLOR_56_COLOER];
        [label setText:string];
        return label;
    }
    
    
    return view;
    
}

- (void)pickerView:(MCPickerView *)pickerView  finishFirstComponentRow:(NSInteger)row;//代理只返第一组，多的可以使用pickerView本身的去调用；
{
    NSString *string = nil;
    
   
        
    string = [mothArray objectAtIndex:row];
    
     [monthButoon setTitle:[NSString stringWithFormat:@"%@",string] forState:UIControlStateNormal];
    
    [pickerView dismissAnimation:YES];
    self.moth = string;
    [self loadWebURl];
    
}

- (void)pickerView:(MCPickerView *)pickerView  cancelFirstComponentRow:(NSInteger)row;//代理只返第一组，多的可以使用pickerView本身的去调用；
{
    [pickerView dismissAnimation:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    
//    NSString * current = [NSString stringWithFormat:@"%@",[Defaults objectForKey:@"current"]];
//    NSString * endTime = [NSString stringWithFormat:@"%@",[self getCurrentTimes]];
//    NSDate* date1 =[self dateFromString:current];//登录时保存的时间
//    NSDate*date2 =[self dateFromString:endTime];//当前的时间
//    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
//    
//    double secondsInAnHour =-1;// 除以3600是把秒化成小时，除以60得到结果为相差的分钟数
//    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
//    
//    NSString *exp_in = [NSString stringWithFormat:@"%@",EXPIRES_IN];//获取的过期值
//    //-30：表示时间误差值
//    if (hoursBetweenDates >([exp_in integerValue] -300))
//    {
//        //表示token已经过期,刷新token值刷新url
//        [self getOuth];
//        
//    }
//    else
//    {
//        //表示token还可以使用
//        
//        
//    }
//    
    
    
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
