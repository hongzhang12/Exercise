//
//  ZHPictureView.h
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZHPicture :UIImageView

@end

@interface ZHPictureView : UIView
@property (nonatomic ,weak) UILabel *pageLabel;
@property (nonatomic ,strong) NSMutableArray *pictureImages;
@property (nonatomic ,assign) int pictureID;
@property (nonatomic ,assign) CGRect originalFrame;
@property (nonatomic ,weak) UIScrollView *scrollView;
/*
 默认属性
*/
//默认为0.75
@property (nonatomic ,assign) CGFloat runTime;
- (instancetype)initWithImages:(NSMutableArray *)images andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame;
- (instancetype)initWithImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame;
- (void)run;
@end
