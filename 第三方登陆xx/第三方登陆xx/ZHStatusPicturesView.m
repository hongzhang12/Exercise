//
//  ZHStatusPicturesView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/23.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHStatusPicturesView.h"
#import "UIImageView+WebCache.h"
#import "ZHExtension.h"
#import "ZHStatusModel.h"
@implementation ZHStatusPicturesView

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)layoutSubviews
{
    
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
}
//- (void)setPic_urls:(NSArray *)pic_urls
//{
//    [self setPic_urls:pic_urls];
//}
- (NSMutableArray *)pictureImages
{
    if (_pictureImages == nil) {
        _pictureImages = [NSMutableArray array];
    }
    return _pictureImages;
}
- (void)setPic_urls:(NSArray *)pic_urls andFrame:(CGRect)frame
{
    self.frame = frame;
    for (UIView *view in self.pictureImages) {
        [view removeFromSuperview];
    }
    self.pictureImages = nil;
//    self.pic_urls = pic_urls;
    int count = (int)pic_urls.count;
    if (count == PictureCountNone) {

    }else if(count == PictureCountOnlyOne){
        UIImageView *picture = [[UIImageView alloc] initWithFrame:self.bounds];
        [picture sd_setImageWithURL:[NSURL URLWithString:[pic_urls lastObject][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
        [self addSubview:picture];
        [self.pictureImages addObject:picture];
    }else{
        for (int i = 0; i < count; i++) {
            UIImageView *picture = [[UIImageView alloc] init];
            int row = i/StatusPictureColumn;
            int col = i%StatusPictureColumn;
            CGFloat picturesX = col*(statusPictureLength+StatusPadding);
            CGFloat picturesY = row*(statusPictureLength+StatusPadding);
            picture.frame = CGRectMake(picturesX, picturesY, statusPictureLength, statusPictureLength);
            [picture sd_setImageWithURL:[NSURL URLWithString:(pic_urls[i])[@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"placeHolder.jpg"]];
            [self addSubview:picture];
            [self.pictureImages addObject:picture];
        }
    }
}
@end
