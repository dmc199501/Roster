//
//  MCWebViewController.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 16/11/9.
//  Copyright © 2016年 邓梦超. All rights reserved.
//
#define DOWN_TAG        @"download"//下载
#import "MCWebViewController.h"
#import "DownListManager.h"

@implementation MCWebViewController
- (void)dealloc
{
    self.url = nil;
    
    
}

- (id)initWithTitleString:(NSString *)titleString{
    
    self = [super init];
    if (self)
    {
        self.titleString = titleString;
    }
    
    return self;
    
}
- (id)initWithTitleURL:(NSURL *)titleURL{
    
    self = [super init];
    if (self)
    {
        self.HtmlString = titleURL;
    }
    
    return self;
    
}

- (id)initWithUrl:(NSURL *)url titleString:(NSString *)titleString
{
    self = [super init];
    if (self)
    {
        self.url = url;
        self.titleString = titleString;
    }
    
    return self;
    
}

- (id)initWithLoadHtmlString:(NSString *)loadHtmlString titleString:(NSString *)titleString;
{
    self = [super init];
    if (self)
    {
        self.loadHtmlString = loadHtmlString;
        self.titleString = titleString;
    }
    
    return self;
    
}
- (id)initWithLoadHtmlString:(NSString *)loadHtmlString titleString:(NSString *)titleString andtype:(NSString *)type;
{
    self = [super init];
    if (self)
    {
        self.loadHtmlString = loadHtmlString;
        self.titleString = titleString;
        self.type = type;
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.navigationItem.title = _titleString;
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"左箭头"] style:UIBarButtonItemStylePlain target:self action:@selector(returnUp)];
    
    
    UIBarButtonItem *right2 = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(right1Click)];
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_refresh_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(newLoad)];
    //right2.width = -50;
    
    //添加到导航栏的右边（一个）
    self.navigationItem.rightBarButtonItem = right2;
    //右边数组里面有几个，就出现几个  （由右向左）（多个）
    //左边的话是由左向右的
    self.navigationItem.rightBarButtonItems = @[right2,right1];
    //right2.width = -50;
    
    //添加到导航栏的右边（一个）
//    self.navigationItem.rightBarButtonItem = right2;
//    //右边数组里面有几个，就出现几个  （由右向左）（多个）
//    //左边的话是由左向右的
//    self.navigationItem.rightBarButtonItems = @[right2,right1];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(newLoad)];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(returnUp)];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(returnUp)];
     float heights = getRectNavAndStatusHight+getTabBarHight;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-getTabBarHight-10)];
    [self.view addSubview:self.webView];
    
    // Do any additional setup after loading the view.
    _webViewProgress = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _webViewProgress;
    
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    
    
    CGRect navBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0,
                                 navBounds.size.height - 0.5,
                                 navBounds.size.width,
                                 0.5);
    _webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    [self loadHtml];
    
}
#pragma mark - 页面返回方法
- (void)returnUp{
    
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
        
        if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]){
            [NSUserDefaults standardUserDefaults];
            [pushJudge setObject:@""forKey:@"push"];
            [pushJudge synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }else{
            [self.view resignFirstResponder];
            //[self cleanUpAction];
            //[self cleanCacheAndCookie];
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
- (void)right1Click{
    
    
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]){
        [NSUserDefaults standardUserDefaults];
        [pushJudge setObject:@""forKey:@"push"];
        [pushJudge synchronize];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//- (void)right1Click{
//
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//
//    }else{
//
//            [self.view resignFirstResponder];
//            //[self cleanUpAction];
//            //[self cleanCacheAndCookie];
//
//            [self.navigationController popViewControllerAnimated:YES];
//
//    }
//
//}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
   
    NSString *sss =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title

        
    if ([self.type integerValue] ==2) {
        self.navigationItem.title = self.titleString;
    }else{
        self.navigationItem.title = sss;}
    
    
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
   
    NSString* reqUrl = request.URL.absoluteString;
    
   
       
    if ([reqUrl containsString:@"hmc:///////download"]) {
            NSString *downloadURLString =reqUrl ;

            NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:downloadURLString]];

            NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];

            [self.connArray addObject:conn];


             }
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {

        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:request.URL];

        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];

       [self.connArray addObject:conn];

        return NO;
    }
    return YES;
    
}
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    
    self.currDownFileName = [response suggestedFilename];;
    
    
    
    self.downloadedMutableData = [[NSMutableData alloc] init];
    self.urlResponse = response;
    
    NSString *mimeType = [response MIMEType];
    if ([mimeType isEqualToString:@"text/html"] || [mimeType containsString:@"htm"]) {
        
        [connection cancel];
        //        NSLog(@"调用的连接 %@", response.URL);
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:response.URL];
        [self.webView loadRequest:req];
        
        
    } else {
        
        
    }
    
    
    
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    //    NSLog(@"Connection: didReceiveData");
  
        [self.downloadedMutableData appendData:data];
    [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"下载中.."]];
//       [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"下载中...(%.0f%%)",((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length)]];
        float down = ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length);
        if (down == 100.0) {
           
            [self performSelector:@selector(SVPdismiss) withObject:nil afterDelay:1.5];
           
        
        
    }
    //    [[WTAppDelegate sharedAppDelegate] showLoading:[NSString stringWithFormat:@"下载中...(%.0f%%)", ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length)]];
    //
    //    NSLog(@"%.0f%%", ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length));
}

-(void)SVPdismiss{
    
     [SVProgressHUD dismiss];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   
    //    NSLog(@"Connection: connectionDidFinishLoading");
    
    self.savedFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *decodeFileName = [self.currDownFileName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.savedFilePath =[self.savedFilePath stringByAppendingPathComponent:decodeFileName];
//    NSError *error = nil;
//    //GBK编码
//    NSString *fileContents = [NSString stringWithContentsOfFile:self.savedFilePath  encoding:0x80000632 error:&error];
//    //UTF8编码
//   // NSString *fileContents = [NSString stringWithContentsOfFile:self.savedFilePath encoding:NSUTF8StringEncoding error:&error];
//    //取出每一行的数据
//    NSArray *_allLinedStrings = [fileContents componentsSeparatedByString:@"\r\n"];
//     NSLog(@"555555555%@",_allLinedStrings);
   


    
    [self.downloadedMutableData writeToFile:self.savedFilePath atomically:YES];
    
    [DownListManager writeDownPlist:decodeFileName];
    
    //    NSString *retStr = [self toJSONStringWithDictionary:@{@"status": @"下载完毕"} andFunctionCode:DOWN_TAG];
    //    [self nativeCallJSWithParamsByFunctionCode:DOWN_TAG andData:retStr];
    //    [[WTAppDelegate sharedAppDelegate] showSucMsg:@"下载完毕！" WithInterval:2.0];
    
    NSString *extent = [self.savedFilePath pathExtension];
   // if ([extent isEqualToString:@"doc"] || [extent isEqualToString:@"docx"] || [extent isEqualToString:@"ppt"] || [extent isEqualToString:@"pptx"] || [extent isEqualToString:@"xls"] || [extent isEqualToString:@"xlsx"] || [extent isEqualToString:@"pdf"]) {
    self.fileURL = [NSURL fileURLWithPath:self.savedFilePath];
    
//    [self qlpVC];
//    [self openQLPreviewVC];
    self.previewController  =  [[QLPreviewController alloc]  init];
    self.previewController.view.frame =CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self.previewController didMoveToParentViewController:self];
//    [self addChildViewController:self.previewController];
//    [self.view addSubview:_previewController.view];
    self.previewController.hidesBottomBarWhenPushed = YES;
    self.previewController.dataSource  = self;
     self.previewController.delegate  = self;
    [self.navigationController pushViewController: self.previewController animated:NO];
   // [self presentViewController:self.previewController animated:YES completion:nil];
  
        //下载完毕后打开
//        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL fileURLWithPath:self.savedFilePath]];
//        [self.webView loadRequest:req];
    
   // }
    
}

- (void)openQLPreviewVC {
    
    /**
     不能使用present的方式
     1、否则会导致左下角分享按钮隐藏不了
     2、如果使用present出qlpVC，关闭当前VC需要两步操作，先dismiss掉qlpVC，再pop出当前VC，显示效果上会变成两步操作
     */
    [self.navigationController pushViewController: self.previewController animated:NO];
   // [self presentViewController:self.previewController animated:NO completion:nil];
//   [self addChildViewController:self.qlpVC];
//   [self.view addSubview:self.qlpVC.view];
}

- (QLPreviewController *)qlpVC {
    if (!_previewController)  {
        if ([QLPreviewController canPreviewItem:[NSURL fileURLWithPath:self.savedFilePath]])  {
            _previewController = [[QLPreviewController alloc] init];
            _previewController.view.backgroundColor = [UIColor whiteColor];
            _previewController.delegate = self;
            _previewController.dataSource = self;
            self.navigationController.navigationBar.translucent = NO;
            //_previewController.view.frame = _webView.bounds;
        }
    }
    return _previewController;
}

#pragma mark - QLPreviewControllerDataSource
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    
    
    return self.fileURL;
}


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController{
    return 1;
}


- (void)previewControllerWillDismiss:(QLPreviewController *)controller {
    NSLog(@"视图即将dismiss");
   
}

- (void)loadHtml{
    
    [self.webView setBackgroundColor:[UIColor clearColor]];
    //[self.webView setScalesPageToFit:YES];
    
    if (self.url)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        
    }
    else if(self.loadHtmlString)
    {
        [self.webView loadHTMLString:self.loadHtmlString baseURL:nil];
        
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
        
    }else if(self.HtmlString){
        
        NSURLRequest * request=[NSURLRequest requestWithURL:self.HtmlString];
        //加载请求
        [self.webView loadRequest:request];
    }
    
    
    
}

- (void)newLoad{
    
   // [self.webView reload];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
        
        [super viewWillAppear:animated];
        
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        
        

    [self.navigationController.navigationBar addSubview:_webViewProgressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   // [self.navigationController setNavigationBarHidden:YES animated:NO];
    [_webViewProgressView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    if (self.loadHtmlString) {
        [_webViewProgressView setProgress:1 animated:YES];
        return;
    }
    [_webViewProgressView setProgress:progress animated:YES];
    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}



- (void)setUrl:(NSURL *)url
{
    _url = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.navigationItem.title = titleString;
    
}


@end
