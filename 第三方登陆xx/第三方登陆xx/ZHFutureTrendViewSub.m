//
//  ZHFutureTrendViewSub.m
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHFutureTrendViewSub.h"
#import "ZHFutureTrendModel.h"
#import "UIImageView+WebCache.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ZHFutureTrendViewSub()
{
    @private
    UIView *_line;
    UIView *_line1;
}
@property (nonatomic ,weak) UILabel *date;
@property (nonatomic ,weak) UILabel *weather;

@property (nonatomic ,weak) UILabel *wind;

@property (nonatomic ,weak) UIImageView *nightPicture;



@end
@implementation ZHFutureTrendViewSub

- (instancetype)init
{
    if (self = [super init]) {
        UILabel *date = [[UILabel alloc] init];
        date.text = @"今天";
        date.textColor = [UIColor whiteColor];
        date.textAlignment = NSTextAlignmentCenter;
        [self addSubview:date];
        self.date = date;
        
        UILabel *weather = [[UILabel alloc] init];
        weather.text = @"多云转雷阵雨";
        weather.textAlignment = NSTextAlignmentCenter;
        weather.textColor = [UIColor whiteColor];
        weather.font = [UIFont systemFontOfSize:12];
        [self addSubview:weather];
        self.weather = weather;
        
        UILabel *wind = [[UILabel alloc] init];
        wind.text = @"南风微风";
        wind.textAlignment = NSTextAlignmentCenter;
        wind.textColor = [UIColor whiteColor];
        [self addSubview:wind];
        self.wind = wind;
        
        UIImageView *dayPicture = [[UIImageView alloc] init];
        [self addSubview:dayPicture];
        self.dayPicture = dayPicture;
        
        UIImageView *nightPicture = [[UIImageView alloc] init];
        [self addSubview:nightPicture];
        self.nightPicture = nightPicture;
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        _line = line;
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor whiteColor];
        [self addSubview:line1];
        _line1 = line1;
        
//        date.backgroundColor = [UIColor blueColor];
//        picture.backgroundColor = [UIColor yellowColor];
    }
    return self;
}
- (void)layoutSubviews
{
    CGFloat startY = 84;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGFloat dateX = 0;
    CGFloat dateY = startY;
    CGFloat dateW = width;
    CGFloat dateH = 20;
    self.date.frame = CGRectMake(dateX, dateY, dateW, dateH);
    
    CGFloat weatherX = 0;
    CGFloat weatherY = CGRectGetMaxY(self.date.frame);
    CGFloat weatherW = width;
    CGFloat weatherH = 20;
    self.weather.frame = CGRectMake(weatherX, weatherY, weatherW, weatherH);
    
    CGFloat pictureW = 30;
    CGFloat pictureH = 30;
    CGFloat pictureX = (width-pictureW)/2;
    CGFloat pictureY = CGRectGetMaxY(self.weather.frame) + 30;
    self.dayPicture.frame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
    
    CGFloat nightW = 30;
    CGFloat nightH = 30;
    CGFloat nightX = (width-pictureW)/2;
    CGFloat nightY = CGRectGetMaxY(self.dayPicture.frame) + height/3;
    self.nightPicture.frame = CGRectMake(nightX, nightY, nightW, nightH);

    CGFloat windX = 0;
    CGFloat windY = CGRectGetMaxY(self.nightPicture.frame);
    CGFloat windW = width;
    CGFloat windH = 20;
    self.wind.frame = CGRectMake(windX, windY, windW, windH);
    
    _line.frame = CGRectMake(width-1, 65, 1, height - 65);
    _line.alpha = 0.5;
    _line1.frame = CGRectMake(0, 64, width, 1);
    _line1.alpha = 0.5;
    
}
- (void)setDataWithfutureTrendSubModel:(ZHFutureTrendSubModel *)model
{
    self.date.text = model.date;
    self.weather.text = model.weather;
    self.wind.text = model.wind;
    [self.dayPicture sd_setImageWithURL:[NSURL URLWithString:model.dayPictureUrl]];
    [self.nightPicture sd_setImageWithURL:[NSURL URLWithString:model.nightPictureUrl]];
    
}

@end
