//
//  MineViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "MineViewController.h"
#import "MineMainTableView.h"
#import "LoginViewController.h"
@interface MineViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic, strong) MineMainTableView *myTableView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)configViews {
    _myTableView = [[MineMainTableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, self.mainView.height) style:UITableViewStyleGrouped];
    NSArray *dataList = @[@[@{@"title":@"个人资料",@"image":@"我的-个人资料"},@{@"title":@"关于我们",@"image":@"我的-关于我们"},@{@"title":@"清理缓存",@"image":@"我的-清理缓存.png"},],@[@{@"title":@"设置",@"image":@"我的-设置图标"},]];
    _myTableView.dataList = dataList;
    [self.mainView addSubview:_myTableView];
    
}

- (IBAction)loginClick:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
