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

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout,TXScrollLabelViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"贷款超市";
    
    //广告页面跳转
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(alPushToAdvert) name:@"ZLPushToAdvert" object:nil];

    [self initView];
    
//    [[NetWorkTool shareInstance] postWithUrl:@"https://apptest.xiangjiaoqianbao.cn/indexShow/indexShow" paramWithDic:nil success:^(id  _Nonnull responseObject) {
//
//        NSLog(@"%@",responseObject);
//
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
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
    
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HomeCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [self setBorderWithView:cell top:YES left:NO bottom:NO right:YES borderColor:[UIColor colorWithHexString:@"#bfbfbf"] borderWidth:.5];
    
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
    
    UIImageView *oneimageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 0, imagearrView.height, imagearrView.height)];
    [imagearrView addSubview:oneimageView];
    oneimageView.image = [UIImage imageNamed:@"LOGO"];
    
    UIImageView *twoimageView = [[UIImageView alloc]initWithFrame:CGRectMake(oneimageView.right+10, 0, imagearrView.width-40-imagearrView.height, (imagearrView.height-10)/2)];
    [imagearrView addSubview:twoimageView];
    twoimageView.image = [UIImage imageNamed:@"LOGO"];
    
    UIImageView *threeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(oneimageView.right+10, twoimageView.bottom+10, imagearrView.width-40-imagearrView.height, (imagearrView.height-10)/2)];
    [imagearrView addSubview:threeimageView];
    threeimageView.image = [UIImage imageNamed:@"LOGO"];
    
    //    第三部分
    UIView *scrollView = [[UIView alloc]initWithFrame:CGRectMake(0, imagearrView.bottom, kScreenWidth, 30)];
    [view addSubview:scrollView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 50, scrollView.height)];
    [scrollView addSubview:label];
    label.text = @"最新动态";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor colorWithHexString:@"#FFBC00"];
    
    NSArray *scrollTexts = @[@"18327653567成功借贷5000元",
                             @"13967832332成功借贷4000元",
                             @"17055677654成功借贷8880元"];
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

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/2, 63);
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


//跳转广告
-(void)alPushToAdvert{
    
    NSLog(@"1111");

}


@end
