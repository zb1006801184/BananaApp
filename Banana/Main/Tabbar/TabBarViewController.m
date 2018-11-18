//
//  TabBarViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "AllProductViewController.h"
#import "MineViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *VCs = @[[self HomeNav],[self AllProductNav],[self MineNav]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = [UIColor blackColor];
    self.viewControllers = VCs;
}

- (UINavigationController *)HomeNav {
    HomeViewController *HomeVC = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:HomeVC];
    HomeVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    nav.tabBarItem.title = @"首页";
    NSDictionary *dic=@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [nav.navigationBar setTitleTextAttributes:dic];
    nav.tabBarItem.image = [[UIImage imageNamed:@"home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationBar.barTintColor = [UIColor colorWithHexString:@"#232323"]; //导航栏的颜色

    return nav;
}
- (UINavigationController *)AllProductNav {
    AllProductViewController *AllProductVC = [[AllProductViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:AllProductVC];
    AllProductVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    nav.tabBarItem.title = @"全部产品";
    NSDictionary *dic=@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [nav.navigationBar setTitleTextAttributes:dic];
    nav.tabBarItem.image = [[UIImage imageNamed:@"all"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"all_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationBar.barTintColor = [UIColor colorWithHexString:@"#232323"]; //导航栏的颜色
    return nav;
}
- (UINavigationController *)MineNav {
    MineViewController *MineVC = [[MineViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:MineVC];
    MineVC.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    nav.tabBarItem.title = @"我的";
    NSDictionary *dic=@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [nav.navigationBar setTitleTextAttributes:dic];
    nav.tabBarItem.image = [[UIImage imageNamed:@"mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"mine_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.navigationBar.barTintColor = [UIColor colorWithHexString:@"#232323"]; //导航栏的颜色

    return nav;
}


@end
