//
//  ZHFutureTrendView.m
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHFutureTrendView.h"
#import "ZHFutureTrendViewSub.h"
#import "ZHFutureTrendModel.h"
#import "ZHTrendChartView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZHFutureTrendView()
@property (nonatomic ,weak) ZHFutureTrendViewSub *today;
@property (nonatomic ,weak) ZHFutureTrendViewSub *tomorrow;
@property (nonatomic ,weak) ZHFutureTrendViewSub *theDayAfterTomorrow;
@property (nonatomic ,weak) ZHFutureTrendViewSub *twoDayAfterTomorrow;
@property (nonatomic ,weak) ZHTrendChartView *trendChartView;
@end
@implementation ZHFutureTrendView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        ZHTrendChartView *trendChartView = [[ZHTrendChartView alloc] init];
        trendChartView.backgroundColor = [UIColor clearColor];
        [self addSubview:trendChartView];
        self.trendChartView = trendChartView;
        
        ZHFutureTrendViewSub *today = [[ZHFutureTrendViewSub alloc] init];
        today.tag = 0;
        [today addTarget:self action:@selector(futureTrendSubBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        today.accessibilityLabel = @"today";
        [self addSubview:today];
        self.today = today;
        
        ZHFutureTrendViewSub *tomorrow = [[ZHFutureTrendViewSub alloc] init];
        tomorrow.tag = 1;
        [tomorrow addTarget:self action:@selector(futureTrendSubBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        tomorrow.accessibilityLabel = @"tomorrow";
        [self addSubview:tomorrow];
        self.tomorrow = tomorrow;
        
        ZHFutureTrendViewSub *theDayAfterTomorrow = [[ZHFutureTrendViewSub alloc] init];
        theDayAfterTomorrow.tag = 2;
        [theDayAfterTomorrow addTarget:self action:@selector(futureTrendSubBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        theDayAfterTomorrow.accessibilityLabel = @"后天";
        [self addSubview:theDayAfterTomorrow];
        self.theDayAfterTomorrow = theDayAfterTomorrow;
        
        ZHFutureTrendViewSub *twoDayAfterTomorrow = [[ZHFutureTrendViewSub alloc] init];
        twoDayAfterTomorrow.tag = 3;
        [twoDayAfterTomorrow addTarget:self action:@selector(futureTrendSubBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        twoDayAfterTomorrow.accessibilityLabel = @"万天";
        [self addSubview:twoDayAfterTomorrow];
        self.twoDayAfterTomorrow = twoDayAfterTomorrow;
        

        
        //trendChartView.backgroundColor = [UIColor greenColor];
//        today.backgroundColor = [UIColor greenColor];
    }
    return self;
}
- (void)futureTrendSubBtnClicked:(ZHFutureTrendViewSub *)button
{
    NSLog(@"%d",button.tag);
    if ([self.delegate respondsToSelector:@selector(futureTrendView:buttonClickedWithTag:)]) {
        [self.delegate futureTrendView:self buttonClickedWithTag:button.tag];
    }
}
- (void)layoutSubviews
{
    self.today.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenHeight);
    self.tomorrow.frame = CGRectMake(ScreenWidth/4, 0, ScreenWidth/4, ScreenHeight);
    self.theDayAfterTomorrow.frame = CGRectMake(ScreenWidth/2, 0, ScreenWidth/4, ScreenHeight);
    self.twoDayAfterTomorrow.frame = CGRectMake(ScreenWidth/4*3, 0, ScreenWidth/4, ScreenHeight);
    
    self.trendChartView.frame = CGRectMake(0, CGRectGetMaxY(self.today.dayPicture.frame), ScreenWidth, ScreenHeight/3);
}
- (void)setDataWithFutureTrendModel:(ZHFutureTrendModel *)model
{
    [self.today setDataWithfutureTrendSubModel:model.today];
    [self.tomorrow setDataWithfutureTrendSubModel:model.tomorrow];
    [self.theDayAfterTomorrow setDataWithfutureTrendSubModel:model.theDayAfterTomorrow];
    [self.twoDayAfterTomorrow setDataWithfutureTrendSubModel:model.twoDayAfterTomorrow];
    [self.trendChartView setDataWithfutureTrendModel:model];
}
@end
