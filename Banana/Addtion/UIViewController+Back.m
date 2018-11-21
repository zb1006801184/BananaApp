//
//  UIViewController+Back.m
//  Banana
//
//  Created by 朱标 on 2018/11/21.
//

#import "UIViewController+Back.h"

@implementation UIViewController (Back)
- (void)viewDidLoad {
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                             style:UIBarButtonItemStyleDone
//                                                                            target:self
//                                                                            action:nil];
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"返回";
    backButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = backButtonItem;
//    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName, nil] forState:UIControlStateNormal];

}
@end
