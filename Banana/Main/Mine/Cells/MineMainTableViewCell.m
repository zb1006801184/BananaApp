//
//  MineMainTableViewCell.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineMainTableViewCell.h"

@implementation MineMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)configCellWith:(UITableView *)tableView {
    static NSString *cellID = @"MineMainTableViewCell";
    MineMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineMainTableViewCell" owner:self options:nil]firstObject];
    }
    return cell;
}

@end
