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
#pragma mark - ZHEmotionToolBar
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
    ZHLog(@"%d",item.tag);
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
#pragma mark - ZHEmotion
@interface ZHEmotion()
@property (nonatomic ,weak) UIImageView *imageView;
@end
@implementation ZHEmotion
- (instancetype)initWIthImageName:(NSString *)imageName{
    if (self = [super init]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [self addSubview:imageView];
        
        self.imageView = imageView;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageLength = self.imageView.size.width;
    self.imageView.x = (self.width - imageLength)/2;
    self.imageView.y = (self.height - imageLength)/2;
}
@end

#pragma mark =====================================
#pragma mark - ZHEmotionView
@interface ZHEmotionView()<UIScrollViewDelegate>
@property (nonatomic ,strong) NSArray *emotionArr;
@property (nonatomic ,weak) UIScrollView *scrollView;
@end

@implementation ZHEmotionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.pagingEnabled = YES;
//        NSMutableArray *emotionArr = [NSMutableArray array];
//        for (int i = 0; i<3; i++) {
//            NSMutableArray *emotionRowArr = [NSMutableArray array];
//            for (int j = 0; j<ZHEmotionViewCountPerRow; j++) {
//                ZHEmotion *emotion = [[ZHEmotion alloc] init];
//                emotion.tag = (i+1)*(j+1);
//                [self addSubview:emotion];
//                emotion.backgroundColor = [UIColor greenColor];
//                [emotionRowArr addObject:emotion];
//            }
//            [emotionArr addObject:emotionRowArr];
//        }
//        self.emotionArr = emotionArr;
        
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor yellowColor];
        
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
    }
    return self;
}
#pragma mark - scrollView 手势回调方法
- (void)pan:(UIPanGestureRecognizer *)pan{
    NSLog(@"pan--%@",NSStringFromCGPoint([pan locationInView:self.scrollView]));
    CGPoint touchPoint = [pan locationInView:self.scrollView];
    
}
- (void)swipeLeft:(UISwipeGestureRecognizer*)swipe{
    NSLog(@"swipeLeft");
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x == ScreenWidth *3) return;
    offset = CGPointMake(offset.x + self.scrollView.width, offset.y);
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentOffset = offset;
    } completion:nil];
}
- (void)swipeRight:(UISwipeGestureRecognizer*)swipe{
    NSLog(@"swipeRight");
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x == 0) return;
    offset = CGPointMake(offset.x - self.scrollView.width, offset.y);
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.scrollView.contentOffset = offset;
    } completion:nil];
}

-(void)setEmotionArr:(NSArray *)emotionArr{
    _emotionArr = emotionArr;
    int count = emotionArr.count;
    int pageSize = 23;
    int rowSize = 8;
    CGFloat emotionLength = ScreenWidth*1.0/rowSize;
    int pageCount = count/pageSize;
    for (int i = 0; i<pageCount; i++) {
        for (int j = 0; j<pageSize; j++) {
            
            ZHEmotionModel *model = emotionArr[i*pageSize+j];
            
            int row = j/rowSize;
            int col = j%rowSize;
            
            CGFloat emotionX = col * emotionLength;
            CGFloat emotionY = row * emotionLength;
            
            ZHEmotion *emotion = [[ZHEmotion alloc] initWIthImageName:model.png];
            emotion.frame = CGRectMake(emotionX, emotionY, emotionLength, emotionLength);

            
            [self.scrollView addSubview:emotion];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    NSMutableArray *emotionArr = self.emotionArr;
//    for (int i = 0; i<3; i++) {
//        NSMutableArray *emotionRowArr = emotionArr[i];
//        for (int j = 0; j<ZHEmotionViewCountPerRow; j++) {
//            UIView *emotion = emotionRowArr[j];
//            CGFloat emotionX = j*(ZHEmotionViewLength + ZHEmotionViewMargin) + ZHEmotionViewMargin;
//            CGFloat emotionY = i*(ZHEmotionViewLength + ZHEmotionViewMargin) + ZHEmotionViewMargin;
//            emotion.frame = CGRectMake(emotionX, emotionY, ZHEmotionViewLength, ZHEmotionViewLength);
//        }
//    }
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.width*3, 0);
}
@end

#pragma mark =====================================
#pragma mark - ZHEmotionKeyboard

@interface ZHEmotionKeyboard()<ZHEmotionToolBarDelegate>
@property (nonatomic ,weak) ZHEmotionView *emotionView;
@property (nonatomic ,weak) ZHEmotionToolBar *toolBar;

@property (nonatomic ,strong) NSArray *lxhEmotions;
@property (nonatomic ,strong) NSArray *defaultEmotions;
@property (nonatomic ,strong) NSArray *emojiEmotions;
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
    ZHEmotionView *emotionView = [[ZHEmotionView alloc] init];
    
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
            self.emotionView.emotionArr = self.lxhEmotions;
            break;
        case ZHEmotionToolBarItemTypeDefault:
            self.emotionView.emotionArr = self.defaultEmotions;
            break;
        case ZHEmotionToolBarItemTypeEMOJI:
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
@end
