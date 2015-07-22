//
//  ZHFutureTrendModel.h
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTrendModel : NSObject
@property (nonatomic ,assign) int temperature;

+ (instancetype)TrendModelWithString:(NSString *)temperture;
@end

@interface ZHFutureTrendSubModel : NSObject
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *weather;
@property (nonatomic,copy) NSString *wind;
@property (nonatomic,copy) NSString *dayPictureUrl;
@property (nonatomic,copy) NSString *nightPictureUrl;

+ (instancetype)FutureTrendSubModelWithDictionary:(NSDictionary *)dict;
@end
//@property (nonatomic ,weak) ZHFutureTrendViewSub *today;
//@property (nonatomic ,weak) ZHFutureTrendViewSub *tomorrow;
//@property (nonatomic ,weak) ZHFutureTrendViewSub *theDayAfterTomorrow;
//@property (nonatomic ,weak) ZHFutureTrendViewSub *twoDayAfterTomorrow;
@interface ZHFutureTrendModel : NSObject
@property (nonatomic ,strong) ZHFutureTrendSubModel *today;
@property (nonatomic ,strong) ZHFutureTrendSubModel *tomorrow;
@property (nonatomic ,strong) ZHFutureTrendSubModel *theDayAfterTomorrow;
@property (nonatomic ,strong) ZHFutureTrendSubModel *twoDayAfterTomorrow;
@property (nonatomic ,strong) NSArray *trendArr;
+ (instancetype)FutureTrendModelWithDictionary:(NSDictionary *)dict;
@end
