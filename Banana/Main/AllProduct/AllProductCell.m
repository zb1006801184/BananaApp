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
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"16.4万人已放贷"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FFBC00"] range:NSMakeRange(0, 5)];
    _borrowNOlabel.attributedText = string;
    
}

@end
