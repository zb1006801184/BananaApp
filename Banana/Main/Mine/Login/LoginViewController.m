//
//  LoginViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ReviseViewController.h"
#import "TabBarViewController.h"
#import "UserModel.h"
@interface LoginViewController ()
{
    NSInteger countDown;
    NSTimer *timer;
    
}

//账号
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
//切换按钮
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@property (nonatomic, strong) NSString *loginType;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    _getCodeButton.hidden = YES;
    _loginType = @"1";
    _passwordTextField.secureTextEntry = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timer invalidate];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    if (_accountTextField.text.length < 1) {
        [self.view makeToast:@"请输入账号" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (_passwordTextField.text.length < 1) {
        [self.view makeToast:@"请输入密码" duration:2 position:CSToastPositionCenter];
        return;
    }
    [MineRequest loginWithUsername:_accountTextField.text password:_passwordTextField.text loginType:_loginType success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"登录成功" duration:1 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self rootView];
            [UserModel login];
            [UserModel saveUserModelWithObject:[UserModel mj_objectWithKeyValues:responseObject]];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];

}
//密码登录 验证码登录 类型切换

- (IBAction)changeType:(id)sender {
    _passwordTextField.text = @"";
    if ([_loginType isEqualToString:@"1"]) {
        _loginType = @"2";
        //验证码登录
        _getCodeButton.hidden = NO;
        _passwordTextField.placeholder = @"请输入验证码";
        [_changeButton setTitle:@"密码登录" forState:UIControlStateNormal];
        _passwordTextField.secureTextEntry = NO;

    }else {
        _loginType = @"1";
        _getCodeButton.hidden = YES;
        [_changeButton setTitle:@"验证码登录" forState:UIControlStateNormal];
        _passwordTextField.placeholder = @"请输入验密码";
        _passwordTextField.secureTextEntry = YES;

    }
}
//获取验证码
- (IBAction)getCodeClick:(id)sender {
    //获取验证码
    [MineRequest sendCodeWithToken:@"" telephone:_accountTextField.text operationType:@"7" success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"获取验证码成功" duration:1 position:CSToastPositionCenter];
        [self netWork];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//新的入口
- (void)rootView {
//
    TabBarViewController *tabBarVC = [[TabBarViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
}

//获取用户信息
- (void)getMessage {
    [MineRequest getMessageSuccess:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 获取倒计时
- (void)netWork{
    [self NSTimer];
}
- (void)NSTimer{
    countDown = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    self.getCodeButton.enabled = NO;
}
- (void)timerFireMethod:(id)sender{
    countDown--;
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%ld秒后重发",(long)countDown]forState:UIControlStateNormal];
    [self.getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (countDown == 0) {
        [timer invalidate];
        [self.getCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.getCodeButton.enabled = YES;
    }
}
@end
