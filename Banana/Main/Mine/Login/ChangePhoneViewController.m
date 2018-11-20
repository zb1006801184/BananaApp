//
//  ChangePhoneViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "ChangePhoneViewController.h"
#import "LoginViewController.h"
@interface ChangePhoneViewController ()
{
    NSInteger countDown;
    NSTimer *timer;
    
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (nonatomic, strong) NSString *operationType;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"更换手机号";
    [self loadDataForView];
}
- (void)loadDataForView {
    _operationType = @"4";
    if (_type == 2) {
        _operationType = @"5";
        _phoneTextField.placeholder = @"请输入新手机号码";
        [_sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
    }
}
- (IBAction)getCodeClick:(id)sender {
    if (_phoneTextField.text.length < 11) {
        [self.view makeToast:@"请输入正确的手机号" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    //获取验证码
    [MineRequest sendCodeWithToken:@"" telephone:_phoneTextField.text operationType:_operationType success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"获取验证码成功" duration:1 position:CSToastPositionCenter];
        [self netWork];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (IBAction)sureClick:(id)sender {
    if (_phoneTextField.text.length < 1) {
        [self.view makeToast:@"请输入手机号" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    if (_codeTextField.text.length < 1) {
        [self.view makeToast:@"请输入验证码" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    if (_type == 1) {
        [self getOldPhoneCode];
    }else if (_type == 2) {
        [self sureChange];
    }
}

- (void)sureChange {
    [MineRequest changeBindWithPhone:_phoneTextField.text checkCode:_codeTextField.text validateCode:_validateCheckCode success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"换绑手机成功" duration:2 position:CSToastPositionCenter style:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UserModel loginOut];
            [UserModel saveUserModelWithObject:[[UserModel alloc]init]];
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
                [[BSomeWays getCurrentVC] presentViewController:nav animated:YES completion:nil];
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)getOldPhoneCode {
    [MineRequest validateCheckCodeWithTelephone:_phoneTextField.text checkCode:_codeTextField.text operationType:_operationType success:^(id  _Nonnull responseObject) {
        ChangePhoneViewController *changeBind = [[ChangePhoneViewController alloc]init];
        changeBind.type = 2;
        changeBind.validateCheckCode = responseObject[@"validateCode"];
        [self.navigationController pushViewController:changeBind animated:YES];
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
