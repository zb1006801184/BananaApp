//
//  ChangePhoneViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()
{
    NSInteger countDown;
    NSTimer *timer;
    
}

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"更换手机号";
}
- (IBAction)getCodeClick:(id)sender {
    if (_phoneTextField.text.length < 11) {
        [self.view makeToast:@"请输入正确的手机号" duration:2 position:CSToastPositionCenter style:nil];
        return;
    }
    //获取验证码
    [MineRequest sendCodeWithToken:@"" telephone:_phoneTextField.text operationType:@"1" success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"获取验证码成功" duration:1 position:CSToastPositionCenter];
        [self netWork];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (IBAction)sureClick:(id)sender {
    
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
