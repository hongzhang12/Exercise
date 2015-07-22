//
//  ZHDetailView.m
//  weather
//
//  Created by zhanghong on 15/4/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHDetailView.h"
#import "ZHDetailModel.h"
@interface ZHDetailView()
@property (nonatomic ,weak) UILabel *temperature;
@property (nonatomic ,weak) UILabel *weather;
@end
@implementation ZHDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *temperature = [[UILabel alloc] init];
        temperature.text = @"10 ~ 15 c";
        temperature.textColor = [UIColor whiteColor];
        temperature.textAlignment = NSTextAlignmentCenter;
        temperature.font = [UIFont systemFontOfSize:50];
        [self addSubview:temperature];
        self.temperature = temperature;
        
        UILabel *weather = [[UILabel alloc] init];
        weather.text = @"多云转雷阵雨";
        weather.textColor = [UIColor whiteColor];
        weather.textAlignment = NSTextAlignmentCenter;
        [self addSubview:weather];
        self.weather = weather;
        
//        temperature.backgroundColor = [UIColor redColor];
//        weather.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat padding = 15;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat temW = width;
    CGFloat temH = height/3;
    CGFloat temX = 0;
    CGFloat temY = (height-temH)/2;
    self.temperature.frame = CGRectMake(temX, temY, temW, temH);
    
    CGFloat weaX = 0;
    CGFloat weaY = CGRectGetMaxY(self.temperature.frame)+padding;
    CGFloat weaW = width;
    CGFloat weaH = 20;
    
    self.weather.frame = CGRectMake(weaX, weaY, weaW, weaH);
    
}
-(void)setDataWithdetailModel:(ZHDetailModel *)model
{
    self.temperature.text = model.temperature;
    self.weather.text = model.weather;
}

@end
