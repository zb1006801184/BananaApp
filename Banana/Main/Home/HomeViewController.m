//
//  HomeViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 10, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
}



@end
