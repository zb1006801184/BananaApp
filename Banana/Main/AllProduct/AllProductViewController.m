//
//  AllProductViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "AllProductViewController.h"
#import "AllProductCell.h"
#import "BConstant.h"
#import "popUpView.h"
#import "NetWorkTool.h"
#import "productModel.h"

@interface AllProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout>

//下面三个字符串记录选中的三个条件
@property (nonatomic, strong)NSString *oneSelectedStr;
@property (nonatomic, strong)NSString *twoSelectedStr;
@property (nonatomic, strong)NSString *threeSelectedStr;
@property (nonatomic, assign)NSInteger btntag;//记录上一个按钮是点击的第几个

//下面3个是3个选项卡的数据源
@property (nonatomic, strong)NSMutableArray *oneborrowTypeArr;
@property (nonatomic, strong)NSArray *twoborrowTypeArr;
@property (nonatomic, strong)NSArray *threeborrowTypeArr;


@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)popUpView *popUpview;//顶部下拉视图

@property (nonatomic, strong)NSMutableArray *productarr;//列表数据

//接口请求参数
@property (nonatomic, strong)NSString *pageNo;//页码
@property (nonatomic, strong)NSString *pageNum;//每页显示的数量
@property (nonatomic, strong)NSString *type;//产品类型
@property (nonatomic, strong)NSString *minMoney;//最小可贷金额
@property (nonatomic, strong)NSString *maxMoney;//最大可贷金额
@property (nonatomic, strong)NSString *minDuration;//最短贷款期限
@property (nonatomic, strong)NSString *maxDuration;//最长贷款期限


@end

@implementation AllProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    选中条件回调的通知
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(popUpselectedStr:) name:@"popUpView" object:nil];

    self.title = @"全部产品";
    _pageNo = @"1";
    _pageNum = @"100";
    _type = @"";
    _minMoney = @"";
    _maxMoney = @"";
    _minDuration = @"";
    _maxDuration = @"";
    
    
    _oneborrowTypeArr = [NSMutableArray array];
    NSData * data = [[NSUserDefaults standardUserDefaults]objectForKey:@"productTypeList"];
    //在这里解档
    NSMutableArray *productTypeList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSArray *cards = @[@{@"typeName":@"类型不限",@"typeValue":@""}];
    [_oneborrowTypeArr addObjectsFromArray:cards];
    [_oneborrowTypeArr addObjectsFromArray:productTypeList];
    
    _twoborrowTypeArr= @[@"金额不限",@"2000以下",@"2000-1万",@"1万-2万",@"2万以上"];
    _threeborrowTypeArr= @[@"期限不限",@"1个月以下",@"1-6个月",@"6-12个月",@"12个月以上"];

    
    [self initView];
    
    [self productdata];
    
}


//h首页数据源
-(void)productdata{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:_pageNo forKey:@"pageNo"];
    [dic setObject:_pageNum forKey:@"pageNum"];
    [dic setObject:_type forKey:@"type"];
    [dic setObject:_minMoney forKey:@"minMoney"];
    [dic setObject:_maxMoney forKey:@"maxMoney"];
    [dic setObject:_minDuration forKey:@"minDuration"];
    [dic setObject:_maxDuration forKey:@"maxDuration"];


    [[NetWorkTool shareInstance] postWithUrl:MEMEBER_products paramWithDic:dic success:^(id  _Nonnull responseObject) {
        
        self.productarr = [productModel mj_objectArrayWithKeyValuesArray:responseObject[@"productList"]];
        [self.collectionView reloadData];

    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}

//    选中条件回调的通知
-(void)popUpselectedStr:(NSNotification *)noti {
    NSLog(@"===%ld",_btntag);

    UIButton *selectedbtn = (UIButton *)[self.view viewWithTag:_btntag];
    selectedbtn.backgroundColor = [UIColor colorWithHexString:@"#FFDA44"];
    if (_btntag == 100) {
        
        NSDictionary *selectedstr = noti.object;
        NSLog(@"%@",selectedstr);
        [selectedbtn setTitle:selectedstr[@"typeName"] forState:UIControlStateNormal];
        _type = selectedstr[@"typeValue"];
    }else{
        
        NSString *selectedstr = noti.object;
        NSLog(@"%@",selectedstr);
        [selectedbtn setTitle:selectedstr forState:UIControlStateNormal];
        
        [self getDic:selectedstr];
    }
    
    [self productdata];
 

}


-(void)initView{
    
    NSArray *textarr = @[@"贷款类型",@"贷款金额",@"贷款期限"];
    for (int i=0; i<textarr.count; i++) {
        
        UIView *arrview = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth/3)*i, 0, kScreenWidth/3, 60)];
        [self.view addSubview:arrview];
        
        UIButton *selectedbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedbtn.frame = CGRectMake(15, 15, arrview.width-30, 30);
        selectedbtn.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        [arrview addSubview:selectedbtn];
        selectedbtn.titleLabel.font = [UIFont systemFontOfSize: 11];
        [selectedbtn setTitle:textarr[i] forState:UIControlStateNormal];
        [selectedbtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        selectedbtn.layer.cornerRadius = 4.0;
        [selectedbtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        selectedbtn.tag = 100+i;
        
    }

    
    //单元格的大小
    UICollectionViewFlowLayout *historylayout = [[UICollectionViewFlowLayout alloc] init];
    [historylayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    historylayout.minimumLineSpacing = 0;                          //最小行间距
    historylayout.minimumInteritemSpacing = 0;                     //最小列间距
    historylayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);  //网格上左下右间距
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-kNavHeight-60) collectionViewLayout:historylayout];
    [_collectionView registerClass:[AllProductCell class] forCellWithReuseIdentifier:@"AllProductCell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //_collectionView的代理方法
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    
}

//弹出下拉视图
-(void)action:(UIButton *)btn{
    _btntag = btn.tag;
    
    self.popUpview.borrowTypeArr = [NSMutableArray array];
    self.popUpview.yearArr = [NSMutableArray array];

    self.popUpview.hidden = NO;
    [self.view addSubview:self.popUpview];
    if (_btntag == 100) {
        self.popUpview.borrowTypeArr = _oneborrowTypeArr;
    }else if (_btntag == 101){
        self.popUpview.yearArr = _twoborrowTypeArr;
    }else if (_btntag == 102){
        self.popUpview.yearArr = _threeborrowTypeArr;
    }
}

#pragma mark - 顶部下拉视图
-(popUpView *)popUpview{
    
    if (_popUpview == nil) {
        
        _popUpview = [[popUpView alloc] init];
        _popUpview.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight);
    }
    
    return _popUpview;
    
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _productarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"AllProductCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    AllProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.productmodel = _productarr[indexPath.row];
    
    [self setBorderWithView:cell top:YES left:NO bottom:NO right:YES borderColor:[UIColor colorWithHexString:@"#bfbfbf"] borderWidth:.5];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/2, 80);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击cell");
    
}

//#pragma mark - 刷新带头视图的UICollectionView切记注意要这样刷新，防止重复创建headview，因为UICollectionView的head不会复用
//-(void)collectionViewreloadData{
//    UICollectionReusableView *cityheaderView = (UICollectionReusableView *)[_collectionView viewWithTag:1000];
//
//    for (UIView *view in cityheaderView.subviews) {
//        [view removeFromSuperview];
//    }
//    [_collectionView reloadData];
//}


- (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width
{
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

//回调处理日期和金额参数
-(void)getDic:(NSString *)selectedstr{
    
    if ([selectedstr isEqualToString:@"2000以下"]) {
        _minMoney = @"";
        _maxMoney = @"2000";
    }else if ([selectedstr isEqualToString:@"2000-1万"]){
        _minMoney = @"2000";
        _maxMoney = @"10000";
    }else if ([selectedstr isEqualToString:@"1万-2万"]){
        _minMoney = @"10000";
        _maxMoney = @"20000";
    }else if ([selectedstr isEqualToString:@"2万以上"]){
        _minMoney = @"20000";
        _maxMoney = @"";
    }else if ([selectedstr isEqualToString:@"1个月以下"]){
        _minDuration = @"";
        _maxDuration = @"30";
    }else if ([selectedstr isEqualToString:@"1-6个月"]){
        _minDuration = @"30";
        _maxDuration = @"180";
    }else if ([selectedstr isEqualToString:@"6-12个月"]){
        _minDuration = @"180";
        _maxDuration = @"360";
    }else if ([selectedstr isEqualToString:@"12个月"]){
        _minDuration = @"360";
        _maxDuration = @"0";
    }
}


@end
