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
#import "ZHPictureBtn.h"
#import "customNavigationController.h"
#import "ZHHomeTableViewController.h"
#import "ZHPictureViewController.h"
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
    self.pic_urls = nil;
    
    self.pic_urls = pic_urls;
    int count = (int)pic_urls.count;
    if (count == PictureCountNone) {

    }else if(count == PictureCountOnlyOne){
        ZHPictureBtn *picture = [[ZHPictureBtn alloc] init];
        picture.frame = self.bounds;
        [picture.imageView sd_setImageWithURL:[NSURL URLWithString:[pic_urls lastObject][@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        picture.tag = 0;
        [picture addTarget:self action:@selector(pictureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:picture];
        [self.pictureImages addObject:picture];
    }else{
        for (int i = 0; i < count; i++) {
            ZHPictureBtn *picture = [[ZHPictureBtn alloc] init];
            int row = i/StatusPictureColumn;
            int col = i%StatusPictureColumn;
            CGFloat picturesX = col*(statusPictureLength+StatusPadding);
            CGFloat picturesY = row*(statusPictureLength+StatusPadding);
            picture.frame = CGRectMake(picturesX, picturesY, statusPictureLength, statusPictureLength);
            [picture.imageView sd_setImageWithURL:[NSURL URLWithString:(pic_urls[i])[@"thumbnail_pic"]] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            picture.tag = i;
            [picture addTarget:self action:@selector(pictureBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:picture];
            [self.pictureImages addObject:picture];
        }
    }
}
- (void)pictureBtnClicked:(ZHPictureBtn *)pictureBtn{
//    //NSLog(@"xxxxxxxxx");
//    UIWindow *window = [UIWindow currentWindow];
//    customNavigationController *customerCtr = (customNavigationController *)window.rootViewController;
//    ZHHomeTableViewController *homeCtr = (ZHHomeTableViewController *)customerCtr.topViewController;
////    NSLog(@"%@",customerCtr.topViewController);
//    ZHPictureViewController *pictureCtr = [[ZHPictureViewController alloc] init];
//    pictureCtr.pictureID = pictureBtn.tag;
//    pictureCtr.pictureImages = self.pic_urls;
//    pictureCtr.zh_frame = [pictureBtn convertRect:pictureBtn.bounds toView:[UIWindow currentWindow]];
//    [homeCtr presentViewController:pictureCtr animated:NO completion:^{
//        
//    }];
    [pictureBtn setFullScreenFrame];
}
@end
