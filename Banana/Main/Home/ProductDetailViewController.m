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
@property (weak, nonatomic) IBOutlet UILabel *phonelabel;
@property (weak, nonatomic) IBOutlet UILabel *weixinlabel;

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *tableviewdata;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewH;


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
    _tableview.hidden = NO;
    _datailLabel.hidden = YES;
    _phonelabel.hidden = YES;
    _weixinlabel.hidden = YES;

}

//机构详情
- (IBAction)mechanismClick:(id)sender {
    _leftImage.hidden = YES;
    _rightImage.hidden = NO;
    _tableview.hidden = YES;
    _datailLabel.hidden = NO;
    _phonelabel.hidden = NO;
    _weixinlabel.hidden = NO;
}
- (void)setModel:(id)model {
    _models = model;
    [self getData];
}

- (void)getData {
    [HomeRequest detailWithID:_models.id success:^(id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        self.homeModel = [HomeModel mj_objectWithKeyValues:responseObject];
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
    _requestLoan.text = [NSString stringWithFormat:@"%@",_homeModel.loanRequest];
    
    
    _datailLabel.text = [NSString stringWithFormat:@"机构信息：%@",_homeModel.oiai];
    if (_homeModel.telephone == nil) {
        if (_homeModel.wechat == nil) {
        }else{
            _phonelabel.text = [NSString stringWithFormat:@"微信号：%@",_homeModel.wechat];
        }
    }else{
        _phonelabel.text = [NSString stringWithFormat:@"机构电话：%@",_homeModel.telephone];
        if (_homeModel.wechat == nil) {
        }else{
            _weixinlabel.text = [NSString stringWithFormat:@"微信号：%@",_homeModel.wechat];
        }
    }
    
    
    self.tableviewdata = [self toArrayOrNSDictionary:[self.homeModel.rereq dataUsingEncoding:NSUTF8StringEncoding]];
    
    _tableviewH.constant = 50*self.tableviewdata.count;
    [self.tableview reloadData];
    
    _scrollview.contentSize = CGSizeMake(0, _tableview.bottom+80);


}


- (IBAction)nextClick:(id)sender {
    
    if ([_homeModel.jumpType isEqualToString:@"1"]) {
        BWebViewController *web = [[BWebViewController alloc]init];
        web.mainUrl = _homeModel.jumpUrl;
        

        
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }else if ([_homeModel.jumpType isEqualToString:@"2"]){
        
        NSString *openURL = _homeModel.jumpUrl;
        NSURL *URL = [NSURL URLWithString:openURL];
        [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:nil];
        
        
    }
    
 
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    
    return self.tableviewdata.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Photos";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        UIImageView *btnmore = [[UIImageView alloc]init];
        btnmore.frame = CGRectMake(15, 10, 30, 30);
        [cell addSubview:btnmore];
        btnmore.tag = 100;
        btnmore.layer.masksToBounds = YES;
        btnmore.layer.cornerRadius =15;
        btnmore.image = [UIImage imageNamed:@"身份认证"];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btnmore.right +20, 10, 200, 30)];
        [cell addSubview:label];
        label.textColor = [UIColor colorWithHexString:@"#4C516A"];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 200;
        
    }
    
    NSDictionary *dic = _tableviewdata[indexPath.row];

    UILabel *textlabel = (UILabel *)[cell viewWithTag:200];
    textlabel.text = dic[@"material_value"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

//json字符串转数组
-  (id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
}


@end
