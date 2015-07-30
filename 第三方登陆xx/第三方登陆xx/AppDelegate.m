//
//  AppDelegate.m
//  disanfang
//
//  Created by zhanghong on 15/4/17.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "AppDelegate.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboApi.h"
#import "WeiboSDK.h"
#import <BaiduMapAPI/BMapKit.h>
#import "ZHNewFeaturesController.h"
#import "customNavigationController.h"
#import "ZHHomeTableViewController.h"
#import "SDWebImageManager.h"
#import "LoginViewController.h"
#define PreiousVersion [[NSUserDefaults standardUserDefaults] objectForKey:@"preiousVersion"]
#define CurrentVersion ([NSBundle mainBundle].infoDictionary)[@"CFBundleShortVersionString"]
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
//    mgr.imageCache.maxMemoryCost = 10240*10;
//    [SDImageCache sharedImageCache].maxMemoryCost = 10240*10;
    
    [ShareSDK registerApp:@"6cbf75e70463"];
    [ShareSDK connectQZoneWithAppKey:@"1104542574" appSecret:@"cVNsmBSPQRU9Maln"  qqApiInterfaceCls:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    [ShareSDK connectSinaWeiboWithAppKey:@"1068761365" appSecret:@"45528fed0ad15d4225fa6691ecc32184" redirectUri:@"http://www.baidu.com" weiboSDKCls:[WeiboApi class]];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if ([CurrentVersion isEqualToString:PreiousVersion]) {

        LoginViewController *loginViewcontroller = [[LoginViewController alloc] init];
        
        window.rootViewController = [[customNavigationController alloc] initWithRootViewController:loginViewcontroller];
    }else{
        [userDefaults setObject:CurrentVersion forKey:@"preiousVersion"];
        [userDefaults synchronize];
        window.rootViewController = [[ZHNewFeaturesController alloc] init];
    }
    
    [window makeKeyAndVisible];
    self.window = window;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cancelAll];
    NSLog(@"zzzz");
    [manager.imageCache clearMemory];
    //[manager.imageCache clearDisk];
    
}
@end
