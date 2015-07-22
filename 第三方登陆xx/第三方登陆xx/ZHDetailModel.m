//
//  ZHDetailModel.m
//  weather
//
//  Created by zhanghong on 15/4/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHDetailModel.h"

@implementation ZHDetailModel
+ (instancetype)detailModelWithDictionary:(NSDictionary *)dict
{
    ZHDetailModel *model = [[ZHDetailModel alloc] init];
    model.temperature = dict[@"temperature"];
    model.weather = dict[@"weather"];
    model.date = [dict[@"date"] substringToIndex:2];
    return model;
}
@end
