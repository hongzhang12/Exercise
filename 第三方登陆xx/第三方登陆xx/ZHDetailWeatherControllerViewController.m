//
//  ZHDetailWeatherControllerViewController.m
//  weather
//
//  Created by zhanghong on 15/4/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHDetailWeatherControllerViewController.h"
#import "ZHDetailView.h"
#import "ZHDetailModel.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ZHDetailWeatherControllerViewController ()<UIScrollViewDelegate>
@property (nonatomic ,weak) UIImageView *bg;
@property (nonatomic ,weak) UISegmentedControl *topSegmentedControl;
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,assign) int beginTag;

@end

@implementation ZHDetailWeatherControllerViewController


- (instancetype)initWithTag:(int)tag
{
    if (self = [super init]) {
        self.beginTag = tag;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [leftBtn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left_button_back.png"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"left_button_back_press.png"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    //背景
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.frame];
    bg.image = [UIImage imageNamed:@"bg_night_rain.jpg"];
    [self.view addSubview:bg];
    self.bg = bg;
    
    //顶部次级导航栏
    NSMutableArray *arr = [NSMutableArray array];
    for (ZHDetailModel *model in self.weatherArr) {
        [arr addObject:model.date];
    }
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:arr];
    segment.selectedSegmentIndex = self.beginTag;
    [segment addTarget:self action:@selector(topSegmentedControlClicked:) forControlEvents:UIControlEventValueChanged];
    segment.frame = CGRectMake(0, 65, ScreenWidth, ScreenHeight/12);
    segment.tintColor = [UIColor whiteColor];
    
    segment.accessibilityLabel = @"日期";
    
    [self.view addSubview:segment];
    self.topSegmentedControl = segment;
    
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(segment.frame), ScreenWidth, ScreenHeight-CGRectGetMaxY(segment.frame))];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(ScreenWidth*4, ScreenHeight-CGRectGetMaxY(segment.frame));
    
    scrollView.accessibilityLabel = @"温度";
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    for (int i = 0; i<self.weatherArr.count; i++) {
        ZHDetailView *detailView = [[ZHDetailView alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight/3)];
        [detailView setDataWithdetailModel:self.weatherArr[i]];
        [scrollView addSubview:detailView];
    }
    
    [self setScrollViewContentOffSetWithSegmentIndex:self.topSegmentedControl.selectedSegmentIndex];
    //scrollView.backgroundColor = [UIColor greenColor];
//    detailView.backgroundColor = [UIColor greenColor];
}
- (void)topSegmentedControlClicked:(UISegmentedControl *)segment
{
    [UIView animateWithDuration:0.5 animations:^{
        [self setScrollViewContentOffSetWithSegmentIndex:segment.selectedSegmentIndex];
    }];
}
- (void)setScrollViewContentOffSetWithSegmentIndex:(int)index
{
    self.scrollView.contentOffset = CGPointMake(ScreenWidth*index, 0);
}
- (void)leftBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray *)weatherArr
{
    if (_weatherArr == nil) {
        _weatherArr = [NSArray array];
    }
    return _weatherArr;
}
#pragma mark -scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat x = scrollView.contentOffset.x;
    int intX = (int)(x/ScreenWidth+0.5);
    NSLog(@"%f---%d",x/ScreenWidth,intX);
    self.topSegmentedControl.selectedSegmentIndex = intX;
}
@end
