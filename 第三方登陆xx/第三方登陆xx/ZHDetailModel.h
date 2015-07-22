//
//  ZHDetailModel.h
//  weather
//
//  Created by zhanghong on 15/4/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHDetailModel : NSObject
@property (nonatomic ,copy) NSString *temperature;
@property (nonatomic ,copy) NSString *weather;
@property (nonatomic ,copy) NSString *date;
+ (instancetype)detailModelWithDictionary:(NSDictionary *)dict;
@end
