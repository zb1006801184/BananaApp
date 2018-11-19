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

@interface AllProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout>

//下面三个字符串记录选中的三个条件
@property (nonatomic, strong)NSString *oneSelectedStr;
@property (nonatomic, strong)NSString *twoSelectedStr;
@property (nonatomic, strong)NSString *threeSelectedStr;
@property (nonatomic, assign)NSInteger btntag;//记录上一个按钮是点击的第几个

//下面3个是3个选项卡的数据源
@property (nonatomic, strong)NSArray *oneborrowTypeArr;
@property (nonatomic, strong)NSArray *twoborrowTypeArr;
@property (nonatomic, strong)NSArray *threeborrowTypeArr;


@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)popUpView *popUpview;//顶部下拉视图


@end

@implementation AllProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    选中条件回调的通知
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(popUpselectedStr:) name:@"popUpView" object:nil];

    self.title = @"全部产品";
    
    _oneborrowTypeArr= @[@"类型不限",@"上班族1",@"上班族2",@"上班族3",@"上班族4",@"上班族5",@"上班族6"];
    _twoborrowTypeArr= @[@"金额不限",@"2000以下",@"2000-1万",@"1万-2万",@"2万以上"];
    _threeborrowTypeArr= @[@"期限不限",@"1个月以下",@"1-6个月",@"6-12个月",@"12个月以上"];

    
    [self initView];
    
}

//    选中条件回调的通知
-(void)popUpselectedStr:(NSNotification *)noti {
    self.collectionView.scrollEnabled = YES;
    NSString *selectedstr = noti.object;
    NSLog(@"%@",selectedstr);
    NSLog(@"===%ld",_btntag);

    if (selectedstr!=nil) {
        
        UIButton *selectedbtn = (UIButton *)[self.view viewWithTag:_btntag];
        selectedbtn.backgroundColor = [UIColor colorWithHexString:@"#FFDA44"];
        [selectedbtn setTitle:selectedstr forState:UIControlStateNormal];
   
    }

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
    
    self.collectionView.scrollEnabled = NO;

    self.popUpview.hidden = NO;
    [self.collectionView addSubview:self.popUpview];
    if (_btntag == 100) {
        self.popUpview.borrowTypeArr = _oneborrowTypeArr;
    }else if (_btntag == 101){
        self.popUpview.borrowTypeArr = _twoborrowTypeArr;
    }else if (_btntag == 102){
        self.popUpview.borrowTypeArr = _threeborrowTypeArr;
    }
}

#pragma mark - 顶部下拉视图
-(popUpView *)popUpview{
    
    if (_popUpview == nil) {
        
        _popUpview = [[popUpView alloc] init];
        _popUpview.frame = self.collectionView.bounds;
    }
    
    return _popUpview;
    
}




#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"AllProductCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    AllProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
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





@end
