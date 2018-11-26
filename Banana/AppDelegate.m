//
//  AppDelegate.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "ZLAdvertView.h"
#import "NetWorkTool.h"
#import "LoginViewController.h"
#import "BAliyunOSS.h"
#import <UMCommon/UMCommon.h>
#import <GTSDK/GeTuiSdk.h>
#import <Bugly/Bugly.h>


//友盟appkey
static NSString * const  UmengAppkey = @"5bd94ebdb465f5a5d300004f";
//个推
#define kGtAppId           @"sPnERM9H7I9rsZJs4VvQD8"
#define kGtAppKey          @"GqkE9dihaX5ndWshF3fhw9"
#define kGtAppSecret       @"yOUgWv1xGr7gJHcwqTgQx1"

@interface AppDelegate ()<GeTuiSdkDelegate>

//广告图
@property (nonatomic, strong) ZLAdvertView *zladvertView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isLogin = [defaults objectForKey:@"login"];
    if (isLogin) {
        TabBarViewController *tabBarVC = [[TabBarViewController alloc]init];
        self.window.rootViewController = tabBarVC;
    }else {
        //去登录
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        nav.navigationBar.barTintColor = [UIColor colorWithHexString:@"#232323"]; //导航栏的颜色
        NSDictionary *dic=@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
        [nav.navigationBar setTitleTextAttributes:dic];
        self.window.rootViewController = nav;
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTranslucent:NO];
    [self.window makeKeyWindow];
    //    广告页
    [self Bootadvertising];
    [[BAliyunOSS sharedInstance] setupEnvironment];
    [[UITabBar appearance] setTranslucent:NO];//iOS 12.1 tabbar从二级页面返回跳动问题的解决方法
    
    //友盟统计
    [UMConfigure initWithAppkey:UmengAppkey channel:@"App Store"];
    
    //bugly
    [Bugly startWithAppId:@"8a20aae718"];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 广告图
-(void)Bootadvertising{
    
    
    //    自定义启动图和启动图数据
    [self startimg];
    [self _shufflingdata];
}


//广告图数据
-(void)_shufflingdata
{
    [[NetWorkTool shareInstance] postWithUrl:MEMEBER_startShow paramWithDic:nil success:^(id  _Nonnull responseObject) {
        NSString *Img = responseObject[@"imgUrl"];
        NSString *Web = responseObject[@"adUrl"];
        
        if ([Img isEqual:[NSNull null]]||[Img isEqualToString:@"#"]) {
            Img = @"";
        }
        if ([Web isEqual:[NSNull null]]||[Web isEqualToString:@"#"]) {
            Web = @"";
        }
        
        if (![Img isEqualToString:@""]) {
            
            self.zladvertView.detailsbtn.hidden = NO;
            [self.zladvertView showtimer];
            [self.zladvertView.starimg sd_setImageWithURL:[NSURL URLWithString:Img]];
            if ([Web isEqualToString:@""]) {
                self.zladvertView.detailsbtn.hidden = YES;
            }
            
        }else{
            [self.zladvertView removeAdvertView];
            
        }
        
        self.zladvertView.imgurl = Web;
        
        //存储全部产品的产品类型到本地
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:responseObject[@"productTypeList"]] forKey:@"productTypeList"];
        [defaults synchronize];
        
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [self.zladvertView removeAdvertView];
        
    }];
    
}
-(void)startimg
{
    _zladvertView = [[ZLAdvertView alloc]initWithFrame:self.window.bounds];
    [self.window.rootViewController.view addSubview:_zladvertView];
}


    /** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
//        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
//        center.delegate = self;
//        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
//            if (!error) {
//                NSLog(@"request authorization succeeded!");
//            }
//        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

    /** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // [3]:向个推服务器注册deviceToken 为了方便开发者，建议使用新方法
    [GeTuiSdk registerDeviceTokenData:deviceToken];
}

    /** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [UserModel saveCid:clientId];
}

@end


