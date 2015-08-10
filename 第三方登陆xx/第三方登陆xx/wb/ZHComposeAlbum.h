//
//  ZHComposeAlbum.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/6.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ZHComposeAlbumPictureLength 100
#define ZHComposeAlbumPictureMargin (ScreenWidth - 3*ZHComposeAlbumPictureLength)/4
@interface ZHComposeAlbum : UIView
@property (nonatomic,strong,readonly) NSMutableArray *pictureArr;
- (void)addPicture:(UIImage *)picture;
@end
