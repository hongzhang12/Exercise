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

@implementation ZHPicture



@end

@interface ZHPictureView()<UIScrollViewDelegate>
@property (nonatomic ,weak) ZHPicture *originalView;

@end
@implementation ZHPictureView
-(instancetype)initWithImageUrlS:(NSArray *)imageUrls andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame{
    //MBProgressHUD *hud = [MBProgressHUD showMessage:@"loading.." toView:[UIWindow currentWindow]];
    
    NSMutableArray *images  = [NSMutableArray array];
    for (NSString *url in imageUrls) {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *image = [UIImage imageWithData:data];
        
        [images addObject:image];
    }
    //[hud hide:YES afterDelay:5.0];
    return [self initWithImages:images andPictureID:pictureID andOriginalFrame:originalFrame];
}
- (instancetype)initWithImages:(NSMutableArray *)images andPictureID:(int)pictureID andOriginalFrame:(CGRect)originalFrame{
    if (self = [super init]) {
        self.pictureImages = images;
        
        self.originalFrame = originalFrame;
        self.runTime = 0.75;
        if (pictureID > (images.count - 1)) {
            self.pictureID = 0;
        }else{
            self.pictureID = pictureID;
        }
        
        UILabel *pageLabel = [[UILabel alloc] init];
        pageLabel.width = 50;
        pageLabel.height = 15;
        pageLabel.centerX = ScreenWidth/2;
        pageLabel.y = 30;
        
        pageLabel.text = [NSString stringWithFormat:@"%d/%d",pictureID+1,images.count];
        pageLabel.textColor = [UIColor whiteColor];
        [self insertSubview:pageLabel aboveSubview:self.scrollView];
        self.pageLabel = pageLabel;

        
        self.frame = CGRectMake(0, 0, ScreenWidth,ScreenHeight);
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperview)];
        [self addGestureRecognizer:tap];

        self.scrollView.contentSize = CGSizeMake(ScreenWidth*images.count, 0);
        self.scrollView.contentOffset = CGPointMake(ScreenWidth*self.pictureID, 0);
        
        
        for (int i = 0;i< images.count;i++) {
            UIImage *image = images[i];
            ZHPicture *imageView = [[ZHPicture alloc] initWithImage:image];
            imageView.userInteractionEnabled = YES;
            
            [self.scrollView addSubview:imageView];
            
            if (i == pictureID) {
                imageView.frame = self.originalFrame;
                imageView.x += ScreenWidth * i;
                //imageView.size = image.size;
                self.originalView = imageView;
            }else{
                CGFloat ratio = imageView.height/imageView.width;
                imageView.frame = CGRectMake(ScreenWidth*i, (ScreenHeight-ratio*ScreenWidth)/2, ScreenWidth, ratio*ScreenWidth);
            }
        }
        
    }
    return self;
}


- (void)run{
    [[UIWindow currentWindow] addSubview:self];
    
    [UIView animateWithDuration:self.runTime animations:^{
        CGFloat ratio = self.originalView.height/self.originalView.width;
        self.originalView.frame = CGRectMake(ScreenWidth*self.pictureID, (ScreenHeight-ratio*ScreenWidth)/2, ScreenWidth, ratio*ScreenWidth);

    }];
    
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
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.scrollView.frame = frame;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    int intX = (int)(x/ScreenWidth+0.5) + 1;
    NSLog(@"%f---%d",x/ScreenWidth,intX);
    self.pageLabel.text = [NSString stringWithFormat:@"%d/%d",intX,self.pictureImages.count];
}
@end
