//
//  popUpView.h
//  Banana
//
//  Created by tdr on 2018/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface popUpView : UIView<UIGestureRecognizerDelegate,UICollectionViewDataSource,UICollectionViewDelegate
,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *borrowTypeArr;//种类数据源

@property (nonatomic, strong)NSArray *yearArr;//金额和日期数据源

@property (nonatomic, strong)NSString *textstr;//按钮上面的文字

@end

NS_ASSUME_NONNULL_END
