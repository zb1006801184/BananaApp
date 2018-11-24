//
//  MineIdeaViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineIdeaViewController.h"

@interface MineIdeaViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@end

@implementation MineIdeaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
}

- (IBAction)sureClick:(id)sender {
    if (_contentTextView.text.length < 1) {
        [self.view makeToast:@"请输入反馈意见" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (_phoneTextField.text.length < 1) {
        [self.view makeToast:@"请输入联系方式" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    [MineRequest ideaWithContactMsg:_phoneTextField.text content:_contentTextView.text success:^(id  _Nonnull responseObject) {
        [self.view makeToast:@"感谢您的意见反馈!!!" duration:2 position:CSToastPositionCenter];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError * _Nonnull error) {
        
    }];

    
}
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView;
{
    _titleLabel.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
        if (textView.text.length > 0) {
            _titleLabel.hidden = YES;
        }else {
            _titleLabel.hidden = NO;
        }
}




@end
