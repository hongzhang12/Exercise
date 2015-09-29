//
//  ZHCalendarCell.m
//  Calendar
//
//  Created by zhanghong on 15/9/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHCalendarCell.h"

@interface ZHCalendarCell()



@end

@implementation ZHCalendarCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *dateLabel = [[UILabel alloc] init];
        
        dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:dateLabel];
        self.dateLabel = dateLabel;

        self.dateLabel.layer.borderColor = [UIColor blueColor].CGColor;
        self.dateLabel.layer.masksToBounds = YES;
        
//        dateLabel.backgroundColor = [UIColor orangeColor];
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.dateLabel.layer.cornerRadius = self.frame.size.width/2.0;
    
    self.dateLabel.frame = self.bounds;
    
    
}

-(void)setDate:(NSInteger)date withComponent:(NSDateComponents *)component{
    [self setDate:date];
    self.component = component;
    if (component.day != 1&&component.day ==date) {
        self.dateLabel.layer.borderWidth = 1.0f;
        self.dateLabel.textColor = [UIColor blueColor];
    }else{
        self.dateLabel.layer.borderWidth = 0.0f;
        self.dateLabel.textColor = [UIColor whiteColor];
    }
    
}

- (void)setDate:(NSInteger)date{
    self.dateLabel.layer.borderWidth = 0.0f;

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
    self.dateLabel.text = [NSString stringWithFormat:@"%ld",date];
#else
    self.dateLabel.text = [NSString stringWithFormat:@"%d",date];
#endif
    
}
@end
