//
//  ZHStatusToolBar.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/27.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHStatusToolBar.h"
#import "ZHStatusModel.h"
@implementation ZHStatusToolBar

- (instancetype)init{
    if (self = [super init]) {
        UIButton *responseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        responseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [responseBtn setImage:[[UIImage imageNamed:@"timeline_icon_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [responseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [responseBtn setTitle:@"回复" forState:UIControlStateNormal];
        [self addSubview:responseBtn];
        self.responseBtn = responseBtn;
        
        UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        forwardBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [forwardBtn setImage:[[UIImage imageNamed:@"timeline_icon_retweet"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
        [forwardBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [forwardBtn setTitle:@"转发" forState:UIControlStateNormal];
        [self addSubview:forwardBtn];
        self.forwardBtn = forwardBtn;
        
        UIButton *goodBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        goodBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [goodBtn setImage:[[UIImage imageNamed:@"timeline_icon_unlike"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [goodBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [goodBtn setTitle:@"赞" forState:UIControlStateNormal];
        [self addSubview:goodBtn];
        self.goodBtn = goodBtn;
    }
    return self;
}

- (void)setCountWithStatusModel:(ZHStatusModel *)model
{
    [self setTransformCountFrom:model.reposts_count onButton:self.responseBtn andPlaceHolderStr:@"回复"];
    [self setTransformCountFrom:model.comments_count onButton:self.forwardBtn andPlaceHolderStr:@"转发"];
    [self setTransformCountFrom:model.attitudes_count onButton:self.goodBtn andPlaceHolderStr:@"赞"];
}

- (void)setTransformCountFrom:(int)count onButton:(UIButton*)button andPlaceHolderStr:(NSString *)placeHolderStr{
    CGFloat transformCount = 0;
    NSString *transformStr = [NSString string];
    if (count > 10000) {
        count += 500;
        CGFloat temp = count/1000.0;
        count = (int)temp;
        transformCount = count/10.0;
        transformStr = [[NSString stringWithFormat:@"%.1f万",transformCount] stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    }else if(count == 0){
        transformStr = placeHolderStr;
    }else{
        transformStr = [NSString stringWithFormat:@"%d",count];
    }
    [button setTitle:transformStr forState:UIControlStateNormal];
}
@end
