//
//  MCRWViewController.m
//  Roster
//
//  Created by 邓梦超 on 2019/7/18.
//  Copyright © 2019 邓梦超. All rights reserved.
//

#import "MCRWViewController.h"
#import "MCWebViewController.h"
#import "UITabBar+MCTabBar.h"
@interface MCRWViewController ()
@property(nonatomic,strong)  MCWebViewController *webViewController;
@end

@implementation MCRWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 屏幕旋转通知
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification object:nil];
    self.navigationItem.title = @"审批";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"左箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    NSString *access_token = [Defaults objectForKey:@"access_token"];
    NSString *uuid = [Defaults objectForKey:@"uuid"];
    
    NSString *urlString = [NSString stringWithFormat:@"http://139.9.32.247:40091/#/approval/index?access_token=%@&uuid=%@",access_token,uuid];
    _webViewController = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:urlString]  titleString:@"审批"];
    [self addChildViewController:_webViewController];
    [self.view addSubview:_webViewController.view];
   
    [self changgeIsRed];
   
    // Do any additional setup after loading the view.
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
//切屏重新设置frame
- (void)deviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation
{
    _webViewController.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
-(void)pop{
    [_webViewController.webView goBack];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.tabBarController.tabBar hideBadgeOnItemIndex:1];
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
