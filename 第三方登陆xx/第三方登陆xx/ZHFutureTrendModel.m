//
//  ZHFutureTrendModel.m
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHFutureTrendModel.h"

//@property (nonatomic ,weak) UILabel *date;
//@property (nonatomic ,weak) UILabel *weather;
//
//@property (nonatomic ,weak) UILabel *wind;
//@property (nonatomic ,weak) UIImageView *dayPicture;
//@property (nonatomic ,weak) UIImageView *nightPicture;
@implementation ZHFutureTrendSubModel

+ (instancetype)FutureTrendSubModelWithDictionary:(NSDictionary *)dict
{
    ZHFutureTrendSubModel *model = [[ZHFutureTrendSubModel alloc] init];
    model.date = [dict[@"date"] substringToIndex:2];
    model.weather = dict[@"weather"];
    model.wind = dict[@"wind"];
    model.dayPictureUrl = dict[@"dayPictureUrl"];
    model.nightPictureUrl = dict[@"nightPictureUrl"];
    return model;
}
@end

@implementation ZHTrendModel

+ (instancetype)TrendModelWithString:(NSString *)temperture
{
    ZHTrendModel *model = [[ZHTrendModel alloc] init];
    
    model.temperature = [[temperture substringToIndex:2] intValue];
    return model;
}

@end

@implementation ZHFutureTrendModel
+ (instancetype)FutureTrendModelWithDictionary:(NSDictionary *)dict
{
    ZHFutureTrendModel *model = [[ZHFutureTrendModel alloc] init];
    NSDictionary *results = [dict[@"results"] lastObject];
    
    NSArray *weatherArr = results[@"weather_data"];
    
    model.today = [ZHFutureTrendSubModel FutureTrendSubModelWithDictionary:weatherArr[0]];
    model.tomorrow = [ZHFutureTrendSubModel FutureTrendSubModelWithDictionary:weatherArr[1]];
    model.theDayAfterTomorrow = [ZHFutureTrendSubModel FutureTrendSubModelWithDictionary:weatherArr[2]];
    model.twoDayAfterTomorrow = [ZHFutureTrendSubModel FutureTrendSubModelWithDictionary:weatherArr[3]];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSDictionary *dict in weatherArr) {
        ZHTrendModel *model = [ZHTrendModel TrendModelWithString:dict[@"temperature"]];
        [arr addObject:model];
    }
    model.trendArr = arr;
    return model;
}

@end
