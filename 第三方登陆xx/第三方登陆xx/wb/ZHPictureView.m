//
//  ZHPictureView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/29.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHPictureView.h"
#import "ZHPictureBtn.h"
#import "ZHExtension.h"
#import "UIImageView+WebCache.h"
@implementation ZHPicture



@end

@interface ZHPictureView()<UIScrollViewDelegate>

@property (nonatomic ,assign) CGFloat ratio;
@end
@implementation ZHPictureView

-(instancetype)initWithBigImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andPictures:(NSArray *)pictures{

    if (self = [super init]) {
        

        self.pictureUrls = imageUrls;
        self.pictures = pictures;
        self.alpha = 0;
        self.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        [self addGestureRecognizer:tap];

        
        if (pictureID > (imageUrls.count - 1)) {
            self.pictureID = 0;
        }else{
            self.pictureID = pictureID;
        }
        
        UILabel *pageLabel = [[UILabel alloc] init];
        pageLabel.textAlignment = NSTextAlignmentCenter;
        pageLabel.width = 50;
        pageLabel.height = 15;
        pageLabel.centerX = ScreenWidth/2;
        pageLabel.y = 30;
        
        pageLabel.text = [NSString stringWithFormat:@"%d/%d",pictureID+1,(int)imageUrls.count];
        pageLabel.textColor = [UIColor whiteColor];
        [self insertSubview:pageLabel aboveSubview:self.scrollView];
        self.pageLabel = pageLabel;
        
        
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.userInteractionEnabled = YES;
        
        
        self.scrollView.contentSize = CGSizeMake(ScreenWidth*imageUrls.count, 0);
        
        
        
        for (int i = 0;i< pictures.count;i++) {

            ZHPicture *imageView = [[ZHPicture alloc] initWithFrame:CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight)];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.centerY = ScreenHeight/2;
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            
            [self.scrollView addSubview:imageView];
            [self.pictureImages addObject:imageView];
            
        }
        if
        self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
        
    }
    return self;
}
//- (instancetype)initWithImages:(NSMutableArray *)images andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame{
//    if (self = [super init]) {
//        self.pictureType = ZHPictureTypeImage;
//        self.pictureImages = images;
//        self.alpha = 0;
//
//
//        if (pictureID > (images.count - 1)) {
//            self.pictureID = 0;
//        }else{
//            self.pictureID = pictureID;
//        }
//        
//        UILabel *pageLabel = [[UILabel alloc] init];
//        pageLabel.width = 50;
//        pageLabel.height = 15;
//        pageLabel.centerX = ScreenWidth/2;
//        pageLabel.y = 30;
//        
//        pageLabel.text = [NSString stringWithFormat:@"%d/%d",pictureID+1,(int)images.count];
//        pageLabel.textColor = [UIColor whiteColor];
//        [self insertSubview:pageLabel aboveSubview:self.scrollView];
//        self.pageLabel = pageLabel;
//
//        
//        self.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight);
//        self.scrollView.delegate = self;
//        self.scrollView.backgroundColor = [UIColor blackColor];
//        self.scrollView.pagingEnabled = YES;
//        self.scrollView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
//        [self addGestureRecognizer:tap];
//
//        self.scrollView.contentSize = CGSizeMake(ScreenWidth*images.count, 0);
//        self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
//        
//        
//        for (int i = 0;i< images.count;i++) {
//            UIImage *image = images[i];
//            ZHPicture *imageView = [[ZHPicture alloc] initWithImage:image];
//            imageView.userInteractionEnabled = YES;
//            
//            [self.scrollView addSubview:imageView];
//            
//            if (i == pictureID) {
//
//                imageView.x += ScreenWidth * i;
//                //imageView.size = image.size;
//                self.ratio = image.size.height/image.size.width;
//                self.originalView = imageView;
//                //self.originalView.alpha = 1;
//            }else{
//                CGFloat ratio = imageView.height/imageView.width;
//                imageView.frame = CGRectMake(ScreenWidth*i, (ScreenHeight-ratio*ScreenWidth)/2, ScreenWidth, ratio*ScreenWidth);
//            }
//        }
//        
//    }
//    return self;
//}

-(void)removeFromSuperview
{
    [UIView animateWithDuration:ZHPictureViewTransitionTime animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}
- (void)run{
    [[UIWindow currentWindow] addSubview:self];
    
    [UIView animateWithDuration:ZHPictureViewTransitionTime animations:^{
        self.alpha = 1;
    }];
    
    [UIView animateWithDuration:ZHPictureViewRunTime animations:^{
        
        if (self.ratio < (ScreenHeight/ScreenWidth)) {
//            self.originalView.frame = CGRectMake(ScreenWidth*self.pictureID, (ScreenHeight-self.ratio*ScreenWidth)/2, ScreenWidth, self.ratio*ScreenWidth);
        }else{
//            self.originalView.frame = CGRectMake(ScreenWidth*self.pictureID+(ScreenWidth-ScreenHeight/self.ratio)/2, 0, ScreenHeight/self.ratio, ScreenHeight);
        }


    } completion:^(BOOL finished) {
        
//        if (self.pictureType == ZHPictureTypeUrl) {
//            NSString *url = self.pictureUrls[self.pictureID];
//            [self.originalView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:self.originalView.image];
//        }

    }];
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.scrollView.frame = frame;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    NSUInteger intX = (NSUInteger)(x/ScreenWidth+0.5);
    NSLog(@"%f---%d",x/ScreenWidth,intX);
    
    [self loadBigImsgeAtIndex:intX];
    
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",intX+1,self.pictureUrls.count];
}
- (void)loadBigImsgeAtIndex:(NSUInteger)index{
    UIImageView *imageView = self.pictureImages[index];
    
    NSString *url = self.pictureUrls[index];
    UIImageView *picture = self.pictures[index];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:picture.image];
}
- (NSMutableArray *)pictureImages
{
    if (_pictureImages == nil) {
        _pictureImages = [NSMutableArray array];
    }
    return _pictureImages;
}
- (NSMutableArray *)pictureUrls
{
    if (_pictureUrls == nil) {
        _pictureUrls = [NSMutableArray array];
    }
    return _pictureUrls;
}
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}
@end
