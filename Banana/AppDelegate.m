//
//  AppDelegate.m
//  Banana
//
//  Created by 朱标 on 2018/11/17.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "ZLAdvertView.h"

@interface AppDelegate ()


//广告图
@property (nonatomic, strong) ZLAdvertView *zladvertView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    TabBarViewController *tabBarVC = [[TabBarViewController alloc]init];
    self.window.rootViewController = tabBarVC;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [[UINavigationBar appearance] setTranslucent:NO];
    [self.window makeKeyWindow];
    //    广告页
    [self Bootadvertising];
    
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
//    [self _shufflingdata];
}


////广告图数据
//-(void)_shufflingdata
//{
//    [self.zladvertView showtimer];
//
//}
-(void)startimg
{
    _zladvertView = [[ZLAdvertView alloc]initWithFrame:self.window.bounds];
    [self.window addSubview:_zladvertView];
}



@end
