//
//  RegisterViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "RegisterViewController.h"
#import "MineRequest.h"
@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passworkTextField;
@property (nonatomic, strong) NSString *codeStr;
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
    //获取验证码
    [MineRequest sendCodeWithToken:@"" telephone:_phoneTextField.text operationType:@"0" success:^(id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (IBAction)sureClick:(id)sender {
    
}

@end
