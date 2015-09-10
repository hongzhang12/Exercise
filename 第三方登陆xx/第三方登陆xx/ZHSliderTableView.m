//
//  ZHSliderTableView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/12.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHSliderTableView.h"

@implementation ZHSliderTableView

-(instancetype)init{
    if (self == [super init]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self == [super initWithFrame:frame style:style]) {
        [self setUp];
    }
    return self;
}
- (void)setUp{
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    self.duration = 0.75;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}



-(void)show{
    [UIView animateWithDuration:self.duration animations:^{
        self.frame = CGRectMake(0, 0, self.width, ScreenHeight);
        self.alpha = 1.0;
    }];
}

- (void)hidden{
    [UIView animateWithDuration:self.duration animations:^{
        self.frame = CGRectMake(-self.width, 0, self.width, ScreenHeight);
        self.alpha = 0;
    }];
}

@end
