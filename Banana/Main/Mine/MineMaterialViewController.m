//
//  MineMaterialViewController.m
//  Banana
//
//  Created by 朱标 on 2018/11/18.
//

#import "MineMaterialViewController.h"
#import "SetUserNameViewController.h"
#import "BAliyunOSS.h"
#import "API.h"

@interface MineMaterialViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    OSSClient *client;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (nonatomic, strong) NSString *objecKey;

@end

@implementation MineMaterialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人资料";
    [self loadDataForViews];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(postImage) name:@"postImage" object:nil];

}
- (void)loadDataForViews {
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 23.5;
    UserModel *model = [UserModel getUserModel];
    self.userNameLabel.text = model.username;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"身份认证"]];
}
- (IBAction)headImageClick:(id)sender {
   
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选取", nil];
    [sheet showInView:self.view];
}

- (IBAction)userNameClick:(id)sender {
    SetUserNameViewController *userName = [[SetUserNameViewController alloc]init];
    __weak typeof(self)weekSelf = self;
    userName.callBackUserName = ^(NSString * _Nonnull userName) {
        weekSelf.userNameLabel.text = userName;
    };
    [self.navigationController pushViewController:userName animated:YES];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = 0;
    if (buttonIndex == 0) {
        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;

    }else if (buttonIndex == 1) {
        //从照片中选取
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else {
        return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];

}

//返回的图片数据
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //返回到主界面中
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    //获取返回的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //压缩图片
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //沙盒，准备保存的图片地址和图片名称
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"x.jpg"];
    
    //将图片写入文件中
    [imageData writeToFile:fullPath atomically:NO];
    
    //通过路径获取到保存的图片，可以在主界面上的image进行预览
//    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    
    
    //将图片变为Base64格式，可以将数据通过接口传给后台
//    NSData *data = UIImageJPEGRepresentation(saveImage, 1.0f);
//    NSString *baseString = [data base64Encoding];
    [self uploadImage:imageData];
}
//关闭拍照窗口
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (void)uploadImage:(NSData *)imageData {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@",str];
    NSString *objectKey = [NSString stringWithFormat:@"Banana%@.png",fileName];
    _objecKey = [NSString stringWithFormat:@"%@%@",imagesFace,objectKey];
    [[BAliyunOSS sharedInstance] uploadObjectAsyncWith:imageData withObjectKey:objectKey withAlbumNumber:nil];
}

- (void)postImage {
    //上传成功
    __weak typeof(self)weekStyle = self;
    [MineRequest changeImageWithHeadFile:_objecKey success:^(id  _Nonnull responseObject) {
        UserModel *model = [UserModel getUserModel];
//        model.headImg = [NSString stringWithFormat:@"https://loan-market-pics.oss-cn-hangzhou.aliyuncs.com/%@",weekStyle.objecKey];
        model.headImg = [NSString stringWithFormat:@"https://%@.%@/%@",Bucket,endPoint,weekStyle.objecKey];

        [UserModel saveUserModelWithObject:model];
        [weekStyle.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:nil];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
