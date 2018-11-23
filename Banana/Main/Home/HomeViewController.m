//
//  HomeViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "BConstant.h"
#import "TXScrollLabelView.h"
#import "NetWorkTool.h"
#import "bannerModel.h"
#import "messageModel.h"
#import "productModel.h"
#import "ProductDetailViewController.h"
#import "BWebViewController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout,TXScrollLabelViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;

//@property (nonatomic, strong)bannerModel *bannermodel;//顶部三张图model
//@property (nonatomic, strong)messageModel *messagemodel;//顶部跑马灯model
//@property (nonatomic, strong)productModel *productmodel;//列表数据

@property (nonatomic, strong)NSMutableArray *bannerarr;//顶部三张图
@property (nonatomic, strong)NSMutableArray *messagearr;//顶部跑马灯
@property (nonatomic, strong)NSMutableArray *productarr;//列表数据


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"贷款超市";
    
    //广告页面跳转
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(alPushToAdvert:) name:@"ZLPushToAdvert" object:nil];
    
    [self homedata];
    [self initView];
    
    
}


//h首页数据源
-(void)homedata{
    
    [[NetWorkTool shareInstance] postWithUrl:MEMEBER_HOMEDATA paramWithDic:nil success:^(id  _Nonnull responseObject) {
        
        //        NSLog(@"%@",responseObject);
        self.bannerarr = [bannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"bannerList"]];
        self.messagearr = [messageModel mj_objectArrayWithKeyValuesArray:responseObject[@"messageList"]];
        self.productarr = [productModel mj_objectArrayWithKeyValuesArray:responseObject[@"productList"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        
        
        //存储首页信息信息到本地
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:responseObject] forKey:@"homeData"];
        [defaults synchronize];
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        //请求不到数据，拿到本地存储数据
        NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"homeData"];
        id homeData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        //在这里解档
        self.bannerarr = [bannerModel mj_objectArrayWithKeyValuesArray:homeData[@"bannerList"]];
        self.messagearr = [messageModel mj_objectArrayWithKeyValuesArray:homeData[@"messageList"]];
        self.productarr = [productModel mj_objectArrayWithKeyValuesArray:homeData[@"productList"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        
    }];
    
}

-(void)initView{
    
    //单元格的大小
    UICollectionViewFlowLayout *historylayout = [[UICollectionViewFlowLayout alloc] init];
    [historylayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    historylayout.minimumLineSpacing = 0;                          //最小行间距
    historylayout.minimumInteritemSpacing = 0;                     //最小列间距
    historylayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);  //网格上左下右间距
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavHeight) collectionViewLayout:historylayout];
    [_collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"HomeCell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //_collectionView的代理方法
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    //    这是头部的注册
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    
    __weak typeof(self) weakSelf = self;
    //默认block方法：设置下拉刷新
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf homedata];
    }];
    
    //默认block方法：设置上拉加载更多(因为没有上拉加载更多，所以直接显示endRefreshingWithNoMoreData)
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }];
    
    
    
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _productarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HomeCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.productmodel = _productarr[indexPath.row];
    
    if (indexPath.row == 0) {
        
        cell.linelabel1.hidden = NO;
        cell.linelabel2.hidden = NO;
        cell.linelabel3.hidden = NO;
        
    }else if (indexPath.row == 1){
        
        cell.linelabel1.hidden = NO;
        cell.linelabel2.hidden = NO;
        cell.linelabel3.hidden = NO;
        
    }else{
        cell.linelabel1.hidden = YES;
        cell.linelabel2.hidden = NO;
        cell.linelabel3.hidden = NO;
        
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, kScreenWidth/4+150+30+50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerId" forIndexPath:indexPath];
    headerView.tag = 1000+indexPath.section;
    headerView.backgroundColor = [UIColor whiteColor];
    
    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    
    [self initHeaderView:headerView];
    
    return headerView;
}

//创建头部视图
-(void)initHeaderView:(UIView *)view{
    
    //    第一部分
    NSArray *textarr = @[@"新品速递",@"极速贷款",@"急用钱",@"信用卡"];
    NSArray *imgarr = @[@"首页-新品速递",@"首页-极速贷款",@"首页-急用钱",@"首页-信用卡"];
    for (int i=0; i<textarr.count; i++) {
        
        UIView *arrview = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth/4)*i, 0, kScreenWidth/4, kScreenWidth/4)];
        [view addSubview:arrview];
        arrview.tag = 1000+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAction:)];
        [arrview addGestureRecognizer:tap];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((arrview.width-36)/2, 20, 36, 36)];
        [arrview addSubview:imageView];
        imageView.image = [UIImage imageNamed:imgarr[i]];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom+5, arrview.width, 20)];
        [arrview addSubview:label];
        label.text = textarr[i];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
    }
    //    第二部分
    UIView *imagearrView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenWidth/4, kScreenWidth, 150)];
    [view addSubview:imagearrView];
    
    bannerModel *onemode;
    bannerModel *twomode;
    bannerModel *threemode;
    if (_bannerarr.count != 0) {
        
        onemode = self.bannerarr[0];
        twomode = self.bannerarr[1];
        threemode = self.bannerarr[2];
    }
    
    UIButton *oneimageView = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, imagearrView.height, imagearrView.height)];
    [imagearrView addSubview:oneimageView];
    //    [oneimageView sd_setImageWithURL:[NSURL URLWithString:onemode.picUrl]];
    [oneimageView sd_setImageWithURL:[NSURL URLWithString:onemode.picUrl] forState:UIControlStateNormal];
    oneimageView.tag = 100;
    oneimageView.layer.masksToBounds = YES;
    oneimageView.layer.cornerRadius =4;
    
    
    UIButton *twoimageView = [[UIButton alloc]initWithFrame:CGRectMake(oneimageView.right+10, 0, imagearrView.width-40-imagearrView.height, (imagearrView.height-10)/2)];
    [imagearrView addSubview:twoimageView];
    //    [twoimageView sd_setImageWithURL:[NSURL URLWithString:twomode.picUrl]];
    [twoimageView sd_setImageWithURL:[NSURL URLWithString:twomode.picUrl] forState:UIControlStateNormal];
    twoimageView.tag = 101;
    twoimageView.layer.masksToBounds = YES;
    twoimageView.layer.cornerRadius =4;
    
    
    UIButton *threeimageView = [[UIButton alloc]initWithFrame:CGRectMake(oneimageView.right+10, twoimageView.bottom+10, imagearrView.width-40-imagearrView.height, (imagearrView.height-10)/2)];
    [imagearrView addSubview:threeimageView];
    //    [threeimageView sd_setImageWithURL:[NSURL URLWithString:threemode.picUrl]];
    [threeimageView sd_setImageWithURL:[NSURL URLWithString:threemode.picUrl] forState:UIControlStateNormal];
    threeimageView.tag = 102;
    threeimageView.layer.masksToBounds = YES;
    threeimageView.layer.cornerRadius =4;
    
    
    [oneimageView addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
    [twoimageView addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
    [threeimageView addTarget:self action:@selector(clickBanner:) forControlEvents:UIControlEventTouchUpInside];
    
    //    第三部分
    UIView *scrollView = [[UIView alloc]initWithFrame:CGRectMake(0, imagearrView.bottom, kScreenWidth, 30)];
    [view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 50, scrollView.height)];
    [scrollView addSubview:label];
    label.text = @"最新动态";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"#FFBC00"];
    NSMutableArray *scrollTexts = [NSMutableArray array];
    
    for (messageModel *model in _messagearr) {
        [scrollTexts addObject:model.message];
    }
    
    TXScrollLabelView *scrollLabelView = [TXScrollLabelView scrollWithTextArray:scrollTexts type:TXScrollLabelViewTypeFlipNoRepeat velocity:2 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    scrollLabelView.scrollLabelViewDelegate = self;
    scrollLabelView.frame = CGRectMake(label.right +10, 0, kScreenWidth - label.width - 40, scrollView.height);
    [scrollView addSubview:scrollLabelView];
    scrollLabelView.font = [UIFont systemFontOfSize:12];
    scrollLabelView.textAlignment = NSTextAlignmentLeft;
    scrollLabelView.scrollSpace = 5;
    scrollLabelView.scrollTitleColor = [UIColor colorWithHexString:@"#333333"];
    scrollLabelView.backgroundColor = [UIColor clearColor];
    
    [scrollLabelView beginScrolling];
    
    //    第四部分
    UIView *textView = [[UIView alloc]initWithFrame:CGRectMake(0, scrollView.bottom, kScreenWidth, 50)];
    [view addSubview:textView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    [textView addSubview:lineView];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    UIView *yellowView = [[UIView alloc]initWithFrame:CGRectMake(15, 20, 3, 14)];
    [textView addSubview:yellowView];
    yellowView.backgroundColor = [UIColor colorWithHexString:@"#FFED21"];
    
    UILabel *recommendedlabel = [[UILabel alloc]initWithFrame:CGRectMake(yellowView.right+15, 5, 120, 45)];
    [textView addSubview:recommendedlabel];
    recommendedlabel.text = @"热门推荐";
    recommendedlabel.font = [UIFont systemFontOfSize:15];
    recommendedlabel.textColor = [UIColor blackColor];
    
    
}
//点击3张Banner图
-(void)clickBanner:(UIButton *)btn{
    
    bannerModel *model = _bannerarr[btn.tag-100];
    if ([model.jumpType isEqualToString:@"1"]) {
        
        
        BWebViewController *web = [[BWebViewController alloc]init];
        web.mainUrl = model.picUrl;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }else if ([model.jumpType isEqualToString:@"2"]){
        ProductDetailViewController *detail = [[ProductDetailViewController alloc]init];
        detail.model = model;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
}

//点击跑马灯
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    messageModel *model = _messagearr[index];
    NSLog(@"%@--%ld----%@",text, index,model.jumpType);
    if ([model.jumpType isEqualToString:@"1"]) {
        
        BWebViewController *web = [[BWebViewController alloc]init];
        web.mainUrl = model.picUrl;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }else if ([model.jumpType isEqualToString:@"2"]){
        ProductDetailViewController *detail = [[ProductDetailViewController alloc]init];
        detail.model = model;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/2, 63);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击cell");
    productModel *model =  _productarr[indexPath.row];
    if ([model.hasDatail isEqualToString:@"2"]) {
        
        if ([model.jumpType isEqualToString:@"1"]) {
            BWebViewController *web = [[BWebViewController alloc]init];
            web.mainUrl = model.jumpUrl;
            web.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:web animated:YES];
            
        }else if ([model.jumpType isEqualToString:@"2"]){
            
            NSString *openURL = model.jumpUrl;
            NSURL *URL = [NSURL URLWithString:openURL];
            [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:nil];
            
            
        }
        
        
    }else if ([model.hasDatail isEqualToString:@"1"]){
        ProductDetailViewController *detail = [[ProductDetailViewController alloc]init];
        detail.model = model;
        detail.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detail animated:YES];
    }
    
    
}





//跳转广告
-(void)alPushToAdvert:(NSNotification *)noti{
    
    NSString *url = noti.object;
    BWebViewController *web = [[BWebViewController alloc]init];
    web.mainUrl = url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}

//点击顶部4个按钮
- (void)selectAction:(UITapGestureRecognizer *)recognizer{
    
    UIView *toast = recognizer.view;
    NSLog(@"123==%ld",(long)toast.tag);
    
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"productTypeList"];
    //在这里解档
    NSMutableArray *productTypeList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSDictionary *dic;
    if (toast.tag == 1000) {
        dic = productTypeList[0];
        
    }else if (toast.tag == 1001){
        
        dic = productTypeList[1];
    }else if (toast.tag == 1002){
        
        dic = productTypeList[2];
    }else if (toast.tag == 1003){
        
        dic = productTypeList[3];
    }
    
    self.tabBarController.selectedIndex = 1;
    
    //  等self.tabBarController.selectedIndex = 1那边创建完成之后在开始d发通知
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"productType" object:dic userInfo:nil];
    });
    
    //存储全部产品的产品类型参数到本地
    //    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    //    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:dic] forKey:@"productType"];
    //    [defaults synchronize];
    
}


@end
