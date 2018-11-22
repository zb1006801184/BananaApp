//
//  HomeCell.h
//  Banana
//
//  Created by 曾勇 on 2018/11/18.
//

#import <UIKit/UIKit.h>
#import "productModel.h"

@interface HomeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *borrowNOlabel;

@property (nonatomic, strong)productModel *productmodel;

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;

@property (weak, nonatomic) IBOutlet UILabel *linelabel1;

@property (weak, nonatomic) IBOutlet UILabel *linelabel2;

@property (weak, nonatomic) IBOutlet UILabel *linelabel3;

@end
