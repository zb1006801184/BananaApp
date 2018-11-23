//
//  BWebViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/21.
//

#import "BWebViewController.h"
#import <WebKit/WebKit.h>

@interface BWebViewController ()<WKNavigationDelegate,WKUIDelegate>

@end

@implementation BWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    //开了支持滑动返回
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webView];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_mainUrl]]];


}

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [self.view makeToastActivity:CSToastPositionCenter];

}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [self.view hideAllToasts:YES clearQueue:YES];
}



@end
