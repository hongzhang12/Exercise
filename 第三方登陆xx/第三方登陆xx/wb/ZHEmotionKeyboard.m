//
//  ZHEmotionKeyboard.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/7.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHEmotionKeyboard.h"
#import "ZHEmotionModel.h"
#import "MJExtension.h"

#pragma mark =====================================
#pragma mark  ZHEmotionToolBar
@implementation ZHEmotionToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addButtonWithTitle:@"More" andType:ZHEmotionToolBarItemTypeMore];
        [self addButtonWithTitle:@"浪小花" andType:ZHEmotionToolBarItemTypeLXH];
        [self addButtonWithTitle:@"默认" andType:ZHEmotionToolBarItemTypeDefault];
        [self addButtonWithTitle:@"Emoji" andType:ZHEmotionToolBarItemTypeEMOJI];
        
    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title andType:(ZHEmotionToolBarItemType)type{
    UIButton *item = [[UIButton alloc] init];
    item.adjustsImageWhenHighlighted = NO;
    [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchDown];
    [item setTitle:title forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:@"common_card_top_background_highlighted"] forState:UIControlStateNormal];
    [item setBackgroundImage:[UIImage imageNamed:@"common_card_top_background"] forState:UIControlStateDisabled];
    [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:item];
    item.tag = type;
    if (type == ZHEmotionToolBarItemTypeMore) {
        self.selectedItem = item;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat itemW = self.width/count;
    CGFloat itemH = self.height;
    CGFloat ItemY = 0;
    for (int i = 0; i<count; i++) {
        CGFloat itemX = itemW * i;
        UIButton *item = self.subviews[i];
        item.frame = CGRectMake(itemX, ItemY, itemW, itemH);
    }
}

- (void)itemClicked:(UIButton *)item{
    //ZHLog(@"%d",item.tag);
    self.selectedItem = item;
    
}
-(void)setSelectedItem:(UIButton *)selectedItem{
    _selectedItem.enabled = YES;
    selectedItem.enabled = NO;
    _selectedItem = selectedItem;
    if ([self.delegate respondsToSelector:@selector(emotionToolBar:buttonClickedInType:)]) {
        [self.delegate emotionToolBar:self buttonClickedInType:selectedItem.tag];
    }
}
@end

#pragma mark =====================================
#pragma mark  ZHEmotion
@interface ZHEmotion()
@property (nonatomic ,weak) UIImageView *imageView;
@property (nonatomic ,weak) UILabel *title;
@end
@implementation ZHEmotion
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        
        self.imageView = imageView;
        
        UILabel *title = [[UILabel alloc] init];
        [self addSubview:title];
        self.title = title;
    }
    return self;
}

- (void)setEmotionWithEmotionModel:(ZHEmotionModel *)model{
    if (model.png) {
        self.imageView.image = [UIImage imageNamed:model.png];
    }else{
        self.title.text = [model.code stringByReplacingPercentEscapesUsingEncoding:NSUTF16StringEncoding];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat titleW = 32;
    CGFloat titleH = 32;
    CGFloat titleX = (self.width - titleW)/2;
    CGFloat titleY = (self.height - titleH)/2;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    self.imageView.frame = self.title.frame;
}


@end

#pragma mark =====================================
#pragma mark  ZHEmotionView
@interface ZHEmotionView()<UIScrollViewDelegate>
@property (nonatomic ,strong) NSArray *emotionArr;
@property (nonatomic ,weak) UIScrollView *scrollView;
@property (nonatomic ,weak) UIPageControl *pageControl;
@end

@implementation ZHEmotionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        //scrollView.backgroundColor = [UIColor yellowColor];
        
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIButton *test = [UIButton buttonWithType:UIButtonTypeContactAdd];
        test.x = ScreenWidth;
        test.y = 0;
        [scrollView addSubview:test];
        
        //应该有更好的方法，利用scrollView本身属性
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [scrollView addGestureRecognizer:pan];

        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [scrollView addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [scrollView addGestureRecognizer:swipeRight];
        
        [pan requireGestureRecognizerToFail:swipeLeft];
        [pan requireGestureRecognizerToFail:swipeRight];
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        [self addSubview:pageControl];
        //pageControl.backgroundColor = [UIColor blueColor];
        self.pageControl = pageControl;
    }
    return self;
}
#pragma mark - scrollView 手势回调方法
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    NSLog(@"pan--%@",NSStringFromCGPoint([pan locationInView:self.scrollView]));
    CGPoint touchPoint = [pan locationInView:self.scrollView];
    
    CGFloat emotionLength = self.scrollView.width/ZHEmotionViewCountPerRow;
    
    int page = self.pageControl.currentPage;
    //当前页的位置
    int emotionX = touchPoint.x - page*self.scrollView.width;
    int emotionY = touchPoint.y;
    
    int row = emotionY/emotionLength;
    int col = emotionX/emotionLength;
    
    NSUInteger index = page*ZHEmotionViewPageSize+row*ZHEmotionViewCountPerRow+col;
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        [self sendEndedEmotionClickedAtIndex:index];
    }else{
        [self sendCurrentEmotionClickedAtIndex:index];
    }
}
- (void)swipeLeft:(UISwipeGestureRecognizer*)swipe{
    NSLog(@"swipeLeft");
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x == (self.scrollView.contentSize.width-self.scrollView.width)) return;
    self.pageControl.currentPage += 1;
    
    offset = CGPointMake(offset.x + self.scrollView.width, offset.y);
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentOffset = offset;
    } completion:nil];
}
- (void)swipeRight:(UISwipeGestureRecognizer*)swipe{
    NSLog(@"swipeRight");
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x == 0) return;
    self.pageControl.currentPage -= 1;
    
    offset = CGPointMake(offset.x - self.scrollView.width, offset.y);
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentOffset = offset;
    } completion:nil];
}
- (void)sendCurrentEmotionClickedAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(emotionView:EmotionBtnClickedMovedAtIndex:)]) {
        [self.delegate emotionView:self EmotionBtnClickedMovedAtIndex:index];
    }
}
- (void)sendEndedEmotionClickedAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(emotionView:EmotionBtnClickedEndAtIndex:)]) {
        [self.delegate emotionView:self EmotionBtnClickedEndAtIndex:index];
    }
}
- (void)sendBeginEmotionClickedAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(emotionView:EmotionBtnClickedBeginedAtIndex:)]) {
        [self.delegate emotionView:self EmotionBtnClickedBeginedAtIndex:index];
    }
}

-(void)setEmotionArr:(NSArray *)emotionArr{

    _emotionArr = emotionArr;
    for (ZHEmotion *emotion in self.scrollView.subviews) {
        [emotion removeFromSuperview];
    }
    self.scrollView.contentOffset = CGPointMake(0, 0);
    int count = emotionArr.count;
    int pageSize = ZHEmotionViewPageSize;
    int rowSize = ZHEmotionViewCountPerRow;
    CGFloat emotionLength = self.scrollView.width/rowSize;
    int pageCount = count/pageSize + 1;
    
    self.scrollView.contentSize = CGSizeMake(self.width*pageCount, 0);
    self.pageControl.numberOfPages = pageCount;
    self.pageControl.currentPage = 0;
    
    for (int i = 0; i<pageCount; i++) {
        for (int j = 0; j<pageSize; j++) {
            
            int currentCount = i*pageSize+j;
            if (currentCount>count-1) break;
            ZHEmotionModel *model = emotionArr[currentCount];
            if (!model) return;
            int row = j/rowSize;
            int col = j%rowSize;
            
            CGFloat emotionX = col * emotionLength + i*self.scrollView.width;
            CGFloat emotionY = row * emotionLength;
            
            ZHEmotion *emotion = [[ZHEmotion alloc] initWithFrame:CGRectMake(emotionX, emotionY, emotionLength, emotionLength)];
            emotion.tag = currentCount;
            //emotion.backgroundColor = [UIColor grayColor];
            [emotion setEmotionWithEmotionModel:model];
            [emotion addTarget:self action:@selector(emotionBtnTouchDown:) forControlEvents:UIControlEventTouchDown];
            [emotion addTarget:self action:@selector(emotionBtnTouchUpinside:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.scrollView addSubview:emotion];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;
    self.scrollView.height = self.height/4*3;
    
    CGFloat pageControlX = 0;
    CGFloat pageControlY = CGRectGetMaxY(self.scrollView.frame);
    CGFloat pageControlW = self.width;
    CGFloat pageControlH = self.height - pageControlY;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
}
#pragma mark - emotion button 回调方法
- (void)emotionBtnTouchDown:(ZHEmotion *)emotion{
    [self sendBeginEmotionClickedAtIndex:emotion.tag];
}
- (void)emotionBtnTouchUpinside:(ZHEmotion *)emotion{
    [self sendEndedEmotionClickedAtIndex:emotion.tag];
}
@end

#pragma mark =====================================
#pragma mark  ZHEmotionKeyboard

@interface ZHEmotionKeyboard()<ZHEmotionToolBarDelegate,ZHEmotionViewDelegate>
@property (nonatomic ,weak) ZHEmotionView *emotionView;
@property (nonatomic ,weak) ZHEmotionToolBar *toolBar;

@property (nonatomic ,strong) NSArray *lxhEmotions;
@property (nonatomic ,strong) NSArray *defaultEmotions;
@property (nonatomic ,strong) NSArray *emojiEmotions;
@property (nonatomic ,weak) NSArray *selectedEmotions;

@property (nonatomic ,assign) int selectedEmotionIndex;

@end
@implementation ZHEmotionKeyboard

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self setUpSubViews];
        
    }
    return self;
}
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor yellowColor];
        [self setUpSubViews];
        
    }
    return self;
}
- (void)setUpSubViews{
    self.selectedEmotionIndex = -1;
    
    ZHEmotionView *emotionView = [[ZHEmotionView alloc] init];
    emotionView.delegate = self;
    [self addSubview:emotionView];
    self.emotionView = emotionView;
    
    ZHEmotionToolBar *toolBar = [[ZHEmotionToolBar alloc] init];
    toolBar.delegate = self;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    
    emotionView.backgroundColor = [UIColor purpleColor];
    toolBar.backgroundColor = [UIColor whiteColor];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat toolBarW = self.width;
    CGFloat toolBarH = 44;
    CGFloat toolBarX = 0;
    CGFloat toolBarY = CGRectGetMaxY(self.frame) - toolBarH;
    self.toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    CGFloat emotionX = 0;
    CGFloat emotionW = self.width;
    CGFloat emotionH = self.height - toolBarH;
    CGFloat emotionY = 0;
    self.emotionView.frame = CGRectMake(emotionX, emotionY, emotionW, emotionH);
    //self.emotionView.contentSize = CGSizeMake(ScreenWidth*ZHEmotionViewPageCount, self.emotionView.height);
}
#pragma mark - emotionToolBar delegate
- (void)emotionToolBar:(ZHEmotionToolBar *)emotion buttonClickedInType:(ZHEmotionToolBarItemType)type{
    switch (type) {
            
        case ZHEmotionToolBarItemTypeMore:
            
            break;
        case ZHEmotionToolBarItemTypeLXH:
            self.selectedEmotions = self.lxhEmotions;
            self.emotionView.emotionArr = self.lxhEmotions;
            break;
        case ZHEmotionToolBarItemTypeDefault:
            self.selectedEmotions = self.defaultEmotions;
            self.emotionView.emotionArr = self.defaultEmotions;
            break;
        case ZHEmotionToolBarItemTypeEMOJI:
            self.selectedEmotions = self.emojiEmotions;
            self.emotionView.emotionArr = self.emojiEmotions;
            break;
        default:
            break;
            
    }
}
#pragma mark  - 懒加载
-(NSArray *)emojiEmotions{
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"/EmotionIcons/emoji/emoji" ofType:@"plist"];
        NSArray *emotions = [NSArray arrayWithContentsOfFile:path];
        
        _emojiEmotions = [ZHEmotionModel objectArrayWithKeyValuesArray:emotions];
    }
    return  _emojiEmotions;
}

-(NSArray *)lxhEmotions{
    if (_lxhEmotions == nil) {

        NSString *path = [[NSBundle mainBundle] pathForResource:@"/EmotionIcons/lxh/lxh.plist" ofType:nil];
        NSArray *emotions = [NSArray arrayWithContentsOfFile:path];
        
    
        _lxhEmotions = [ZHEmotionModel objectArrayWithKeyValuesArray:emotions];

    }
    return  _lxhEmotions;
}

-(NSArray *)defaultEmotions{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"/EmotionIcons/default/emotionDefault" ofType:@"plist"];
        NSArray *emotions = [NSArray arrayWithContentsOfFile:path];
        
        _defaultEmotions = [ZHEmotionModel objectArrayWithKeyValuesArray:emotions];
    }
    return  _defaultEmotions;
}

#pragma mark - emotionView delegate

-(void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedBeginedAtIndex:(NSUInteger)index{

    self.selectedEmotionIndex = index;
    ZHEmotionModel *emotionModel = self.selectedEmotions[index];
    //NSLog(@"---%@",emotionModel.chs);
}

-(void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedMovedAtIndex:(NSUInteger)index{
    //NSLog(@"---%d",index);
    if (self.selectedEmotionIndex == index) return;
    
    self.selectedEmotionIndex = index;
    ZHEmotionModel *emotionModel = self.selectedEmotions[index];
    //NSLog(@"---%@",emotionModel.chs);
}

-(void)emotionView:(ZHEmotionView *)emotionView EmotionBtnClickedEndAtIndex:(NSUInteger)index{
    //if (self.selectedEmotionIndex == index) return;
    
    self.selectedEmotionIndex = (int)index;
    ZHEmotionModel *emotionModel = self.selectedEmotions[index];

    if ([self.delegate respondsToSelector:@selector(EmotionKeyboard:emotionInfo:)]) {
        [self.delegate EmotionKeyboard:self emotionInfo:emotionModel];
    }
}
@end
