//
//  ZHNewFeaturesController.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/6/25.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHNewFeaturesController.h"
#import "ZHExtension.h"
#import "customNavigationController.h"
#define NewFeaturesPage 4
@interface ZHNewFeaturesController ()<UIScrollViewDelegate>
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;
@end

@implementation ZHNewFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.contentSize = CGSizeMake(self.view.width*NewFeaturesPage, self.view.height);
    for (int i = 0; i<NewFeaturesPage; i++) {
        UIImageView *newFeature = [[UIImageView alloc] init];
        
        newFeature.size = self.view.size;
        newFeature.y = 0;
        newFeature.x = self.view.width*i;
        
        NSString *temp = [NSString stringWithFormat:@"new_feature_%d",i+1];
        newFeature.image = [UIImage imageNamed:temp];
        
        [scrollView addSubview:newFeature];
        if (i == 3) {
            
            newFeature.userInteractionEnabled = YES;
            
            UIButton *share = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height*0.6, self.view.width*0.5, self.view.height*0.1)];
            //share.backgroundColor = [UIColor greenColor];
            share.centerX = self.view.centerX;
            share.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [share setTitle:@"share to others" forState:UIControlStateNormal];
            [share setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
            [share setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
            [share addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [newFeature addSubview:share];
            
            UIButton *begin = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.height*0.7, self.view.width*0.6, self.view.height*0.1)];
            //begin.backgroundColor = [UIColor redColor];
            begin.centerX = self.view.centerX;
            [begin setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
            [begin setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
            [begin setTitle:@"begin" forState:UIControlStateNormal];
            [begin addTarget:self action:@selector(beginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [newFeature addSubview:begin];
        }
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.height*0.9, self.view.width*0.2, 0)];
    pageControl.centerX = self.view.center.x;
    pageControl.numberOfPages = NewFeaturesPage;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //pageControl.backgroundColor = [UIColor redColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}
#pragma mark - share and begin
- (void)shareBtnClicked:(UIButton *)button{
    button.selected = !button.selected;
}
- (void)beginBtnClicked:(UIButton *)button{
    
    customNavigationController *nav = [[customNavigationController alloc] init];

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = nav;

    
}
#pragma mark - UIScrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"xxx");
    NSLog(@"%f- -%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    CGFloat x = scrollView.contentOffset.x;
    int intX = (int)(x/self.view.width+0.5);
    NSLog(@"%f---%d",x/self.view.width,intX);
    self.pageControl.currentPage = intX;

}
@end
