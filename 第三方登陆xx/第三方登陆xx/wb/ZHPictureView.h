//
//  ZHPictureView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ZHPictureTypeImage,
    ZHPictureTypeUrl
}ZHPictureType;
#define ZHPictureViewTransitionTime 0.25
#define ZHPictureViewRunTime 0.75

@interface ZHPicture :UIImageView

@end

@interface ZHPictureView : UIView
@property (nonatomic ,weak) UILabel *pageLabel;
@property (nonatomic ,strong) NSMutableArray *pictureImages;
@property (nonatomic ,strong) NSArray *pictureUrls;
@property (nonatomic ,assign) int pictureID;
@property (nonatomic ,assign) CGRect originalFrame;
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,assign) ZHPictureType pictureType;
/*
 默认属性
*/

- (instancetype)initWithImages:(NSMutableArray *)images andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame;
- (instancetype)initWithImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame;
- (void)run;
@end
