//
//  MineMaterialViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineMaterialViewController.h"

@interface MineMaterialViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;


@end

@implementation MineMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    [self loadDataForViews];
}
- (void)loadDataForViews {
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 23.5;
    UserModel *model = [UserModel getUserModel];
    self.userNameLabel.text = model.username;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"身份认证"]];
}
- (IBAction)headImageClick:(id)sender {
    
}

- (IBAction)userNameClick:(id)sender {
}

@end
