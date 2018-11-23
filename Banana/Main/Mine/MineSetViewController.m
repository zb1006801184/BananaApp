//
//  MineSetViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineSetViewController.h"
#import "MineIdeaViewController.h"
#import "ChangePhoneViewController.h"
#import "Login/LoginViewController.h"
@interface MineSetViewController ()

@end

@implementation MineSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"设置";
}

//更换手机号
- (IBAction)changePhoneClick:(id)sender {
    ChangePhoneViewController *phone = [[ChangePhoneViewController alloc]init];
    phone.type = 1;
    [self.navigationController pushViewController:phone animated:YES];
}

//意见反馈
- (IBAction)ideaClick:(id)sender {
    MineIdeaViewController *idea = [[MineIdeaViewController alloc]init];
    [self.navigationController pushViewController:idea animated:YES];
}

//退出登录
- (IBAction)siginOutClick:(id)sender {
    [MineRequest loginOutSuccess:^(id  _Nonnull responseObject) {
        [UserModel loginOut];
        [UserModel saveUserModelWithObject:[[UserModel alloc]init]];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        nav.navigationBar.barTintColor = [UIColor colorWithHexString:@"#232323"]; //导航栏的颜色
        [self presentViewController:nav animated:YES completion:nil];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
