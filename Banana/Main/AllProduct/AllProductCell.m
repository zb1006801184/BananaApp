//
//  AllProductCell.m
//  Banana
//
//  Created by 曾勇 on 2018/11/18.
//

#import "AllProductCell.h"

@implementation AllProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"16.4万人已放贷"];
//    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FFBC00"] range:NSMakeRange(0, 5)];
//    _borrowNOlabel.attributedText = string;
    
}


-(void)setProductmodel:(productModel *)productmodel{
    
    _productmodel = productmodel;
    [_imageview sd_setImageWithURL:[NSURL URLWithString:productmodel.logo]];
    _namelabel.text = productmodel.name;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人已放贷",productmodel.realApplyPersonNum]];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FFBC00"] range:NSMakeRange(0, productmodel.realApplyPersonNum.length)];
    _borrowNOlabel.attributedText = string;
    
    _sloganlabel.text = productmodel.slogan;
    
}


@end
