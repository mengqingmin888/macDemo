//
//  AppDelegate.m
//  ZhongHuaXiaoDangJia
//
//  Created by 東哥 on 14-9-18.
//  Copyright (c) 2014年 夏东. All rights reserved.
//

#import "AppDelegate.h"

#import "FoodTreatmentViewController.h"

#import "HomePageViewController.h"
#import "DDMenuController.h"
#import "LeftMenuViewController.h"

#import "FirstLoginViewController.h"

#import "UMSocialSinaHandler.h"

#import "UMSocial.h"

#import "UMSocialWechatHandler.h"

#import "UMSocialQQHandler.h"

#import "Reachability.h"

#import "KGStatusBar.h"


#import "FoodCollectViewController.h"
@implementation AppDelegate

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    self.window = nil;
    self.menuController = nil;
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[NSNotificationCenter  defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityForInternetConnection];
    [self.hostReach startNotifier];
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self loaderViewController];
    
    
    [UMSocialData openLog:NO];
    
    
    [UMSocialData setAppKey:@"5423d1d8fd98c58eb8001a6a"];
    
    //友盟AppKey  5423d1d8fd98c58eb8001a6a
    
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。若在新浪后台设置我们的回调地址，“http://sns.whalecloud.com/sina2/callback”，这里可以传nil
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx38c22debe16eee02" appSecret:@"78b5e1a89fe53035f08ed927bdce0cd6" url:@"http://www.lanou3g.com"];
    
    
    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100308348" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.lanou3g.com"];
    //支持没有客户端的情况下可以使用
    [UMSocialQQHandler setSupportWebView:YES];
    
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];//黑体白字
    
    
//    [application setStatusBarStyle:UIStatusBarStyleDefault];//黑体黑字
    
//      [application setStatusBarHidden:YES];//隐藏状态栏
    
    
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//设置屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);//不支持倒转
    return (interfaceOrientation != UIInterfaceOrientationLandscapeLeft);//不支持左转
    return (interfaceOrientation != UIInterfaceOrientationLandscapeRight);//不支持右转
    
    
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);//只支持正转
    
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}


- (void)loaderViewController
{
    NSUserDefaults * firstLogin = [NSUserDefaults standardUserDefaults];
    BOOL isFirstTimeLogin =[firstLogin boolForKey:kIsFirstTimeLogin];
    
    if (NO== isFirstTimeLogin) {
        FirstLoginViewController * firstVC = [[FirstLoginViewController alloc]init];
        self.window.rootViewController = firstVC;
        [firstVC release];
        
        [firstLogin setBool:YES forKey:kIsFirstTimeLogin];
        //同步
        [firstLogin synchronize];
        return;
    }
    //已经登录过了
    [self setupViewController];

}

//创建根视图
- (void)setupViewController
{
    HomePageViewController * homeVC = [[HomePageViewController alloc]init];
    
    UINavigationController  * homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    //设置导航栏字体颜色
    UIColor * color = [UIColor whiteColor];
    //UIFont * font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0];
    NSDictionary * dic = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    homeNC.navigationBar.titleTextAttributes = dic;
    
    
    LeftMenuViewController  * leftMenuVC = [[LeftMenuViewController alloc] init];
    
    self.menuController = [[DDMenuController alloc] initWithRootViewController:homeNC];
    
    
    
    FoodCollectViewController  * foodCollectVC = [[FoodCollectViewController alloc] init];
    
    UINavigationController  * foodCollectNC = [[UINavigationController alloc] initWithRootViewController:foodCollectVC];

    self.menuController.rootVCS =[NSMutableArray arrayWithObjects:homeNC,foodCollectNC, nil];
    
    
    
    
    self.menuController.leftViewController = leftMenuVC;
     
    self.window.rootViewController = self.menuController;
    
    
    
    //[homeVC release];
    //[homeNC release];
    
}

- (void)reachabilityChanged:(NSNotification *)note{
    Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    /*switch (status)
     {
     case NotReachable:        {
     
     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"逗比没有网络" message:@"逗比请打开网络" delegate:nil cancelButtonTitle:@"你才是逗比" otherButtonTitles:nil];;
     [alert show];
     [alert release];
     
     break;
     }
     
     case ReachableViaWWAN:        {
     
     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络已连接" message:@"你才是逗比" delegate:nil cancelButtonTitle:@"你才是逗比" otherButtonTitles:nil];;
     //[alert show];
     [alert release];
     break;
     }
     case ReachableViaWiFi:        {
     
     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络已连接" message:@"你才是逗比" delegate:nil cancelButtonTitle:@"你才是逗比" otherButtonTitles:nil];;
     //[alert show];
     [alert release];
     break;
     }
     }*/
    
    if (status == NotReachable) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"网络断开" message:@"请检查网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];;
        [alert show];
        [alert release];
    }/**/else{
        
        [KGStatusBar showSuccessWithStatus:@"网络已经连接,请刷新"];
        
        
      }
    
}








- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
