//
//  AllProductCell.h
//  Banana
//
//  Created by 曾勇 on 2018/11/18.
//

#import <UIKit/UIKit.h>
#import "productModel.h"

@interface AllProductCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *borrowNOlabel;
@property (nonatomic, strong)productModel *productmodel;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;

@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *sloganlabel;

@end
