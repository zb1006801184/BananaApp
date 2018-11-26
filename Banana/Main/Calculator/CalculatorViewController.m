//
//  CalculatorViewController.m
//  Banana
//
//  Created by tdr on 2018/11/26.
//

#import "CalculatorViewController.h"
#import <WebKit/WebKit.h>

@interface CalculatorViewController ()<WKNavigationDelegate,WKUIDelegate>{
    
    WKWebView *webView;
    
    UIButton *button;
}

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"贷款计算器";
    
    
    webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabbarHeight-kNavHeight)];
    //开了支持滑动返回
    webView.allowsBackForwardNavigationGestures = YES;
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
    webView.customUserAgent = @"xiangjiaowallet/1.0";
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://ca.xiangjiaoqianbao.cn"]]];
    webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:webView];
    
    
    button = [[UIButton alloc]initWithFrame:CGRectMake(5, 3, 40, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 9, 16)];
    imageView.image = [UIImage imageNamed:@"返回"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [bgView addSubview:button];
    [bgView addSubview:imageView];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
}

-(void)back{
    
    //判断是否能返回到H5上级页面
    if (webView.canGoBack==YES) {
        //返回上级页面
        [webView goBack];
        
    }
}

// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
}


// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

 
}
// 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSString * urlStr = navigationResponse.response.URL.absoluteString;
    NSLog(@"当前跳转地址：%@",urlStr);
//    if ([urlStr isEqualToString:@"https://ca.xiangjiaoqianbao.cn/"]) {
//
//        backbtn.hidden = YES;
//    }else{
//        backbtn.hidden = NO;
//
//    }
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

@end
