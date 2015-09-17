//
//  ZHWeatherController.m
//  weather
//
//  Created by zhanghong on 15/4/24.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHWeatherController.h"
#import "ZHGeneralView.h"
#import "ZHFutureTrendView.h"
#import "MBProgressHUD+MJ.h"
#import "ZHGeneralModel.h"
#import "ZHFutureTrendModel.h"
#import "ZHDetailWeatherControllerViewController.h"
#import "ZHDetailModel.h"
#import <ShareSDK/ShareSDK.h>
#import "ZHViewController.h"
#import "ZHAccountModel.h"
#define AccountInfo [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) lastObject]stringByAppendingPathComponent:@"account.plist"]
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ZHWeatherController ()<ZHFutureTrendViewDelegate,ZHGeneralViewDelegate,UIScrollViewDelegate>
@property (nonatomic ,weak) UIImageView *bgView;
@property (nonatomic ,weak) ZHGeneralView *generalView;
@property (nonatomic ,weak) ZHFutureTrendView *futureTrendView;
@property (nonatomic ,strong) NSDictionary *weatherDict;
@end

@implementation ZHWeatherController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.title = @"长沙市";
    ZHAccountModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountInfo];
    NSLog(@"%@--%@--%@",model.oAuthToken,model.nickname,model.profileImage);
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(loginoutBtnClicked)];
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"lv_rightitem_camera.png"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"lv_rightitem_camera_press.png"] forState:UIControlStateHighlighted];
    [rightBtn addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.accessibilityLabel = @"录像";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    //背景层
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"bg_middle_rain.jpg"];
    [self.view addSubview:bgView];
    self.bgView = bgView;
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    //scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight*2);
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.delegate = self;
    //scrollView.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
    //scrollView.isAccessibilityElement = YES;
    scrollView.accessibilityLabel = @"天气";
    
    [self.view addSubview:scrollView];
    
    //刷新
//    UIView *fresh = [[UIView alloc] initWithFrame:CGRectMake(0, -80, scrollView.frame.size.width, 80)];
//    [scrollView addSubview:fresh];
//    fresh.backgroundColor = [UIColor redColor];
    //半透明层
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight*2)];
    //cover.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:cover];
    
    UIView *translucent = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    translucent.backgroundColor = [UIColor grayColor];
    translucent.alpha = 0.7;
    [cover addSubview:translucent];

    //General View
    ZHGeneralView *generalView = [[ZHGeneralView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [scrollView addSubview:generalView];
    generalView.delegate = self;
    self.generalView = generalView;
    
    ZHFutureTrendView *trendView = [[ZHFutureTrendView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    trendView.delegate = self;
    [scrollView addSubview:trendView];
    self.futureTrendView = trendView;
    
    
    [self loadWeather];
    
    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(loadWeather) name:UIApplicationDidBecomeActiveNotification object:nil];
//    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor blueColor];
//    [scrollView addSubview:view];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3600 target:self selector:@selector(loadWeather) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
#pragma scroll代理
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"%f",y);
//}
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"DidEndScrollingAnimation");
//    CGFloat y = scrollView.contentOffset.y;
//    NSLog(@"%f",y);
//    if (y>-80&&y<0) {
//        [UIView animateWithDuration:0.25 animations:^{
//            scrollView.contentOffset= CGPointMake(0, 0);
//        }];
//    }
//}
- (void)dealloc
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}
- (void)loginoutBtnClicked
{
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightBtnClicked
{
    [self presentViewController:[[ZHViewController alloc] init] animated:YES completion:^{
        
    }];
}
//加载天气数据
- (void)loadWeather
{
    NSLog(@"xx");
    NSString *str = [NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=6SiyDbbeHDSRnaz2Tx8qsfnb&mcode=123",self.title];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url = [NSURL URLWithString:str];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    request.timeoutInterval = 50.0;

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data&&!connectionError) {
            //解析json

            id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dict = (NSDictionary *)json;
            self.weatherDict = dict;
            ZHGeneralModel *generalModel = [ZHGeneralModel generalModelWithDictionary:dict];
            [self.generalView setDataWithGeneralModel:generalModel];
            
            ZHFutureTrendModel *trendModel = [ZHFutureTrendModel FutureTrendModelWithDictionary:dict];
            [self.futureTrendView setDataWithFutureTrendModel:trendModel];

        }else{
            NSLog(@"网络连接失败");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络连接失败"];
            });
        }
    }];
}
#pragma mark -futureTrendView代理方法
- (void)futureTrendView:(ZHFutureTrendView *)futureTrendView buttonClickedWithTag:(int)tag
{
    [self pushTodetailControllerWithTag:tag];
}
#pragma mark -GeneralView代理方法
- (void)GeneralView:(ZHGeneralView *)GeneralView buttonClickedWithTag:(int)tag
{
    [self pushTodetailControllerWithTag:tag];
}
- (void)pushTodetailControllerWithTag:(int)tag
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *results = [self.weatherDict[@"results"] lastObject];
    for (int i = 0; i<results.count; i++) {
        NSDictionary *weather = results[@"weather_data"][i];
        ZHDetailModel *model = [ZHDetailModel detailModelWithDictionary:weather];
        [arr addObject:model];
    }
    
    ZHDetailWeatherControllerViewController *detailController = [[ZHDetailWeatherControllerViewController alloc] initWithTag:tag];
    detailController.title = self.title;
    detailController.weatherArr = arr;
    [self.navigationController pushViewController:detailController animated:YES];
}
@end
