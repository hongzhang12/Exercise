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
    
    CGFloat created_atX = nameX;
    CGFloat created_atY = CGRectGetMaxY(self.nameFrame) + StatusPadding;
    CGSize created_atSize = [_created_at sizeWithRestrictSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameFontSize];
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
    int picturesCount = (int)self.pic_urls.count;
    CGSize picturesSize = [self pictureSizeByPicturesCount:picturesCount];
    self.picturesFrame = CGRectMake(picturesX, picturesY, picturesSize.width, picturesSize.height);
    
    CGFloat originalH = CGRectGetMaxY(self.picturesFrame);
    self.originalFrame = CGRectMake(0, 0, ScreenWidth, originalH);
    CGFloat re_StatusX = 0;
    CGFloat re_StatusY = CGRectGetMaxY(self.originalFrame);
    CGFloat re_statusW = ScreenWidth;
    if (self.retweeted_status) {
        
        self.retweeted_statusUser = [NSString stringWithFormat:@"@%@:",self.retweeted_status.user.name];
        CGFloat re_UserX = profile_imageX;
        CGFloat re_UserY = 0;
        CGSize re_UserSize = [self.retweeted_statusUser sizeWithRestrictSize:CGSizeMake(re_statusW - 2*StatusCellBorderWidth, MAXFLOAT) andFont:NameFontSize];
        self.re_UserFrame = CGRectMake(re_UserX, re_UserY, re_UserSize.width, re_UserSize.height);
        
        CGFloat re_TextX = re_UserX;
        CGFloat re_TextY = CGRectGetMaxY(self.re_UserFrame) + StatusPadding;
        CGSize re_TextSize = [self.retweeted_status.text sizeWithRestrictSize:CGSizeMake(re_statusW - 2*StatusCellBorderWidth, MAXFLOAT) andFont:TextFontSize];
        self.re_TextFrame = CGRectMake(re_TextX, re_TextY, re_TextSize.width, re_TextSize.height);
        
        CGFloat re_picturesX = re_UserX;
        CGFloat re_picturesY = CGRectGetMaxY(self.re_TextFrame) + StatusPadding;
        int re_picturesCount = self.retweeted_status.pic_urls.count;
        CGSize re_picturesSize = [self pictureSizeByPicturesCount:re_picturesCount];
        self.re_picturesFrame = CGRectMake(re_picturesX, re_picturesY, re_picturesSize.width, re_picturesSize.height);
        
        CGFloat re_statusH = CGRectGetMaxY(self.re_picturesFrame);
        self.re_StatusFrame = CGRectMake(re_StatusX, re_StatusY, re_statusW, re_statusH);
    }else{
        self.re_StatusFrame = CGRectMake(re_StatusX, re_StatusY, 0, 0);
    }

    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(self.re_StatusFrame) + 1;
    CGFloat toolBarW = ScreenWidth;
    CGFloat toolBarH = statusToolBarHeight;
    self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    CGFloat toolBarItemY = 0;
    CGFloat toolBarItemW = toolBarW/3;
    CGFloat toolBarItemH = toolBarH;
    
    CGFloat responseX = 0;
    self.responseBtnFrame = CGRectMake(responseX, toolBarItemY, toolBarItemW, toolBarItemH);
    
    CGFloat forwardX = CGRectGetMaxX(self.responseBtnFrame);
    self.forwardBtnFrame = CGRectMake(forwardX, toolBarItemY, toolBarItemW, toolBarItemH);

    CGFloat goodX = CGRectGetMaxX(self.forwardBtnFrame);
    self.goodBtnFrame = CGRectMake(goodX, toolBarItemY, toolBarItemW, toolBarItemH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarFrame) + statusCellMargin;
}

- (CGSize)pictureSizeByPicturesCount:(int)picturesCount{
    CGSize picturesSize = {0,0};
    if (picturesCount == 0) {

    }else if (picturesCount == 1){
        NSString *urlStr = [self.pic_urls lastObject][@"thumbnail_pic"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        UIImage *image = [UIImage imageWithData:data];
        picturesSize = image.size;

    }else{
        int row = (picturesCount-1)/StatusPictureColumn;
        //int col = picturesCount%3;
        CGFloat picturesH = (row+1)*statusPictureLength + row*StatusPadding;
        CGFloat picturesW = StatusPictureColumn*statusPictureLength + (StatusPictureColumn-1)*StatusPadding;
        picturesSize = CGSizeMake(picturesW, picturesH);
    }
    return picturesSize;
}
//Fri Sep 12 12:35:51 +0800 2014
//Thu Oct 16 17:06:25 +0800 2014
- (NSString *)created_at
{
    //if (_created_at.length <20) return _created_at;
    //NSLog(@"--%@",_created_at);
    NSString *create_at = [_created_at stringByReplacingOccurrencesOfString:@"0800" withString:@"0000"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //formatter.dateFormat = @"yyyy-MM-dd H:mm:ss";
    //formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    NSDate *createDate = [formatter dateFromString:create_at];
    
    NSDate *localDate = [NSDate localDate];
//    NSCalendar *calender = [NSCalendar currentCalendar];
//    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|
//                           NSCalendarUnitDay|NSCalendarUnitHour|
//    NSCalendarUnitMinute|NSCalendarUnitSecond;
//    NSDateComponents *component = [calender components:unit fromDate:createDate toDate:localDate options:0];
    
    
    
    return [localDate relationWithOtherDate:createDate];
}

- (CGRect)created_atFrame
{
    CGFloat created_atX = _created_atFrame.origin.x;
    CGFloat created_atY = _created_atFrame.origin.y;
    CGSize created_atSize = [self.created_at sizeWithRestrictSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:NameFontSize];
    _created_atFrame = CGRectMake(created_atX, created_atY, created_atSize.width, created_atSize.height);
    return _created_atFrame;
}
- (CGRect)sourceFrame
{
    CGFloat sourceX = CGRectGetMaxX(self.created_atFrame) + StatusPadding;
    CGFloat sourceY = _sourceFrame.origin.y;
    _sourceFrame = CGRectMake(sourceX, sourceY, _sourceFrame.size.width, _sourceFrame.size.height);
    return _sourceFrame;
}
@end
