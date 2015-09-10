//
//  ZHTabBarController.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/12.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHTabBarController.h"
#import "ZHSliderTableView.h"

@interface ZHTabBarController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,weak) ZHSliderTableView *sliderTableView;
@property (nonatomic ,assign) ZHTabBarControllerSliderState sliderState;
@property (nonatomic ,weak) UIView *transitionView;
@end

@implementation ZHTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToslideBar)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    //[self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeForBack)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    //[self.view addGestureRecognizer:swipeLeft];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panForSlider:)];
    [self.view addGestureRecognizer:pan];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
            self.transitionView = subView;
        }
    }
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.image = [UIImage imageNamed:@"bg_home_960@2x.jpg"];
    [self.view insertSubview:bg atIndex:0];
    
    ZHSliderTableView *sliderTableView = [[ZHSliderTableView alloc] initWithFrame:CGRectMake(-200, 0, 200, ScreenHeight)];
    [self.view insertSubview:sliderTableView aboveSubview:bg];
    sliderTableView.dataSource = self;
    sliderTableView.delegate = self;
    self.sliderTableView = sliderTableView;
    
    self.sliderState = ZHTabBarControllerSliderStateHidden;
    self.tabBar.hidden = YES;
}
- (void)panForSlider:(UIPanGestureRecognizer *)pan{
    NSLog(@"%f",[pan locationInView:self.view].x);
    
    static CGFloat x = 0;
    
    CGPoint translationPoint = [pan translationInView:self.view];
    CGPoint vel = [pan velocityInView:self.view];
    UIView *topView = self.selectedViewController.view;

    CGFloat ratio = topView.width/topView.height;


    if (pan.state == UIGestureRecognizerStateBegan) {
        x = topView.x;
    }
    CGFloat topX = translationPoint.x+x;
    CGFloat topY = topX/3;
    CGFloat topH = self.view.height - topY*2;
    CGFloat topW = ratio*topH;
    
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.sliderState == ZHTabBarControllerSliderStateHidden) {
            if (vel.x>2) {
                self.sliderState = ZHTabBarControllerSliderStateShow;
                [self.sliderTableView show];
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(240, 80, 320*ratio, 320);
                } completion:nil];
            }else{
                [self.sliderTableView hidden];
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(0, 0, 320, 480);
                } completion:nil];
            }
        }else{
            if (vel.x<-2) {
                [self.sliderTableView hidden];
                self.sliderState = ZHTabBarControllerSliderStateHidden;
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(0, 0, 320, 480);
                } completion:nil];
            }else{
                [self.sliderTableView show];
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    topView.frame = CGRectMake(240, 80, 320*ratio, 320);
                } completion:nil];
            }
        }
            
        
    }else{
        topView.frame = CGRectMake(topX, topY, topW, topH);
    }
    
}
- (void)setSliderState:(ZHTabBarControllerSliderState)sliderState{
    _sliderState = sliderState;
    self.transitionView.userInteractionEnabled = sliderState == ZHTabBarControllerSliderStateHidden?YES:NO;
}
- (void)swipeToslideBar{
    self.tabBar.hidden = YES;
    UIView *topView = self.selectedViewController.view;
    CGFloat ratio = topView.width/topView.height;
    CGFloat topY = 60;
    CGFloat topH = self.view.height - topY*2;
    CGFloat topW = ratio*topH;
    CGFloat topX = 250;
    
    [UIView animateWithDuration:0.4 animations:^{
        topView.frame = CGRectMake(topX, topY, topW, topH);
        self.sliderTableView.frame = CGRectMake(0, self.sliderTableView.y, self.sliderTableView.width, self.sliderTableView.height);
    } completion:^(BOOL finished) {
        //topView.userInteractionEnabled = NO;
        //topView.frame = CGRectMake(topX, topY, topW, topH);
        
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                subView.userInteractionEnabled = NO;
                NSLog(@"%@",subView.subviews);
            }
        }
        
        
    }];
    //[self.view bringSubviewToFront:self.sliderTableView];
}

- (void)swipeForBack{
    //[self.view sendSubviewToBack:self.sliderTableView];
    UIView *topView = self.selectedViewController.view;
    
    [UIView animateWithDuration:0.4 animations:^{
        topView.frame = self.view.bounds;
        self.sliderTableView.frame = CGRectMake(-200, self.sliderTableView.y, self.sliderTableView.width, self.sliderTableView.height);
    } completion:^(BOOL finished) {
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                subView.userInteractionEnabled = YES;
                NSLog(@"%@",subView.subviews);
            }
        }
        self.tabBar.hidden = NO;
    }];
}



#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *sliderCellID = @"sliderCellID";
    static int i = 0;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sliderCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:sliderCellID];
    }
    cell.backgroundColor = [UIColor clearColor];

    cell.textLabel.text = [NSString stringWithFormat:@"%d%d%d",i,i,i];
    cell.textLabel.textColor = [UIColor whiteColor];
    i++;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.textLabel.text);
    
}
@end
