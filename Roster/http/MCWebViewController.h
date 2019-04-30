//
//  MCWebViewController.h
//  EmployeesEnd
//
//  Created by 邓梦超 on 16/11/9.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface MCWebViewController : MCRootViewControler<UIWebViewDelegate,NJKWebViewProgressDelegate>{
    
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;
    
}
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *loadHtmlString;
@property (nonatomic, strong) NSURL *HtmlString;
@property (nonatomic,strong) NSString *pidStr;
@property (nonatomic,assign)  NSInteger mids;
@property (nonatomic,assign)  NSString *type;
- (id)initWithTitleString:(NSString *)titleString;
- (id)initWithTitleURL:(NSURL *)titleURL;
- (id)initWithUrl:(NSURL *)url titleString:(NSString *)titleString;

- (id)initWithLoadHtmlString:(NSString *)loadHtmlString titleString:(NSString *)titleString;
- (id)initWithLoadHtmlString:(NSString *)loadHtmlString titleString:(NSString *)titleString andtype:(NSString *)type;


@end
