//
//  ZHDetailWeatherControllerViewController.h
//  weather
//
//  Created by zhanghong on 15/4/28.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHDetailWeatherControllerViewController : UIViewController
@property (nonatomic ,strong) NSArray *weatherArr;
- (instancetype)initWithTag:(int)tag;
@end
