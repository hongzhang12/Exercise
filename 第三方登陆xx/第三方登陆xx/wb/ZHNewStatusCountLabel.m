//
//  ZHNewStatusCountLabel.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/14.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHNewStatusCountLabel.h"
#import "ZHExtension.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ZHNewStatusCountLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.contentMode = UIViewContentModeBottom;
        self.textColor = [UIColor whiteColor];
        NSLog(@"%@",NSStringFromCGPoint(self.layer.anchorPoint));
        self.layer.anchorPoint = CGPointMake(0.5, 0);
        //self.hidden = YES;
    }
    return self;
}

- (void)disPlayCount:(int)count andLoadStatusType:(LoadStatusType)statusType{
    if (statusType == LoadStatusTypeNew) {
        self.text = [NSString stringWithFormat:@"刷新了%d条",count];
    }else{
        self.text = [NSString stringWithFormat:@"加载了%d条",count];
    }

    [UIView animateWithDuration:0.5 animations:^{
        self.y = 64;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                self.y = 20;
            }];
        });
        
    }];

}
@end
