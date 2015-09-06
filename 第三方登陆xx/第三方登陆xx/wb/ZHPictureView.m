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
- (instancetype)init
{
    if (self = [super init]) {

    }
    return self;
}

@end

@interface ZHPictureView()<UIScrollViewDelegate>
@property (nonatomic ,assign) CGFloat preScale;
@property (nonatomic ,assign) CGPoint prePoint;

@property (nonatomic ,assign) CGFloat ratio;
@property (nonatomic ,weak) UILabel *pageLabel;
@property (nonatomic ,strong) NSMutableArray *pictureImages;
@property (nonatomic ,strong) NSArray *pictures;
@property (nonatomic ,strong) NSArray *pictureUrls;
@property (nonatomic ,assign) int pictureID;

@property (nonatomic ,weak) UIScrollView *scrollView;
@end
@implementation ZHPictureView

-(instancetype)initWithBigImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andPictures:(NSArray *)pictures{

    if (self = [super init]) {
        
        self.pictureMaxScale = 2;
        self.pictureMinScale = 0.3;
        self.preScale = 1.0;
        self.prePoint = CGPointMake(0, 0);
        self.pictureUrls = imageUrls;
        self.pictures = pictures;
        self.alpha = 0;
        self.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight);
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinch];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        [tap requireGestureRecognizerToFail:pinch];
        [self addGestureRecognizer:tap];

        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        
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
        
        self.scrollView.scrollEnabled = NO;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.userInteractionEnabled = YES;
        
        
        self.scrollView.contentSize = CGSizeMake(ScreenWidth*imageUrls.count, 0);
        
        
        
        for (int i = 0;i< pictures.count;i++) {

            ZHPicture *imageView = [[ZHPicture alloc] init];
            if (i == self.pictureID) {
                UIImageView *smallImage = pictures[i];
                imageView.frame = [smallImage golbalFrame];
                imageView.x = imageView.x + ScreenWidth*i;
            }else{
                imageView.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight);
            }
            imageView.backgroundColor = [UIColor clearColor];
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.userInteractionEnabled = YES;
            
            [self.scrollView addSubview:imageView];
            [self.pictureImages addObject:imageView];
            

        }
        if(self.pictureID == 0){
            [self loadBigImsgeAtIndex:self.pictureID];
        }else{
            self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
        }
        
        
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    ZHPicture *picture = self.pictureImages[[self currentIndex]];


    
    CGPoint trans = [pan translationInView:[UIWindow currentWindow]];
    
    CGPoint currentPoint = CGPointMake(trans.x-self.prePoint.x, trans.y-self.prePoint.y);

    
    if (pan.state == UIGestureRecognizerStateBegan) {

        CGPoint transPoint = CGPointMake(trans.x+self.prePoint.x , self.prePoint.y+trans.y);
        CGAffineTransform aff = picture.transform;
        aff = CGAffineTransformTranslate(picture.transform, transPoint.x, transPoint.y);
        picture.transform = aff;

    }else{
        picture.transform = CGAffineTransformTranslate(picture.transform,currentPoint.x, currentPoint.y);

        if (picture.x>self.width*[self currentIndex]) {
            picture.x = self.width*[self currentIndex];
            self.scrollView.scrollEnabled = YES;
        }
        NSLog(@"%@",NSStringFromCGRect(picture.frame));

    }
    self.prePoint = CGPointMake(trans.x, trans.y);
    if (pan.state == UIGestureRecognizerStateEnded) {
        self.prePoint = CGPointMake(0, 0);
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{

    ZHPicture *picture = self.pictureImages[[self currentIndex]];
    CGFloat scale = self.preScale * pinch.scale;
    if (scale >self.pictureMaxScale) scale = self.pictureMaxScale;
    if (scale <self.pictureMinScale) scale = self.pictureMinScale;
    if (pinch.state == UIGestureRecognizerStateBegan) {
        picture.transform = CGAffineTransformScale(self.transform, scale, scale);
    }else{
        picture.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    if (pinch.state == UIGestureRecognizerStateEnded) {
        self.preScale = scale;
    }
    
}
-(void)removeFromSuperview
{
    for (int i = 0; i<self.pictures.count; i++) {
        UIImageView *smallPicture = self.pictures[i];
        UIImageView *bigPicture = self.pictureImages[i];
        if (bigPicture.image) {
            smallPicture.image = bigPicture.image;
        }
        
    }
    NSUInteger index = [self currentIndex];

    UIImageView *bigImage = self.pictureImages[index];
    UIImageView *smallImage = self.pictures[index];
    CGRect frame = [smallImage golbalFrame];
    frame.origin.x = frame.origin.x + ScreenWidth*index;
    
    [UIView animateWithDuration:ZHPictureViewRunTime animations:^{

        bigImage.frame = frame;
        
        
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
- (void)run{
    [[UIWindow currentWindow] addSubview:self];
    
    [UIView animateWithDuration:ZHPictureViewTransitionTime animations:^{
        self.alpha = 1;
    }];
    
    [UIView animateWithDuration:ZHPictureViewRunTime animations:^{
        
        UIImageView *bigImage = self.pictureImages[self.pictureID];
        bigImage.frame = CGRectMake(ScreenWidth*self.pictureID, 0, ScreenWidth, ScreenHeight);


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

    NSUInteger currentIndex = [self currentIndex];
    if (currentIndex != intX+1) {
        ZHPicture *picture = self.pictureImages[currentIndex];
        picture.transform = CGAffineTransformIdentity;
//        self.scrollView.userInteractionEnabled = NO;
    }
    
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
- (NSUInteger)currentIndex{
    return [[self.pageLabel.text substringToIndex:1] integerValue] - 1;
}
@end
