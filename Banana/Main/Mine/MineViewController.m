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
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *NickNameButton;
@property (strong, nonatomic) IBOutlet UIView *showMessageView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configViews];
    [self loadDataForView];
    self.showMessageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showMessageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.showMessageView.layer.shadowOpacity = 0.5;
    self.showMessageView.layer.cornerRadius = 10;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    UserModel *model = [UserModel getUserModel];
    [_headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:nil];
    [_NickNameButton setTitle:model.username forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)loadDataForView {
    self.headImage.layer.masksToBounds = YES;
    UserModel *model = [UserModel getUserModel];
    [self.NickNameButton setTitle:model.username forState:UIControlStateNormal];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"身份认证"]];
}
- (void)configViews {
    _myTableView = [[MineMainTableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, self.mainView.height) style:UITableViewStyleGrouped];
    NSArray *dataList = @[@[@{@"title":@"个人资料",@"image":@"我的-个人资料"},@{@"title":@"关于我们",@"image":@"我的-关于我们"},@{@"title":@"清理缓存",@"image":@"我的-清理缓存.png"},],@[@{@"title":@"设置",@"image":@"我的-设置图标"},]];
    _myTableView.dataList = dataList;
    [self.mainView addSubview:_myTableView];
    
}

- (IBAction)loginClick:(id)sender {
    //用户信息
    
}

- (void)showMessagetoView {
    [self.view addSubview:_showMessageView];
    _showMessageView.frame = CGRectMake((kScreenWidth - 133)/2, (kScreenHeight - 86)/2, 133, 86);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_showMessageView removeFromSuperview];
    });
}

@end
