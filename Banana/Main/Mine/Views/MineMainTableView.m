//
//  MineMainTableView.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineMainTableView.h"
#import "MineMainTableViewCell.h"
#import "MineMaterialViewController.h"
@interface MineMainTableView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation MineMainTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineMainTableViewCell *cell = [MineMainTableViewCell configCellWith:tableView];
    if (_dataList.count > 0) {
        NSDictionary *modelDic = _dataList[indexPath.section][indexPath.row];
        cell.titleLabel.text = modelDic[@"title"];
        cell.imageView.image = [UIImage imageNamed:modelDic[@"image"]];
    }
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 21;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 21)];
    view.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineMaterialViewController *mine = [[MineMaterialViewController alloc]init];
    if (indexPath.section == 0 && indexPath.row == 0) {
        mine.hidesBottomBarWhenPushed = YES;
        [[BSomeWays getCurrentVC].navigationController pushViewController:mine animated:YES];
    }
}
- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;
    [self reloadData];
}
@end
