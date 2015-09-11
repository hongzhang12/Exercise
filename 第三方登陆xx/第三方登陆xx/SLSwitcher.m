//
//  SLSwitcher.m
//  SLSwitcher
//
//  Created by Jian Hu on 7/8/15.
//  Copyright (c) 2015 Jian Hu. All rights reserved.
//

#import "SLSwitcher.h"
#import <QuartzCore/QuartzCore.h>

@implementation SLSwitcher{
    UIButton *_leftBtn;
    UIButton *_rightBtn;
    UIView *_circleView;
    UIView *_innerCircleView;
    CGFloat _panStartPoint;
    
    //some convenience ivars, to avoid recalculation
    CGPoint _circleLeftPoint;
    CGPoint _circleCenterPoint;
    CGPoint _circleRightPoint;
    UIColor *_leftColor;
    UIColor *_centerColor;
    UIColor *_rightColor;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        //_selectState = NoSelection;
        
        //init colors
        _leftColor = [UIColor colorWithRed:253/255.0 green:222/255.0 blue:164/255.0 alpha:1];
        _centerColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        _rightColor = [UIColor colorWithRed:166/255.0 green:246/255.0 blue:198/255.0 alpha:1];
        
        CGFloat frameWidth = self.frame.size.width;
        CGFloat frameHeight = self.frame.size.height;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frameHeight/2.0;
        
        //inner background view
        CGFloat innerBGInset = 2;

        UIView *innerBGView = [[UIView alloc]initWithFrame:CGRectMake(innerBGInset, innerBGInset, frameWidth-2*innerBGInset, frameHeight-2*innerBGInset)];
        innerBGView.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
        innerBGView.layer.cornerRadius = (frameHeight-2*innerBGInset)/2.0;
        [self addSubview:innerBGView];
        
        //add circle view
        UIView *circleView = [[UIView alloc]init];
        
        CGFloat circleHeight = frameHeight;
        CGFloat circleWidth = circleHeight;
        CGFloat circleX = (frameWidth-circleWidth)/2.0;
        CGFloat circleY = 0;
        CGRect circleRect = CGRectMake(circleX, circleY, circleWidth, circleHeight);
        
        circleView.frame = circleRect;
        circleView.layer.cornerRadius = circleHeight/2.0;
        circleView.backgroundColor = [UIColor whiteColor];
        
        //add inner circle view
        CGFloat innerCircleInset = 2;

        _innerCircleView = [[UIView alloc]initWithFrame:CGRectMake(innerCircleInset, innerCircleInset, circleWidth-2*innerCircleInset, circleHeight-2*innerCircleInset)];
        _innerCircleView.layer.cornerRadius = (circleHeight-2*innerCircleInset)/2.0;
        [circleView addSubview:_innerCircleView];
        
        [self addSubview:circleView];
        _circleView = circleView;
        
        //add gesture recognizer
        UIPanGestureRecognizer *panRec = [[UIPanGestureRecognizer alloc]init];
        [panRec addTarget:self action:@selector(onPanEvent:)];
        [self addGestureRecognizer:panRec];
        
        _circleLeftPoint = CGPointMake(circleWidth/2.0-0.5, circleWidth/2.0);
        _circleCenterPoint = CGPointMake(self.frame.size.width/2.0, circleWidth/2.0);
        _circleRightPoint = CGPointMake(self.frame.size.width-circleWidth/2.0+0.5, circleWidth/2.0);
    }
    return self;
}

-(void)setSelectState:(SLSelectState)selectState{
    if(selectState==self.selectState){
        return;
    }
    
    _selectState = selectState;
    
    UIColor *destColor;
    CGPoint destPoint = CGPointZero;
    switch (selectState) {
        case NoSelection:
            destPoint = _circleCenterPoint;
            destColor = _centerColor;
            _leftBtn.selected = NO;
            _rightBtn.selected = NO;
            break;
        case LeftSelected:
            destPoint = _circleLeftPoint;
            destColor = _leftColor;
            _leftBtn.selected = YES;
            _rightBtn.selected = NO;
            break;
        case RightSelected:
            destPoint = _circleRightPoint;
            destColor = _rightColor;
            _leftBtn.selected = NO;
            _rightBtn.selected = YES;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        _circleView.center = destPoint;
        _innerCircleView.backgroundColor = destColor;
    }];
    
    self.handle(selectState,self);
}
-(void)setPreState:(SLSelectState)state{
    if(state==self.selectState){
        return;
    }
    
    _selectState = state;
    
    UIColor *destColor;
    CGPoint destPoint = CGPointZero;
    switch (state) {
        case NoSelection:
            destPoint = _circleCenterPoint;
            destColor = _centerColor;
            _leftBtn.selected = NO;
            _rightBtn.selected = NO;
            break;
        case LeftSelected:
            destPoint = _circleLeftPoint;
            destColor = _leftColor;
            _leftBtn.selected = YES;
            _rightBtn.selected = NO;
            break;
        case RightSelected:
            destPoint = _circleRightPoint;
            destColor = _rightColor;
            _leftBtn.selected = NO;
            _rightBtn.selected = YES;
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0 animations:^{
        _circleView.center = destPoint;
        _innerCircleView.backgroundColor = destColor;
    }];

}
- (void)leftBtnSelected:(id)sender{
    self.selectState = LeftSelected;
}

- (void)rightBtnSelected:(id)sender{
    self.selectState = RightSelected;
}

- (void)layoutSubviews{
    
    if(self.leftValue){
        if(!_leftBtn){
            _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [_leftBtn setTitle:_leftValue forState:UIControlStateNormal];
            [_leftBtn addTarget:self action:@selector(leftBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
            [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.superview addSubview:_leftBtn];
        }
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:[UIFont buttonFontSize]]};
        CGSize leftTextSize = [self.leftValue sizeWithAttributes:attributes];
        CGSize leftBtnSize = CGSizeMake(leftTextSize.width+10, leftTextSize.height+5);
        
        CGFloat leftBtnX = self.frame.origin.x-leftBtnSize.width;
        CGFloat leftBtnY = self.frame.origin.y+(self.frame.size.height-leftBtnSize.height)/2.0;
        _leftBtn.frame = CGRectMake(leftBtnX, leftBtnY, leftBtnSize.width, leftBtnSize.height);
    }
    
    if(self.rightValue){
        if(!_rightBtn){
            _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [_rightBtn setTitle:_rightValue forState:UIControlStateNormal];
            [_rightBtn addTarget:self action:@selector(rightBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
            [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.superview addSubview:_rightBtn];
        }
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:[UIFont buttonFontSize]]};
        CGSize rightTextSize = [self.rightValue sizeWithAttributes:attributes];
        CGSize rightBtnSize = CGSizeMake(rightTextSize.width+10, rightTextSize.height+5);
        
        CGFloat rightBtnX = self.frame.origin.x+self.frame.size.width;
        CGFloat rightBtnY = self.frame.origin.y+(self.frame.size.height-rightBtnSize.height)/2.0;
        
        _rightBtn.frame = CGRectMake(rightBtnX, rightBtnY, rightBtnSize.width, rightBtnSize.height);
    }
}

- (void)onPanEvent:(UIGestureRecognizer*)rec{
    if(rec.state==UIGestureRecognizerStateBegan){
        CGPoint p = [rec locationInView:self];
        _panStartPoint = p.x;
    }else if(rec.state ==UIGestureRecognizerStateEnded){
        CGPoint p = [rec locationInView:self];
        CGFloat diff = p.x-_panStartPoint;
        CGFloat absDiff = fabs(diff);
        
        SLSelectState destState = self.selectState;
        switch (self.selectState) {
            case NoSelection:
                if(diff<0){
                    if(absDiff>self.frame.size.width/5.0){
                        destState = LeftSelected;
                    }
                }else{
                    if(absDiff>self.frame.size.width/5.0){
                        destState = RightSelected;
                    }
                }
                break;
            case LeftSelected:
                if(diff>0){
                    if(absDiff>self.frame.size.width/2.0){
                        destState = RightSelected;
                    }else if(absDiff>self.frame.size.width/5.0){
                        destState = NoSelection;
                    }
                }
                
                break;
            case RightSelected:
                if(diff<0){
                    if(absDiff>self.frame.size.width/2.0){
                        destState = LeftSelected;
                    }else if(absDiff>self.frame.size.width/5.0){
                        destState = NoSelection;
                    }
                }
                break;
            default:
                break;
        }
        
        self.selectState = destState;
    }
}
@end
