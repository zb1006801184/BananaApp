//
//  AllProductViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "AllProductViewController.h"
#import "AllProductCell.h"
#import "BConstant.h"
@interface AllProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation AllProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"全部产品";
    
    [self initView];
    
}


-(void)initView{
    
    //单元格的大小
    UICollectionViewFlowLayout *historylayout = [[UICollectionViewFlowLayout alloc] init];
    [historylayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    historylayout.minimumLineSpacing = 0;                          //最小行间距
    historylayout.minimumInteritemSpacing = 0;                     //最小列间距
    historylayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);  //网格上左下右间距
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavHeight) collectionViewLayout:historylayout];
    [_collectionView registerClass:[AllProductCell class] forCellWithReuseIdentifier:@"AllProductCell"];
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
    static NSString *identifier = @"AllProductCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    AllProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    [self setBorderWithView:cell top:YES left:NO bottom:NO right:YES borderColor:[UIColor colorWithHexString:@"#bfbfbf"] borderWidth:.5];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 60);
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
    NSArray *textarr = @[@"贷款类型",@"贷款金额",@"贷款期限"];
    for (int i=0; i<textarr.count; i++) {
        
        UIView *arrview = [[UIView alloc]initWithFrame:CGRectMake((kScreenWidth/3)*i, 0, kScreenWidth/3, 60)];
        [view addSubview:arrview];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15, 15, arrview.width-30, 30);
        btn.backgroundColor = [UIColor colorWithHexString:@"#F3F3F3"];
        [arrview addSubview:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize: 11];
        [btn setTitle:textarr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 4.0;
        
    }
    
}



//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/2, 80);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击cell");
    [_collectionView reloadData];
    
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
