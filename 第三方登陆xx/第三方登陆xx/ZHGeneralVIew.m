//
//  ZHGeneralVIew.m
//  weather
//
//  Created by zhanghong on 15/4/24.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHGeneralView.h"
#import "ZHGeneralViewSub.h"
#import "ZHGeneralModel.h"
#define SpacePadding 15.0
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ZHGeneralView()
{
    @private
    UIView *_line1;
    UIView *_line2;
    UIView *_line3;
}
@property (nonatomic ,weak) UIButton *airQualityBtn;
@property (nonatomic ,weak) UILabel *publishTimeLabel;
@property (nonatomic ,weak) UILabel *weatherLabel;
@property (nonatomic ,weak) UILabel *temperatureLabel;
@property (nonatomic ,weak) UILabel *wind;
@property (nonatomic ,weak) ZHGeneralViewSub *today;
@property (nonatomic ,weak) ZHGeneralViewSub *tomorrow;
@end
@implementation ZHGeneralView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *airQuality = [[UIButton alloc] init];
        [airQuality setBackgroundImage:[UIImage imageNamed:@"air_status_bg.png"] forState:UIControlStateNormal];
        [airQuality setBackgroundImage:[UIImage imageNamed:@"air_status_bg_white.png"] forState:UIControlStateHighlighted];
        [airQuality setImage:[UIImage imageNamed:@"weather_aqi_level_1"] forState:UIControlStateNormal];
        //airQuality.backgroundColor = [UIColor yellowColor];
        airQuality.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 60);
        airQuality.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 5);
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"79 优" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [self.airQualityBtn setAttributedTitle:title forState:UIControlStateNormal];
        [airQuality addTarget:self action:@selector(airQualityBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:airQuality];
        self.airQualityBtn = airQuality;
        
        UILabel *publishTimeLabel = [[UILabel alloc] init];
        publishTimeLabel.text = @"2000-00-00";
        publishTimeLabel.font = [UIFont systemFontOfSize:18];
        publishTimeLabel.textColor = [UIColor whiteColor];
        [self addSubview:publishTimeLabel];
        self.publishTimeLabel = publishTimeLabel;
        
        UILabel *weatherLabel = [[UILabel alloc] init];
        weatherLabel.textColor = [UIColor whiteColor];
        weatherLabel.text = @"多云转晴";
        [self addSubview:weatherLabel];
        self.weatherLabel = weatherLabel;
        
        UILabel *temperatureLabel = [[UILabel alloc] init];
        //temperatureLabel.backgroundColor = [UIColor greenColor];
        temperatureLabel.textColor = [UIColor whiteColor];
        temperatureLabel.text = @"22";
        temperatureLabel.font = [UIFont systemFontOfSize:80];
        [self addSubview:temperatureLabel];
        self.temperatureLabel = temperatureLabel;
        
        UILabel *wind = [[UILabel alloc] init];
        wind.text = @"北风四级";
        wind.textColor = [UIColor whiteColor];
        [self addSubview:wind];
        self.wind = wind;
        
        ZHGeneralViewSub *today = [[ZHGeneralViewSub alloc] init];
//        today.backgroundColor = [UIColor greenColor];
        today.tag = 0;
        [today addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        today.datelabel.text = @"今天";
        
        //today.isAccessibilityElement = YES;
        today.accessibilityLabel = @"今天";
        
        [self addSubview:today];
        self.today = today;
        
        ZHGeneralViewSub *tomorrow = [[ZHGeneralViewSub alloc] init];
        //        today.backgroundColor = [UIColor greenColor];
        tomorrow.tag = 1;
        [tomorrow addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        tomorrow.datelabel.text = @"明天";
        
        //tomorrow.isAccessibilityElement = YES;
        tomorrow.accessibilityLabel = @"明天";
        [self addSubview:tomorrow];
        self.tomorrow = tomorrow;
        
        UIView *line1 = [[UIView alloc] init];
        line1.backgroundColor = [UIColor whiteColor];
        [self addSubview:line1];
        _line1 = line1;
        
        UIView *line2 = [[UIView alloc] init];
        line2.backgroundColor = [UIColor whiteColor];
        [self addSubview:line2];
        _line2 = line2;
        
        UIView *line3 = [[UIView alloc] init];
        line3.backgroundColor = [UIColor whiteColor];
        [self addSubview:line3];
        _line3 = line3;
        
        //weatherLabel.backgroundColor = [UIColor greenColor];
        //publishTimeLabel.backgroundColor = [UIColor greenColor];
        [self autoLayout];
    }
    return self;
}
- (void)buttonClicked:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(GeneralView:buttonClickedWithTag:)]) {
        [self.delegate GeneralView:self buttonClickedWithTag:button.tag];
    }
}
//- (void)layoutSubviews
//{
//    CGFloat startHeight = 64;
//    CGFloat height = ScreenHeight - startHeight;
//    self.airQualityBtn.frame = CGRectMake(SpacePadding, SpacePadding+startHeight, ScreenWidth/4, ScreenWidth/12);
//    
//    CGFloat publishTimeW = ScreenWidth/3;
//    CGFloat publishTimeH = ScreenWidth/10;
//    CGFloat publishTimeX = ScreenWidth - SpacePadding - publishTimeW;
//    CGFloat publishTimeY = SpacePadding/3+startHeight;
//    self.publishTimeLabel.frame = CGRectMake(publishTimeX, publishTimeY, publishTimeW, publishTimeH);
//    
//    self.weatherLabel.frame = CGRectMake(SpacePadding, height/2, ScreenWidth, ScreenWidth/12);
//    
//    CGFloat temY = CGRectGetMaxY(self.weatherLabel.frame)+SpacePadding/2;
//    CGFloat temW = ScreenWidth;
//    CGFloat temH = ScreenWidth/4;
//    self.temperatureLabel.frame = CGRectMake(SpacePadding, temY, temW, temH);
//    
//    CGFloat windX = SpacePadding;
//    CGFloat windY = CGRectGetMaxY(self.temperatureLabel.frame) + SpacePadding/2;
//    CGFloat windW = ScreenWidth/2;
//    CGFloat windH = ScreenWidth/10;
//    self.wind.frame = CGRectMake(windX, windY, windW, windH);
//    
//    CGFloat todayX = 0;
//    CGFloat todayY = CGRectGetMaxY(self.wind.frame)+SpacePadding*2;
//    CGFloat todayW = ScreenWidth/2;
//    CGFloat todayH = ScreenHeight - todayY;
//    self.today.frame = CGRectMake(todayX, todayY, todayW, todayH);
//    
//    CGFloat tomorrowX = ScreenWidth/2;
//    CGFloat tomorrowY = CGRectGetMaxY(self.wind.frame)+SpacePadding*2;
//    CGFloat tomorrowW = ScreenWidth/2;
//    CGFloat tomorrowH = ScreenHeight - todayY;
//    self.tomorrow.frame = CGRectMake(tomorrowX, tomorrowY, tomorrowW, tomorrowH);
//    
//    _line1.frame = CGRectMake(0, CGRectGetMaxY(self.wind.frame)+SpacePadding*2, ScreenWidth, 1);
//    
//    _line2.frame = CGRectMake(ScreenWidth/2-0.5, CGRectGetMaxY(_line1.frame), 1, ScreenHeight-CGRectGetMaxY(_line1.frame)-2);
//    
//    _line3.frame = CGRectMake(0, ScreenHeight-1, ScreenWidth, 1);
//}
- (void)autoLayout
{
    self.today.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *todayWidth = [NSLayoutConstraint constraintWithItem:self.today attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    NSLayoutConstraint *todayHeight = [NSLayoutConstraint constraintWithItem:self.today attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.15 constant:0];
    NSLayoutConstraint *todayX = [NSLayoutConstraint constraintWithItem:self.today attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *todayY = [NSLayoutConstraint constraintWithItem:self.today attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraints:@[todayWidth,todayHeight,todayX,todayY]];
    
    self.tomorrow.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *tomorrowWidth = [NSLayoutConstraint constraintWithItem:self.tomorrow attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *tomorrowHeight = [NSLayoutConstraint constraintWithItem:self.tomorrow attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *tomorrowX = [NSLayoutConstraint constraintWithItem:self.tomorrow attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *tomorrowY = [NSLayoutConstraint constraintWithItem:self.tomorrow attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraints:@[tomorrowWidth,tomorrowHeight,tomorrowX,tomorrowY]];
    
    self.wind.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *windWidth = [NSLayoutConstraint constraintWithItem:self.wind attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0];
    NSLayoutConstraint *windHeight = [NSLayoutConstraint constraintWithItem:self.wind attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:20];
    NSLayoutConstraint *windX = [NSLayoutConstraint constraintWithItem:self.wind attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:SpacePadding];
    NSLayoutConstraint *windY = [NSLayoutConstraint constraintWithItem:self.wind attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeTop multiplier:1 constant:-SpacePadding];
    [self addConstraints:@[windWidth,windX,windY]];
    [self.wind addConstraint:windHeight];
    
    self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *temperatureLabelWidth = [NSLayoutConstraint constraintWithItem:self.temperatureLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0];
    NSLayoutConstraint *temperatureLabelHeight = [NSLayoutConstraint constraintWithItem:self.temperatureLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0];
    NSLayoutConstraint *temperatureLabelX = [NSLayoutConstraint constraintWithItem:self.temperatureLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:SpacePadding];
    NSLayoutConstraint *temperatureLabelY = [NSLayoutConstraint constraintWithItem:self.temperatureLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.wind attribute:NSLayoutAttributeTop multiplier:1 constant:-SpacePadding];
    [self addConstraints:@[temperatureLabelWidth,temperatureLabelHeight,temperatureLabelX,temperatureLabelY]];
    [self.wind addConstraint:windHeight];
    
    self.weatherLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *weatherLabelWidth = [NSLayoutConstraint constraintWithItem:self.weatherLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.6 constant:0];
    NSLayoutConstraint *weatherLabelHeight = [NSLayoutConstraint constraintWithItem:self.weatherLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:20];
    NSLayoutConstraint *weatherLabelX = [NSLayoutConstraint constraintWithItem:self.weatherLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:SpacePadding];
    NSLayoutConstraint *weatherLabelY = [NSLayoutConstraint constraintWithItem:self.weatherLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.temperatureLabel attribute:NSLayoutAttributeTop multiplier:1 constant:-SpacePadding];
    [self addConstraints:@[weatherLabelWidth,weatherLabelX,weatherLabelY]];
    [self.weatherLabel addConstraint:weatherLabelHeight];
    
    self.airQualityBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *airQualityBtnWidth = [NSLayoutConstraint constraintWithItem:self.airQualityBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:90];
    NSLayoutConstraint *airQualityBtnHeight = [NSLayoutConstraint constraintWithItem:self.airQualityBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:30];
    NSLayoutConstraint *airQualityBtnX = [NSLayoutConstraint constraintWithItem:self.airQualityBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:SpacePadding];
    NSLayoutConstraint *airQualityBtnY = [NSLayoutConstraint constraintWithItem:self.airQualityBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:SpacePadding+64];
    [self addConstraints:@[airQualityBtnX,airQualityBtnY]];
    [self.airQualityBtn addConstraints:@[airQualityBtnWidth,airQualityBtnHeight]];
    
    self.publishTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *publishTimeLabelWidth = [NSLayoutConstraint constraintWithItem:self.publishTimeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0];
    NSLayoutConstraint *publishTimeLabelHeight = [NSLayoutConstraint constraintWithItem:self.publishTimeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.1 constant:0];
    NSLayoutConstraint *publishTimeLabelX = [NSLayoutConstraint constraintWithItem:self.publishTimeLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-SpacePadding];
    NSLayoutConstraint *publishTimeLabelY = [NSLayoutConstraint constraintWithItem:self.publishTimeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    [self addConstraints:@[publishTimeLabelWidth,publishTimeLabelHeight,publishTimeLabelX,publishTimeLabelY]];
    
    _line1.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *_line1Width = [NSLayoutConstraint constraintWithItem:_line1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *_line1Height = [NSLayoutConstraint constraintWithItem:_line1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:1];
    NSLayoutConstraint *_line1X = [NSLayoutConstraint constraintWithItem:_line1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *_line1Y = [NSLayoutConstraint constraintWithItem:_line1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraints:@[_line1Width,_line1X,_line1Y]];
    [_line1 addConstraint:_line1Height];
    
    _line2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *_line2Width = [NSLayoutConstraint constraintWithItem:_line2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:1];
    NSLayoutConstraint *_line2Height = [NSLayoutConstraint constraintWithItem:_line2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    NSLayoutConstraint *_line2X = [NSLayoutConstraint constraintWithItem:_line2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *_line2Y = [NSLayoutConstraint constraintWithItem:_line2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    [self addConstraints:@[_line2Height,_line2X,_line2Y]];
    [_line2 addConstraint:_line2Width];
    
    _line3.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *_line3Width = [NSLayoutConstraint constraintWithItem:_line3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_line1 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *_line3Height = [NSLayoutConstraint constraintWithItem:_line3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:1];
    NSLayoutConstraint *_line3X = [NSLayoutConstraint constraintWithItem:_line3 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *_line3Y = [NSLayoutConstraint constraintWithItem:_line3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.today attribute:NSLayoutAttributeBottom multiplier:1 constant:-1];
    [self addConstraints:@[_line3Width,_line3X,_line3Y]];
    [_line3 addConstraint:_line3Height];
    
}

- (void)airQualityBtnClicked
{
    NSLog(@"airQualityBtnClicked");
}

- (void)setDataWithGeneralModel:(ZHGeneralModel *)general
{
//    NSAttributedString *title = [[NSAttributedString alloc] initWithString:general.airQualityBtn attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12] ,NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.airQualityBtn setAttributedTitle:title forState:UIControlStateNormal];
    
    self.publishTimeLabel.text = general.publishTimeLabel;
    self.weatherLabel.text = general.weatherLabel;
    self.temperatureLabel.text = general.temperatureLabel;
    self.wind.text = general.wind;
    [self.today setDataWithGeneralSubModel:general.today];
    [self.tomorrow setDataWithGeneralSubModel:general.tomorrow];
}
@end
