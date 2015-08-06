//
//  ZHComposeAlbum.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/6.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHComposeAlbum.h"

@implementation ZHComposeAlbum

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        _pictureArr = [NSMutableArray array];
        //self.backgroundColor = [UIColor blueColor];
    }
    return self;
    
}
-(instancetype)init{
    if (self = [super init]) {
        _pictureArr = [NSMutableArray array];
    }
    return self;
}
-(void)addPicture:(UIImage *)picture{
    
    picture = [picture imageWIthCompressInSize:CGSizeMake(100, 100)];
    NSData *imagedata = UIImageJPEGRepresentation(picture, 1);
    
    int count = self.pictureArr.count;
    int row = count%3;
    int col = count/3;
    CGFloat pictureViewX = row*(ZHComposeAlbumPictureLength+ZHComposeAlbumPictureMargin);
    CGFloat pictureViewY = col*(ZHComposeAlbumPictureLength+ZHComposeAlbumPictureMargin);
    UIImageView *pictureView = [[UIImageView alloc] initWithImage:picture];
    pictureView.userInteractionEnabled = YES;
    pictureView.frame = CGRectMake(pictureViewX, pictureViewY, ZHComposeAlbumPictureLength, ZHComposeAlbumPictureLength);
    [self addSubview:pictureView];
    
    [self.pictureArr addObject:imagedata];
}

@end
