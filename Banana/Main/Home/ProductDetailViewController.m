//
//  ProductDetailViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/20.
//

#import "ProductDetailViewController.h"
#import "productModel.h"
#import "HomeRequest.h"
#import "HomeModel.h"
#import "BWebViewController.h"
@interface ProductDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkDateLabel;
//机构详情
@property (weak, nonatomic) IBOutlet UILabel *datailLabel;
//申请
@property (weak, nonatomic) IBOutlet UIView *applyView;
//左
@property (weak, nonatomic) IBOutlet UIImageView *leftImage;
//右
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;

@property (nonatomic, strong) productModel *models;

@property (nonatomic, strong) HomeModel *homeModel;

@property (weak, nonatomic) IBOutlet UILabel *requestLoan;


@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"产品详情";
}

//申请材料

- (IBAction)applyClick:(id)sender {
    _leftImage.hidden = NO;
    _rightImage.hidden = YES;
    _applyView.hidden = NO;
    _datailLabel.hidden = YES;
}

//机构详情
- (IBAction)mechanismClick:(id)sender {
    _leftImage.hidden = YES;
    _rightImage.hidden = NO;
    _applyView.hidden = YES;
    _datailLabel.hidden = NO;
}
- (void)setModel:(id)model {
    _models = model;
    [self getData];
}

- (void)getData {
    [HomeRequest detailWithID:_models.id success:^(id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        self->_homeModel = [HomeModel mj_objectWithKeyValues:responseObject];
        [self setDataForViews];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setDataForViews {
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_homeModel.logo]];
    _nameLabel.text = _homeModel.name;
    _peopleNumberLabel.text = [NSString stringWithFormat:@"已放款%@人",_homeModel.realApplyPersonNum];
    _moneyNumberLabel.text = _homeModel.money;
    _dateNumberLabel.text = _homeModel.duration;
    _rateLabel.text = _homeModel.rate;
    _checkDateLabel.text = _homeModel.lengthExamine;
    _datailLabel.text = _homeModel.oiai;
    _requestLoan.text = [NSString stringWithFormat:@"%@",_homeModel.loanRequest];
}


- (IBAction)nextClick:(id)sender {
    BWebViewController *web = [[BWebViewController alloc]init];
    web.mainUrl = _homeModel.jumpUrl;
    [self.navigationController pushViewController:web animated:YES];
}


@end
