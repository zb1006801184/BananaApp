//
//  MineSetViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineSetViewController.h"
#import "MineIdeaViewController.h"
#import "ChangePhoneViewController.h"
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
    [self.navigationController pushViewController:phone animated:YES];
}

//意见反馈
- (IBAction)ideaClick:(id)sender {
    MineIdeaViewController *idea = [[MineIdeaViewController alloc]init];
    [self.navigationController pushViewController:idea animated:YES];
}

//退出登录
- (IBAction)siginOutClick:(id)sender {
}

@end
