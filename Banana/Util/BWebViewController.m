//
//  BWebViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/21.
//

#import "BWebViewController.h"
#import <WebKit/WebKit.h>

@interface BWebViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *mainView;

@end

@implementation BWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_mainView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_mainUrl]]];
}


@end
