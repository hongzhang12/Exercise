//
//  ZHPictureView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
//typedef enum{
//    ZHPictureTypeImage,
//    ZHPictureTypeUrl
//}ZHPictureType;
#define ZHPictureViewTransitionTime 0.1
#define ZHPictureViewRunTime 0.75


@interface ZHPicture :UIImageView

@end

@interface ZHPictureView : UIView
/*
默认属性
 */
// 默认2.0
@property (nonatomic ,assign) CGFloat pictureMaxScale;
// 默认0.3
@property (nonatomic ,assign) CGFloat pictureMinScale;





//- (instancetype)initWithImages:(NSMutableArray *)images andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame;
-(instancetype)initWithBigImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andPictures:(NSArray *)pictures;
- (void)run;
@end
