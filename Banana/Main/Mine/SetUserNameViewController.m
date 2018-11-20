//
//  SetUserNameViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/20.
//

#import "SetUserNameViewController.h"

@interface SetUserNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation SetUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置昵称";
    [self setRightButton];
    _inputTextField.text = [UserModel getUserModel].username;
}
- (void)setRightButton {
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    UIBarButtonItem *itemBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = itemBarButton;
    [rightButton addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)sureClick {
    if (_inputTextField.text.length < 1) {
        [self.view makeToast:@"请输入昵称" duration:2 position:CSToastPositionCenter];
        return;
    }
    [MineRequest changeUserMessageWithUserName:_inputTextField.text success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"昵称修改成功" duration:2 position:CSToastPositionCenter];
        UserModel *model = [UserModel getUserModel];
        model.username = self.inputTextField.text;
        [UserModel saveUserModelWithObject:model];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            if (self.callBackUserName) {
                self.callBackUserName(self.inputTextField.text);
            }
        });
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
