//
//  ZHGeneralViewSub.m
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHGeneralViewSub.h"
#import "ZHGeneralModel.h"
#import "UIImageView+WebCache.h"
#define SpacePadding 15.0
@interface ZHGeneralViewSub()


@property (nonatomic ,weak) UILabel *temperatureLabel;
@property (nonatomic ,weak) UILabel *weatherLabel;
@property (nonatomic ,weak) UIImageView *picture;
@end
@implementation ZHGeneralViewSub

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}
- (instancetype)init
{
    if (self = [super init]) {
        UILabel *date = [[UILabel alloc] init];
        
        date.textColor = [UIColor whiteColor];
        [self addSubview:date];
        self.datelabel = date;
        
        UILabel *tem = [[UILabel alloc] init];
        tem.text = @"23/18 c";
        tem.textColor = [UIColor whiteColor];
        [self addSubview:tem];
        _temperatureLabel = tem;
        
        UILabel *weather = [[UILabel alloc] init];
        weather.text = @"阵雨转多云";
        weather.textColor = [UIColor whiteColor];
        [self addSubview:weather];
        _weatherLabel = weather;
        
        UIImageView *picture = [[UIImageView alloc] init];
        [self addSubview:picture];
        self.picture = picture;
        
//        weather.backgroundColor = [UIColor yellowColor];
//        picture.backgroundColor = [UIColor blueColor];
    }
    return self;
}
- (void)layoutSubviews
{

    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.datelabel.frame = CGRectMake(SpacePadding, 0, width/3, height/3);
    self.temperatureLabel.frame = CGRectMake(CGRectGetMaxX(self.datelabel.frame), 0, width-CGRectGetMaxX(self.datelabel.frame), height/3);
    self.weatherLabel.frame = CGRectMake(SpacePadding, CGRectGetMaxY(self.datelabel.frame), width/3*2-5, height-CGRectGetMaxY(self.datelabel.frame));
    self.picture.frame = CGRectMake(CGRectGetMaxX(self.weatherLabel.frame)-5, CGRectGetMaxY(self.datelabel.frame)+10, 30, 30);
    
}
//@property (nonatomic ,weak) UILabel *datelabel;
//@property (nonatomic ,weak) UILabel *temperatureLabel;
//@property (nonatomic ,weak) UILabel *weatherLabel;
//@property (nonatomic ,weak) UIImageView *picture;
- (void)setDataWithGeneralSubModel:(ZHGeneralSubModel *)generalSub
{
    self.temperatureLabel.text = generalSub.temperatureLabel;
    self.weatherLabel.text = generalSub.weatherLabel;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:generalSub.pictureUrl]];
    
}
@end
