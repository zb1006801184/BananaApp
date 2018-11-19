//
//  LoginViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ReviseViewController.h"
@interface LoginViewController ()
//账号
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"";
    _getCodeButton.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (IBAction)registerClick:(id)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)Revise:(id)sender {
    ReviseViewController *ReviseVC = [[ReviseViewController alloc]init];
    [self.navigationController pushViewController:ReviseVC animated:YES];
}


//登录
- (IBAction)loginClick:(id)sender {
    
}

@end
