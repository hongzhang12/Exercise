//
//  ZHPictureView.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/9/9.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHPictureView.h"
#import "ZHPictureScrollView.h"
#import "ZHPicture.h"
#import "UIImageView+WebCache.h"
@interface ZHPictureView ()<UIScrollViewDelegate>
@property (nonatomic ,weak) ZHPictureScrollView *scrollView;
@property (nonatomic ,assign) ZHPictureViewState state;
@property (nonatomic ,assign) int index;
@property (nonatomic ,weak) UILabel *pageLabel;

@property (nonatomic ,strong) NSMutableArray *pictureImages;
@property (nonatomic ,strong) NSArray *pictures;
@property (nonatomic ,strong) NSArray *pictureUrls;
@property (nonatomic ,assign) int pictureID;
@end

@implementation ZHPictureView
-(instancetype)initWithBigImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andPictures:(NSArray *)pictures{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.pictureID = pictureID;
        self.pictureUrls = imageUrls;
        self.pictures = pictures;
    
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        [self addGestureRecognizer:tap];
        
        self.state = ZHPictureViewNone;
        self.backgroundColor = [UIColor grayColor];
        int count = pictures.count;
        CGFloat width = ScreenWidth;
        CGFloat height = ScreenHeight;
        
        ZHPictureScrollView *scrollView = [[ZHPictureScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];

        [self addSubview:scrollView];
        scrollView.delegate = self;
        //scrollView.delegate = self;
        self.scrollView = scrollView;
        
        //测试view
        for (int i = 0; i<count; i++) {
            ZHPicture *scrView = [[ZHPicture alloc] initWithFrame:CGRectMake(width*i, 0, width, height)];

            if (i == pictureID) {
                UIImageView *smallImage = pictures[i];
                scrView.imageView.frame = [smallImage golbalFrame];
            }
            scrView.backgroundColor = [UIColor colorWithRed:i/5.0 green:i/5.0 blue:i/5.0 alpha:1.0];
            [scrollView addSubview:scrView];
            scrView.delegate = self;
            
            [self.pictureImages addObject:scrView];
        }
        CGFloat pageLabelW = 50;
        CGFloat pageLabelH = 20;
        CGFloat pageLabelX = (ScreenWidth - pageLabelW)/2;
        CGFloat pageLabelY = 40;
        
        UILabel *pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(pageLabelX, pageLabelY, pageLabelW, pageLabelH)];
        pageLabel.textAlignment = NSTextAlignmentCenter;
        pageLabel.textColor = [UIColor whiteColor];
        [self addSubview:pageLabel];
        self.pageLabel = pageLabel;
        
        self.index = self.pictureID;
        self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
    }
    return self;

}


-(void)run{
    [[UIWindow currentWindow] addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        
        ZHPicture *bigImage = self.pictureImages[self.pictureID];
        bigImage.imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
        
    } completion:^(BOOL finished) {
        
        //        if (self.pictureType == ZHPictureTypeUrl) {
        //            NSString *url = self.pictureUrls[self.pictureID];
        //            [self.originalView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:self.originalView.image];
        //        }
        
    }];
}
- (void)removeFromSuperview{

    
    
    ZHPicture *bigImage = self.pictureImages[self.index];

    if (bigImage.zoomScale>1.0) {
        [bigImage setZoomScale:1.0];
    }
    
    //[bigImage setContentOffset:CGPointMake(0, 0) animated:NO];
    NSLog(@"%@",NSStringFromCGRect(bigImage.frame));
    UIImageView *smallImage = self.pictures[self.index];
    CGRect frame = [smallImage golbalFrame];


    [UIView animateWithDuration:0.5 animations:^{

        bigImage.imageView.frame = frame;


    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:ZHPictureViewTransitionTime animations:^{
//            self.alpha = 0;
//
//        } completion:^(BOOL finished) {
//            [super removeFromSuperview];
//        }];
        [super removeFromSuperview];
        
    }];
}
#pragma mark - scrollview代理
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return [scrollView.subviews firstObject];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{

    NSLog(@"%f",scale);
//    if (scrollView != self.scrollView) {
//        if (scale<1.0) {
//            self.scrollView.scrollEnabled = YES;
//        }else{
//            self.scrollView.scrollEnabled = NO;
//        }
//    }

}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == self.scrollView) {
//        
//    }
//}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (scrollView != self.scrollView) {
        if (velocity.x>1.7 && self.index<(self.pictureImages.count-1)) {
            
            self.state = ZHPictureViewNext;
        }else if(velocity.x<-1.7&&self.index>0){
            self.state = ZHPictureViewPrecious;
        }
    }
    
    NSLog(@"scrollViewWillEndDragging: withVelocity: targetContentOffset:");
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDecelerating");

    if (scrollView != self.scrollView) {
        if (self.state == ZHPictureViewNext) {
            
            [UIView animateWithDuration:0.5 animations:^{
                self.index++;
                self.scrollView.contentOffset = CGPointMake(320*self.index, 0);
                
            } completion:^(BOOL finished) {
                [scrollView setZoomScale:1];
                self.state = ZHPictureViewNone;
            }];
        }else if(self.state == ZHPictureViewPrecious){
            
            [UIView animateWithDuration:0.5 animations:^{
                self.index--;
                self.scrollView.contentOffset = CGPointMake(320*self.index, 0);
                
            } completion:^(BOOL finished) {
                [scrollView setZoomScale:1];
                self.state = ZHPictureViewNone;
            }];
        }

    }
}

- (void)setIndex:(int)index{
    int count = self.pictureImages.count;
    if (index < 0||index>(count-1)) return;
    _index = index;
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",index+1,count];
    [self loadBigImsgeAtIndex:index];
}

- (void)loadBigImsgeAtIndex:(NSUInteger)index{
    ZHPicture *imageView = self.pictureImages[index];
    
    NSString *url = self.pictureUrls[index];
    UIImageView *picture = self.pictures[index];
    
    [imageView.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:picture.image];
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
        _pictureUrls = [[NSMutableArray alloc] init];
    }
    return _pictureUrls;
}
@end
