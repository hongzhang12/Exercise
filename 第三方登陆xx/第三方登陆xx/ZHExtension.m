//
//  ZHExtension.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/6/25.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHExtension.h"

@implementation UIBarButtonItem(Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target andAction:(SEL)action andImage:(NSString *)image andHighImage:(NSString *)highImage
{
    CGSize size = [UIImage imageNamed:@"navigationbar_back.png"].size;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [button setImage:[UIImage imageNamed:@"navigationbar_back.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

@implementation UIView (extension)
- (CGRect)golbalFrame{
    return [self convertRect:self.bounds toView:[UIWindow currentWindow]];
}

- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (CGFloat)height
{
    return self.frame.size.height;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (CGSize)size
{
    return self.frame.size;
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (CGFloat)centerY
{
    return self.center.y;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint point = self.center;
    point.x = centerX;
    self.center = point;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint point = self.center;
    point.y = centerY;
    self.center = point;
}


@end

@implementation NSString(extension)

-(CGSize)sizeWithRestrictSize:(CGSize)size andFont:(CGFloat)fontSize
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:fontSize];
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end

@implementation UIWindow(Extension)

+ (UIWindow *)currentWindow
{
    return [[UIApplication sharedApplication].windows lastObject];
}

@end

@implementation NSDate(Extension)

//+(instancetype)localDate
//{
//    NSDate *date = [NSDate date];
////    NSTimeZone *zone = [NSTimeZone timeZoneForSecondsFromGMT:8];
////    NSInteger interval = [zone secondsFromGMTForDate:date];
//    return date;
//}
//+(instancetype)localDateWithTimeIntervalSinceNow:(NSTimeInterval)secs
//{
//    return [[NSDate localDate] dateByAddingTimeInterval:secs];
//}
- (int)year{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    return [[formatter stringFromDate:self] intValue];
}
- (int)month{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    return [[[formatter stringFromDate:self] stringByReplacingOccurrencesOfString:@"0" withString:@""] intValue];
}
- (int)day{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    return [[formatter stringFromDate:self] intValue];
}
- (int)hour{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"H";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    return [[[formatter stringFromDate:self] stringByReplacingOccurrencesOfString:@"0" withString:@""] intValue];
}
- (int)minute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"m";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    return [[formatter stringFromDate:self] intValue];
}
- (int)second{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"s";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    return [[formatter stringFromDate:self] intValue];
}
- (NSString *)relationWithOtherDate:(NSDate *)date
{
    NSString *relation = @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd H:mm:ss";
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];

    NSCalendar *calender = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|
    NSCalendarUnitDay|NSCalendarUnitHour|
    NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    NSDateComponents *comps= [calender components:unit fromDate:date toDate:self options:0];
    NSDateComponents *selfComps = [calender components:unit fromDate:self];
    NSDateComponents *dateComps = [calender components:unit fromDate:date];
    
    if (dateComps.year < selfComps.year) {
        formatter.dateFormat = @"yyyy-MM-dd";
        relation = [formatter stringFromDate:date];
    }else if(comps.month){
        relation = [NSString stringWithFormat:@"%d个月前",comps.month];
    }else if(selfComps.day == (dateComps.day + 1)){
        relation = @"昨天";
    }else if(selfComps.day == dateComps.day ){
        if(!comps.hour){
            if(!comps.minute){
                relation = @"刚刚";
            }else{
                relation = [NSString stringWithFormat:@"%d分钟前",comps.minute];
            }
        }else{
            relation = [NSString stringWithFormat:@"%d小时前",comps.hour];
        }
    }else{
        relation = [NSString stringWithFormat:@"%d天前",comps.day];
    }
    return relation;
}

- (NSString *)relationWithCurrentDate{
    NSDate *localDate = [NSDate date];
    
    return [localDate relationWithOtherDate:self];
}
@end