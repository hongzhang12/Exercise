//
//  ZHEmotionKeyboard.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/8/7.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHEmotionKeyboard.h"

@implementation ZHEmotionToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addButtonWithTitle:@"More" andType:ZHEmotionToolBarItemTypeMore];
        [self addButtonWithTitle:@"浪小花" andType:ZHEmotionToolBarItemTypeLXH];
        [self addButtonWithTitle:@"思密达" andType:ZHEmotionToolBarItemTypeSMD];
        [self addButtonWithTitle:@"瓦大喜哇" andType:ZHEmotionToolBarItemTypeWDXW];
        
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

@implementation ZHEmotion

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan--%d",self.tag);
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded-----------%d",self.tag);
}
@end

@interface ZHEmotionView()
@property (nonatomic ,strong) NSMutableArray *emotionArr;
@end

@implementation ZHEmotionView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES;
        NSMutableArray *emotionArr = [NSMutableArray array];
        for (int i = 0; i<3; i++) {
            NSMutableArray *emotionRowArr = [NSMutableArray array];
            for (int j = 0; j<ZHEmotionViewCountPerRow; j++) {
                ZHEmotion *emotion = [[ZHEmotion alloc] init];
                emotion.tag = (i+1)*(j+1);
                [self addSubview:emotion];
                emotion.backgroundColor = [UIColor greenColor];
                [emotionRowArr addObject:emotion];
            }
            [emotionArr addObject:emotionRowArr];
        }
        self.emotionArr = emotionArr;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSMutableArray *emotionArr = self.emotionArr;
    for (int i = 0; i<3; i++) {
        NSMutableArray *emotionRowArr = emotionArr[i];
        for (int j = 0; j<ZHEmotionViewCountPerRow; j++) {
            UIView *emotion = emotionRowArr[j];
            CGFloat emotionX = j*(ZHEmotionViewLength + ZHEmotionViewMargin) + ZHEmotionViewMargin;
            CGFloat emotionY = i*(ZHEmotionViewLength + ZHEmotionViewMargin) + ZHEmotionViewMargin;
            emotion.frame = CGRectMake(emotionX, emotionY, ZHEmotionViewLength, ZHEmotionViewLength);
        }
    }
}
@end

@interface ZHEmotionKeyboard()<ZHEmotionToolBarDelegate>
@property (nonatomic ,weak) ZHEmotionView *emotionView;
@property (nonatomic ,weak) ZHEmotionToolBar *toolBar;
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
    self.emotionView.contentSize = CGSizeMake(ScreenWidth*ZHEmotionViewPageCount, self.emotionView.height);
}
- (void)emotionToolBar:(ZHEmotionToolBar *)emotion buttonClickedInType:(ZHEmotionToolBarItemType)type{
    switch (type) {
            
        case ZHEmotionToolBarItemTypeMore:
            
            break;
        case ZHEmotionToolBarItemTypeLXH:
        
            break;
        case ZHEmotionToolBarItemTypeSMD:
        
            break;
        case ZHEmotionToolBarItemTypeWDXW:
        
            break;
        default:
            break;
            
    }
}

@end
