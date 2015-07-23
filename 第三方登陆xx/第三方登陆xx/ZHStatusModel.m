//
//  ZHStatusModel.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/13.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHStatusModel.h"
#import "MJExtension.h"
#import "ZHExtension.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ZHStatusModel
- (void)setFrames
{
    CGFloat profile_imageX = StatusCellBorderWidth;
    CGFloat profile_imageY = StatusCellBorderWidth;
    CGFloat profile_imageW = StatusProfileImageLength;
    CGFloat profile_imageH = StatusProfileImageLength;
    self.profile_imageFrame = CGRectMake(profile_imageX, profile_imageY, profile_imageW, profile_imageH);
    
    CGFloat nameX = CGRectGetMaxX(self.profile_imageFrame) + StatusPadding;
    CGFloat nameY = profile_imageY;
    CGSize nameSize = [self.user.name sizeWithRestrictSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameFontSize];
    self.nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    self.created_at = [self.created_at substringWithRange:NSMakeRange(11, 8)];
    CGFloat created_atX = nameX;
    CGFloat created_atY = CGRectGetMaxY(self.nameFrame) + StatusPadding;
    CGSize created_atSize = [self.created_at sizeWithRestrictSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameFontSize];
    self.created_atFrame = CGRectMake(created_atX, created_atY, created_atSize.width, created_atSize.height);
    
    self.source = [self.source substringFromIndex:16];
    CGFloat sourceX = CGRectGetMaxX(self.created_atFrame) + StatusPadding;
    CGFloat sourceY = CGRectGetMaxY(self.nameFrame) + StatusPadding;
    CGSize sourceSize = [self.source sizeWithRestrictSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameFontSize];
    self.sourceFrame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    CGFloat textX = profile_imageX;
    CGFloat profile_imageMaxY = CGRectGetMaxY(self.profile_imageFrame);
    CGFloat sourceMaxY = CGRectGetMaxY(self.sourceFrame);
    CGFloat textY = profile_imageMaxY>sourceMaxY?profile_imageMaxY:sourceMaxY + StatusPadding;
    CGSize textSize = [self.text sizeWithRestrictSize:CGSizeMake(ScreenWidth - 2*StatusCellBorderWidth, MAXFLOAT) andFont:TextFontSize];
    self.textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    CGFloat picturesX = profile_imageX;
    CGFloat picturesY = CGRectGetMaxY(self.textFrame) + StatusPadding;
    int picturesCount = self.pic_urls.count;
    if (picturesCount == 0) {
        self.picturesFrame = CGRectMake(picturesX, picturesY, 0, 0);
    }else if (picturesCount == 1){
        NSString *urlStr = [self.pic_urls lastObject][@"thumbnail_pic"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        UIImage *image = [UIImage imageWithData:data];
        CGSize picturesSize = image.size;
        self.picturesFrame = CGRectMake(picturesX, picturesY, picturesSize.width, picturesSize.height);
    }else{
        self.picturesFrame = CGRectMake(picturesX, picturesY, 170, 170);
    }
    self.cellHeight = CGRectGetMaxY(self.picturesFrame);
}
@end
