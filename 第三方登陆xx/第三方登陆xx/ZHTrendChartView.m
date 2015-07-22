//
//  ZHTrendChartView.m
//  weather
//
//  Created by zhanghong on 15/4/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHTrendChartView.h"
#import "ZHFutureTrendModel.h"
#define TemperatureFont 16
#define LineWidth 3
@interface ZHTrendChartView()
@property (nonatomic ,strong) NSArray *temperatureArr;
@end

@implementation ZHTrendChartView
-(void)setDataWithfutureTrendModel:(ZHFutureTrendModel *)model
{
    self.temperatureArr = model.trendArr;
    [self setNeedsDisplay];
}
- (NSArray *)temperatureArr
{
    if (_temperatureArr == nil) {
        _temperatureArr = [NSArray array];
    }
    return _temperatureArr;
}
- (void)drawRect:(CGRect)rect
{
    if (self.temperatureArr.count == 0) {
        return;
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(ctx, LineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    ZHTrendModel *point1 = self.temperatureArr[0];
    
    int highest = -1000;
    int lowest = 1000;

    for (int i = 0; i <self.temperatureArr.count; i++) {

        ZHTrendModel *point = self.temperatureArr[i];
        if (point.temperature >= highest) {
            highest = point.temperature;
        }
        if (point.temperature <= lowest) {
            lowest = point.temperature;
        }
    }
//    NSLog(@"温差%d",highest-lowest);
    int unit = (rect.size.height-LineWidth*16)/2/(highest-lowest);
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat startY = point1.temperature;
    
    CGFloat x = width/8.0;
    CGFloat y = height/2;
//    NSLog(@"%f--%f",x,y);
    
    CGContextMoveToPoint(ctx, x, y);
    CGContextAddArc(ctx, x, y, 2, 0, M_PI*2, 1);
    CGFloat temp = startY;
    CGContextSaveGState(ctx);
    ZHTrendModel  *point2 = self.temperatureArr[0];
    
    [self drawTemperature:point2.temperature AtPoint:CGPointMake(x, y)];
    CGContextRestoreGState(ctx);
    for (int i = 1; i <self.temperatureArr.count; i++) {
        ZHTrendModel *point = self.temperatureArr[i];
        x = width/4*i + width/8;
        y -= (point.temperature - temp) * unit;
        temp = point.temperature;
//        NSLog(@"%f--%f",x,y);
        CGContextAddLineToPoint(ctx, x, y);
        CGContextAddArc(ctx, x, y, 2, 0, M_PI*2, 1);
        
        CGContextSaveGState(ctx);
        
        //CGContextStrokePath(ctx);

        [self drawTemperature:point.temperature AtPoint:CGPointMake(x, y)];
        CGContextRestoreGState(ctx);
    }
    CGContextStrokePath(ctx);
}
- (void)drawTemperature:(int)temperature AtPoint:(CGPoint)point{

    NSString *str = [NSString stringWithFormat:@"%d",temperature];
    [str drawAtPoint:CGPointMake(point.x-10, point.y) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TemperatureFont],NSForegroundColorAttributeName:[UIColor greenColor]}];
}
@end
