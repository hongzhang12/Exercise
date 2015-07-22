//
//  ZHGeneralModel.h
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHGeneralSubModel : NSObject
@property (nonatomic ,copy) NSString *temperatureLabel;
@property (nonatomic ,copy) NSString *weatherLabel;
@property (nonatomic ,copy) NSString *pictureUrl;
+ (instancetype)generalSubModelWithDictionary:(NSDictionary *)dict;
@end

@interface ZHGeneralModel : NSObject
@property (nonatomic ,copy) NSString *airQualityBtn;
@property (nonatomic ,copy) NSString *publishTimeLabel;
@property (nonatomic ,copy) NSString *weatherLabel;
@property (nonatomic ,copy) NSString *temperatureLabel;
@property (nonatomic ,copy) NSString *wind;
@property (nonatomic ,strong) ZHGeneralSubModel *today;
@property (nonatomic ,strong) ZHGeneralSubModel *tomorrow;
+ (instancetype)generalModelWithDictionary:(NSDictionary *)dict;
@end
