//
//  popUpView.m
//  Banana
//
//  Created by tdr on 2018/11/19.
//

#import "popUpView.h"
#import "popUpCell.h"

@implementation popUpView

- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:.6];
        [self uiConfigure];
    }
    return self;
}

-(void)setBorrowTypeArr:(NSArray *)borrowTypeArr{
    
    _borrowTypeArr = borrowTypeArr;
    
    [self.collectionView reloadData];
    _collectionView.frame = CGRectMake(0, 0, kScreenWidth, 40+40*((_borrowTypeArr.count-1)%2==0?(_borrowTypeArr.count-1)/2:(_borrowTypeArr.count-1)/2+1));
}

#pragma mark  UI布局
- (void)uiConfigure {
    
    UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backHidden)];
    [self addGestureRecognizer:click];
    click.delegate = self;
    
    //单元格的大小
    UICollectionViewFlowLayout *historylayout = [[UICollectionViewFlowLayout alloc] init];
    [historylayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    historylayout.minimumLineSpacing = 0;                          //最小行间距
    historylayout.minimumInteritemSpacing = 0;                     //最小列间距
    historylayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);  //网格上左下右间距
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180) collectionViewLayout:historylayout];
    [_collectionView registerClass:[popUpCell class] forCellWithReuseIdentifier:@"popUpCell"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    //_collectionView的代理方法
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self addSubview:_collectionView];
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
    
    return _borrowTypeArr.count-1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"popUpCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    popUpCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.textlabel.text = _borrowTypeArr[indexPath.row+1];
        
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(kScreenWidth, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerId" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    
    for (UIView *view in headerView.subviews) {
        [view removeFromSuperview];
    }
    
    UIButton *selectedbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectedbtn.frame = CGRectMake(15, 0, 300, 39);
    selectedbtn.backgroundColor = [UIColor clearColor];
    [headerView addSubview:selectedbtn];
    selectedbtn.titleLabel.font = [UIFont systemFontOfSize: 10];
    [selectedbtn setTitle:_borrowTypeArr[0] forState:UIControlStateNormal];
    [selectedbtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [selectedbtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    selectedbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    

    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(15, selectedbtn.bottom, kScreenWidth-15, 0.5)];
    [headerView addSubview:lineview];
    lineview.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];

    
    return headerView;
}


//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth/2, 40);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"popUpView" object:_borrowTypeArr[indexPath.row]];
    self.hidden = YES;

}

-(void)action:(UIButton *)btn{
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"popUpView" object:btn.titleLabel.text];
    self.hidden = YES;
}

-(void)backHidden{
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"popUpView" object:nil];
    self.hidden = YES;
    

}

//让imageView不响应父视图点击事件
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if([touch.view isDescendantOfView:self.collectionView]){
        return NO;
    }
    return YES;
    
}

@end
