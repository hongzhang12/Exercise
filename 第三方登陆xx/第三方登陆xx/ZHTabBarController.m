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
    
    ZHSliderTableView *test = [[ZHSliderTableView alloc] initWithFrame:CGRectMake(-200, 0, 200, ScreenHeight)];
    [self.view insertSubview:test atIndex:0];
    test.dataSource = self;
    test.delegate = self;
    test.backgroundColor = [UIColor blueColor];
    self.sliderTableView = test;
    
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
        
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                subView.userInteractionEnabled = NO;
                NSLog(@"%@",subView.subviews);
            }
        }
    }else if(pan.state == UIGestureRecognizerStateEnded){
        
        for (UIView *subView in self.view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITransitionView")]) {
                
                NSLog(@"%@",subView.subviews);
                subView.userInteractionEnabled = YES;

            }
        }
    }
    CGFloat topX = translationPoint.x+x;
    CGFloat topY = topX/3;
    CGFloat topH = self.view.height - topY*2;
    CGFloat topW = ratio*topH;
    
//    if (topX<0 || topX>ZHTabBarControllerSliderShowX) {
//        NSLog(@"%f",topX);
//        return;
//    };
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        
        if (self.sliderState == ZHTabBarControllerSliderStateHidden) {
            if (vel.x>2) {
                self.sliderState = ZHTabBarControllerSliderStateShow;
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(240, 80, 320*ratio, 320);
                } completion:nil];
            }else{
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(0, 0, 320, 480);
                } completion:nil];
            }
        }else{
            if (vel.x<-2) {
                self.sliderState = ZHTabBarControllerSliderStateHidden;
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    topView.frame = CGRectMake(0, 0, 320, 480);
                } completion:nil];
            }else{
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    topView.frame = CGRectMake(240, 80, 320*ratio, 320);
                } completion:nil];
            }
        }
            
        
    }else{
        topView.frame = CGRectMake(topX, topY, topW, topH);
    }
    
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

//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"touchesBegan");
//}

#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *sliderCellID = @"sliderCellID";
    static int i = 0;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sliderCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sliderCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d%d%d",i,i,i];
    cell.textLabel.textColor = [UIColor purpleColor];
    i++;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",cell.textLabel.text);
    
}
@end
