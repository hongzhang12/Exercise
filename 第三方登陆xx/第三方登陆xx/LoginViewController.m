//
//  LoginViewController.m
//  zhanghong
//
//  Created by zhanghong on 15/4/17.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "LoginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "ZHWeatherController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "MBProgressHUD+MJ.h"
#import "ZHAccountModel.h"
#import "ZHHomeTableViewController.h"
#import "ZHExtension.h"
#import "customNavigationController.h"
#import "ZHProgrossHUD.h"
#define ScreenBoundsWidth [UIScreen mainScreen].bounds.size.width
#define ScreenBoundsHeight [UIScreen mainScreen].bounds.size.height
#define AccountInfo [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) lastObject]stringByAppendingPathComponent:@"account.plist"]
@interface LoginViewController()<BMKLocationServiceDelegate,BMKGeneralDelegate>
@property (nonatomic ,strong) BMKLocationService *localPosition;
@property (nonatomic ,assign) bool isGetCurrentLocation;
@property (nonatomic ,weak) UIImageView *bg;
@property (nonatomic ,retain) BMKMapManager *mapManager;
@end
@implementation LoginViewController
- (void)viewDidLoad
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.mapManager = [[BMKMapManager alloc] init];
    if (![self.mapManager start:@"6SiyDbbeHDSRnaz2Tx8qsfnb" generalDelegate:self]) {
        NSLog(@"mapManager start failed");
    }
    
    self.title = @"登录";
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_na.jpg"]];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    self.bg = bg;

    CGFloat loginBtnW = 230;
    CGFloat loginBtnH = 50;
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenBoundsWidth-loginBtnW)/2, 300, loginBtnW, loginBtnH)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"RedButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 30, 15, 30)] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"RedButtonPressed.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 30, 15, 30)] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //loginBtn.isAccessibilityElement = YES;
    //NSLog(@"%d",loginBtn.isAccessibilityElement);
    loginBtn.accessibilityLabel = @"登录";
    //[loginBtn setBackgroundColor:[UIColor greenColor]];
    //[self.view addSubview:loginBtn];
    
    
    UIButton *QQLogin = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 50, 50)];
    [QQLogin setBackgroundImage:[UIImage imageNamed:@"account_qq_press"] forState:UIControlStateHighlighted];
    [QQLogin setBackgroundImage:[UIImage imageNamed:@"account_qq_normal"] forState:UIControlStateNormal];
    [QQLogin addTarget:self action:@selector(QQLoginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QQLogin];
    
    UIButton *weiboLogin = [[UIButton alloc] initWithFrame:CGRectMake(170, 300, 50, 50)];
    [weiboLogin setBackgroundImage:[UIImage imageNamed:@"account_weibo_press"] forState:UIControlStateHighlighted];
    [weiboLogin setBackgroundImage:[UIImage imageNamed:@"account_weibo_normal"] forState:UIControlStateNormal];
    [weiboLogin addTarget:self action:@selector(weiboLoginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboLogin];
    self.loginBtn = loginBtn;
}
#pragma mark -百度定位代理
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (self.isGetCurrentLocation) {
        [self getCurrentCity:userLocation];
    }
    //[self getCurrentCity:userLocation];
}

- (NSString *)getCurrentCity:(BMKUserLocation *)userLocation
{
    self.isGetCurrentLocation = NO;
    NSLog(@"zhanghong");
    //http://api.map.baidu.com/telematics/v3/reverseGeocoding?location=116.3017193083,40.050743859593&coord_type=gcj02&ak=E4805d16520de693a3fe707cdc962045     28.237148,long 112.885343
    NSString *city = [NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/reverseGeocoding?location=%lf,%lf&coord_type=gcj02&ak=6SiyDbbeHDSRnaz2Tx8qsfnb&mcode=123&output=json",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
    NSLog(@"%lf----%lf",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    //    @"http://api.map.baidu.com/telematics/v3/reverseGeocoding?location=116.3017193083,40.050743859593&coord_type=gcj02&ak=6SiyDbbeHDSRnaz2Tx8qsfnb&mcode=123&output=json"
    NSURL *url = [NSURL URLWithString:city];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:50.0];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data&&!connectionError) {
            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([json[@"city"] isEqualToString:@""]) {
                //[MBProgressHUD showError:@"获取位置失败"];
                
            }else{
                
                NSLog(@"%@",json[@"city"]);
                ZHWeatherController *weather = [[ZHWeatherController alloc] init];
                weather.title = json[@"city"];

                ZHHomeTableViewController *home = [[ZHHomeTableViewController alloc] init];
                
                [UIWindow switchRootViewController:[[customNavigationController alloc] initWithRootViewController:home]];
                [ZHProgrossHUD hidden];
            }
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //[MBProgressHUD showError:@"网络连接失败"];
            });
        }
    }];
    return nil;
}
- (void)loginBtnClicked
{

}

- (void)QQLoginBtnClicked{
    if ([ShareSDK hasAuthorizedWithType:ShareTypeQQSpace]) {
        [self startMap];
    }else{
        [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            
            [self saveAccount:userInfo];
            [self startMap];
        }];
    }

}

- (void)weiboLoginBtnClicked{
    [ZHProgrossHUD show];
    NSLog(@"weibo是否已经授权%d",[ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]);
    if ([ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]) {
        [self startMap];
    }else{
        [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            
            //        NSLog(@"%@",[userInfo uid]);
            //        NSLog(@"%@",[userInfo nickname]);
            //        NSLog(@"%@",[userInfo profileImage]);
            NSLog(@"%@",[[userInfo credential] token]);
//            NSLog(@"%@",[userInfo sourceData]);
            
            [self saveAccount:userInfo];
            [self startMap];
        }];
    }
}
- (void)saveAccount:(id<ISSPlatformUser>)userInfo{
    ZHAccountModel *account = [[ZHAccountModel alloc] init];
    account.nickname = [userInfo nickname];
    account.profileImage = [userInfo profileImage];
    account.oAuthToken = [[userInfo credential] token];
    [NSKeyedArchiver archiveRootObject:account toFile:AccountInfo];
}

- (void)startMap{
    [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [BMKLocationService setLocationDistanceFilter:1000.0f];
    self.localPosition = [[BMKLocationService alloc] init];
    self.localPosition.delegate = self;
    [self.localPosition startUserLocationService];
}
//
- (void)viewWillAppear:(BOOL)animated
{
    self.isGetCurrentLocation = YES;
}
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [self.localPosition stopUserLocationService];
//}
@end
