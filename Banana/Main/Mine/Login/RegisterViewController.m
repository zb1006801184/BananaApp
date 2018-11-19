//
//  RegisterViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "RegisterViewController.h"
#import "MineRequest.h"
@interface RegisterViewController ()
{
    NSInteger countDown;
    NSTimer *timer;
    
}
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passworkTextField;
@property (nonatomic, strong) NSString *codeStr;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
}

- (IBAction)backLoginClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)getCodeClick:(id)sender {
    if (_phoneTextField.text.length < 11) {
        [self.view makeToast:@"请输入正确的手机号" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    //获取验证码
    [MineRequest sendCodeWithToken:@"" telephone:_phoneTextField.text operationType:@"0" success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"获取验证码成功" duration:1 position:CSToastPositionCenter];
        [self netWork];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (IBAction)sureClick:(id)sender {
    if (_phoneTextField.text.length < 11) {
        [self.view makeToast:@"请输入正确的手机号" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    if (_codeTextField.text.length < 1) {
        [self.view makeToast:@"请输入验证码" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    if (7> _passworkTextField.text.length && _passworkTextField.text.length  > 20) {
        [self.view makeToast:@"请输入8到20位的密码" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    [MineRequest registerWithPhone:_phoneTextField.text username:@"" checkCode:_codeTextField.text password:_passworkTextField.text success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"注册成功" duration:2 position:CSToastPositionCenter style:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
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
    NSLog(@"%ld",(long)countDown);
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
