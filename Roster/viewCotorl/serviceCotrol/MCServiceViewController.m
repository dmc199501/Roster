//
//  MCServiceViewController.m
//  Roster
//
//  Created by 邓梦超 on 2018/12/26.
//  Copyright © 2018 邓梦超. All rights reserved.
//

#import "MCServiceViewController.h"
#import "MCServeButton.h"
#import "MCWebViewController.h"
@interface MCServiceViewController ()

@end

@implementation MCServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"服务" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sousuo"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
    addView.backgroundColor = [UIColor clearColor];
   
    self.navigationItem.titleView =addView;
    [self.navigationController.navigationBar addSubview:addView];
    
    ButtonView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    ButtonView.contentSize = CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT);
    [self.view addSubview:ButtonView];
    NSArray *array = @[@"通知公告",@"审批任务",@"通知公告",@"通知公告"];
    for (int i = 0; i < array.count; i++)
    {
        
        
        float heightB = 90;
        MCServeButton *serveButton = [[MCServeButton alloc]initWithFrame:CGRectMake((i % 4) * (SCREEN_WIDTH + 4) / 4 - 0.5 * (i % 4),  (i / 4) * (heightB)+10,(SCREEN_WIDTH + 4) / 4,heightB-20 )];
        [ButtonView addSubview:serveButton];
        [serveButton.iconImageView setImage:[UIImage imageNamed:@"SP_fuwu"]];
        serveButton.iconImageView.frame = CGRectMake((serveButton.frame.size.width - 50) / 2, 0, 50, 50);
        [serveButton.titleNameLabel setFrame:CGRectMake(0, serveButton.frame.size.height-15 , serveButton.frame.size.width, 16)];
        
        [serveButton.titleNameLabel setFont:[UIFont systemFontOfSize:14]];
        serveButton.tag = i;
        [serveButton.titleNameLabel setText:[array objectAtIndex:i]];
        [serveButton setTag:i];
        
        
        
        [serveButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    // Do any additional setup after loading the view.
}
-(void)clickButton:(UIButton *)button{
    
    MCWebViewController *webViewController = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:@"https://www.jianshu.com/p/62343a955f22"]  titleString:@"测试"];
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
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
