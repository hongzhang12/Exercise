//
//  ZHCalendarCell.h
//  Calendar
//
//  Created by zhanghong on 15/9/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CalendarID @"CalendarID"
@interface ZHCalendarCell : UICollectionViewCell
- (void)setDate:(NSInteger)date withComponent:(NSDateComponents *)component;
@property (nonatomic ,weak) UILabel *dateLabel;
@property (nonatomic ,strong) NSDateComponents *component;
- (void)setDate:(NSInteger)date;
@end
