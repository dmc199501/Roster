//
//  MCWebViewController.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 16/11/9.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCWebViewController.h"

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
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_refresh_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(newLoad)];
    //right2.width = -50;
    
    //添加到导航栏的右边（一个）
//    self.navigationItem.rightBarButtonItem = right2;
//    //右边数组里面有几个，就出现几个  （由右向左）（多个）
//    //左边的话是由左向右的
//    self.navigationItem.rightBarButtonItems = @[right2,right1];

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(newLoad)];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(returnUp)];
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(returnUp)];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20)];
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
- (void)right1Click{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
     
            [self.view resignFirstResponder];
            //[self cleanUpAction];
            //[self cleanCacheAndCookie];
            
            [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
   
    NSString *sss =  [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title

        
    if ([self.type integerValue] ==2) {
        self.navigationItem.title = self.titleString;
    }else{
        self.navigationItem.title = sss;}
    
    
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
   
    NSString* reqUrl = request.URL.absoluteString;
  
   
        
        
    
    return YES;
    
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
    
    [self.webView reload];
    
}
- (void)returnUp{


    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar addSubview:_webViewProgressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
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
