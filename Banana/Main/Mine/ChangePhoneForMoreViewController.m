//
//  ChangePhoneForMoreViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/24.
//

#import "ChangePhoneForMoreViewController.h"
#import "ChangePhoneViewController.h"
@interface ChangePhoneForMoreViewController ()
{
    NSInteger countDown;
    NSTimer *timer;
    
}

@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSString *operationType;


@end

@implementation ChangePhoneForMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"更换手机号";
    _titleLabel.text = [self getPhone];
    _operationType = @"4";
}
- (NSString *)getPhone {
    NSString *phone = [UserModel getUserModel].phone;
    NSString *nPhone = [NSString stringWithFormat:@"%@****%@",[phone substringToIndex:3],[phone substringFromIndex:7]];
    return nPhone;
}

- (IBAction)nextClick:(id)sender {
    [self getOldPhoneCode];
}
- (IBAction)getCodeClick:(id)sender {
    //获取验证码
    [MineRequest sendCodeWithToken:@"" telephone:[UserModel getUserModel].phone operationType:_operationType success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"获取验证码成功" duration:1 position:CSToastPositionCenter];
        [self netWork];
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

- (void)getOldPhoneCode {
    [MineRequest validateCheckCodeWithTelephone:[UserModel getUserModel].phone checkCode:_codeTextField.text operationType:_operationType success:^(id  _Nonnull responseObject) {
        ChangePhoneViewController *changeBind = [[ChangePhoneViewController alloc]init];
        changeBind.type = 2;
        changeBind.validateCheckCode = responseObject[@"validateCode"];
        [self.navigationController pushViewController:changeBind animated:YES];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
