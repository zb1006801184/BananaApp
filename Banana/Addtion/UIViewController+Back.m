//
//  UIViewController+Back.m
//  Banana
//
//  Created by 朱标 on 2018/11/21.
//

#import "UIViewController+Back.h"

@implementation UIViewController (Back)
- (void)viewDidLoad {
//    1使用系统图片
    //    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
//    backButtonItem.title = @"返回";
//    backButtonItem.tintColor = [UIColor whiteColor];
//    self.navigationItem.backBarButtonItem = backButtonItem;
    
//    2完全自定义 （会影响返回手势）
//    if (self.navigationController.viewControllers.count > 1) {
//        [self setLeftBack];
//    }

//    3使用自定义图片文字  不影响返回手势
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"返回";
    backItem.tintColor = [UIColor whiteColor];
    //主要是以下两个图片设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"返回"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"返回"];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal];

}

- (void)setLeftBack {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(5, 3, 40, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 9, 16)];
    imageView.image = [UIImage imageNamed:@"返回"];
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    [bgView addSubview:button];
    [bgView addSubview:imageView];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc]initWithCustomView:bgView];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
