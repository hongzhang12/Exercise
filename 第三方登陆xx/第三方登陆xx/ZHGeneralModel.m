//
//  ZHGeneralModel.m
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHGeneralModel.h"



//@property (nonatomic ,weak) UILabel *datelabel;
//@property (nonatomic ,weak) UILabel *temperatureLabel;
//@property (nonatomic ,weak) UILabel *weatherLabel;
//@property (nonatomic ,weak) UIImageView *picture;

@interface ZHGeneralSubModel()

@end

@implementation ZHGeneralSubModel
+(instancetype)generalSubModelWithDictionary:(NSDictionary *)dict
{
    ZHGeneralSubModel *generalSub = [[ZHGeneralSubModel alloc] init];
    generalSub.temperatureLabel = dict[@"temperature"];
    generalSub.weatherLabel = dict[@"weather"];
    generalSub.pictureUrl = dict[@"dayPictureUrl"];
    return generalSub;
}
@end

//@property (nonatomic ,weak) UIButton *airQualityBtn;
//@property (nonatomic ,weak) UILabel *publishTimeLabel;
//@property (nonatomic ,weak) UILabel *weatherLabel;
//@property (nonatomic ,weak) UILabel *temperatureLabel;
//@property (nonatomic ,weak) UILabel *wind;
//@property (nonatomic ,weak) ZHGeneralViewSub *today;
//@property (nonatomic ,weak) ZHGeneralViewSub *tomorrow;

@interface ZHGeneralModel()

@end
@implementation ZHGeneralModel
+(instancetype)generalModelWithDictionary:(NSDictionary *)dict
{
    ZHGeneralModel *general = [[ZHGeneralModel alloc] init];
    
    general.publishTimeLabel = dict[@"date"];
    
    NSDictionary *results = [dict[@"results"] lastObject];
    general.airQualityBtn = results[@"pm25"];
    
    NSDictionary *todayWeather = [results[@"weather_data"] firstObject];
    general.weatherLabel = todayWeather[@"weather"];
    general.wind = todayWeather[@"wind"];
    
    NSString *tem = todayWeather[@"date"];
    general.temperatureLabel = [tem substringWithRange:NSMakeRange(14, 3)];
    
    general.today = [ZHGeneralSubModel generalSubModelWithDictionary:todayWeather];
    
    NSDictionary *tomorrowWeather = results[@"weather_data"][1];
    general.tomorrow = [ZHGeneralSubModel generalSubModelWithDictionary:tomorrowWeather];
    
    
    return general;
}
@end
