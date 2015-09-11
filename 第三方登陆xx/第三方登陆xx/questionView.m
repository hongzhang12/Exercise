//
//  questionView.m
//  SMSAMA
//
//  Created by zhanghong on 15/9/10.
//  Copyright (c) 2015年 wangjizeng. All rights reserved.
//

#import "questionView.h"
#import "DataModel.h"
#import "SGActionView.h"
#import "SLSwitcher.h"
@interface questionView()<UITextFieldDelegate>

@property (nonatomic ,weak) UILabel *questionLabel;
@property (nonatomic ,weak) UITextField *textField;
@property (nonatomic ,weak) SLSwitcher *switchView;
@property (nonatomic ,assign) questionType questionType;
@property (nonatomic ,strong) NSIndexPath *indexPath;
@property (nonatomic ,strong) NSMutableDictionary *info;
@end

@implementation questionView

-(instancetype)initWithFrame:(CGRect)frame AtIndexPath:(NSIndexPath *)indexPath{
    if (self = [super initWithFrame:frame]) {
        
//        static SLSelectState preState = NoSelection;
        CGFloat lineX = 0;
        CGFloat lineY = 0;
        CGFloat lineW = frame.size.width;
        CGFloat lineH = 2;
        UIView *line  = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineW, lineH)];
        line.backgroundColor = [UIColor whiteColor];
        [self addSubview:line];
        
        UILabel *questionLabel = [[UILabel alloc] initWithFrame:CGRectMake(lineX, lineH, lineW, 50)];
        questionLabel.numberOfLines = 0;
        [self addSubview:questionLabel];
        self.questionLabel = questionLabel;
        
        CGFloat textY = CGRectGetMaxY(questionLabel.frame);
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(lineX, textY, lineW, 50)];
        textField.delegate = self;
        [self addSubview:textField];
        self.textField = textField;
        //textField.borderStyle = UITextBorderStyleBezel;
        
        self.indexPath = indexPath;
        
        SLSwitcher *switchView = [[SLSwitcher alloc] initWithFrame:CGRectMake(frame.size.width - 120, textY, 80, 30)];

        


        switchView.handle = ^(SLSelectState newState ,SLSwitcher *switcher){

            
            if (newState==RightSelected) {


                self.questionModel.currentState = RightSelected;
                //                [[questionArray objectAtIndex:i] setObject:@"YES" forKey:@"answer"];
                self.questionModel.answer = switcher.rightValue;
                if ([self.questionModel.Question isEqualToString:@"Were the repairs or replacements caused by the resident, occupants, guests or pets?"]) {
                }
                
//                int count = 0;
//                QuestionModel *model = self.questionModel;
//                while (model.subCount) {
//
//                    count--;
//                    model.subCount--;
//                    
//                    model = model.subQuestionModel;
//                    
//                }
//                model = self.questionModel.subQuestionModel;
//                while (model) {
//                    model.currentState = NoSelection;
//                    model.answer = nil;
//                    model = model.subQuestionModel;
//                }
//                NSMutableDictionary *info = [NSMutableDictionary dictionary];
//                NSNumber *countNum = [NSNumber numberWithInt:count];
//                info[@"count"] = countNum;
//                info[@"indexPath"] = self.indexPath;
//                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//                [center postNotificationName:QuestionNotification object:self userInfo:info];
            }
            else if(newState==LeftSelected)
            {

                self.questionModel.subCount++;
                self.questionModel.currentState = LeftSelected;
                self.questionModel.answer = switcher.leftValue;
                //                [[questionArray objectAtIndex:i] setObject:@"NO" forKey:@"answer"];
                
                if ([self.questionModel.Question isEqualToString:@"Were the repairs or replacements caused by the resident, occupants, guests or pets?"]){
                    
                }

                NSMutableDictionary *info = [NSMutableDictionary dictionary];
                NSNumber *countNum = [NSNumber numberWithInt:1];
                
                info[@"count"] = countNum;
                info[@"indexPath"] = self.indexPath;
                
                NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
                [center postNotificationName:QuestionNotification object:self userInfo:info];
            }else if(newState==NoSelection){

                self.questionModel.currentState = NoSelection;
                self.questionModel.answer = @"";
                //                [[questionArray objectAtIndex:i] setObject:@"" forKey:@"answer"];
            }
        };
        [self addSubview:switchView];
        self.switchView = switchView;
        
//        questionLabel.backgroundColor = [UIColor greenColor];
//        textField.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

-(void)setQuestionModel:(QuestionModel *)questionModel{
    _questionModel = questionModel;
    
    self.questionLabel.text = questionModel.Question;
    self.questionType = [questionModel.QuestionTypeId intValue];
    if (self.questionType == questionTypeSelect_ForNextQuestion) {
        
        self.textField.hidden = YES;
        self.switchView.hidden = NO;
        [self.switchView setPreState:questionModel.currentState];
        self.switchView.leftValue = @"YES";
        self.switchView.rightValue = @"NO";
        
    }else if (self.questionType == questionTypeText||self.questionType == questionTypeTextArea || self.questionType == questionTypeLabel){
//        self.textField.backgroundColor = [UIColor whiteColor];
        self.switchView.hidden = YES;
        self.textField.hidden = NO;
        
    }else{
//        self.textField.backgroundColor = [UIColor blackColor];
        self.textField.hidden = NO;
        self.switchView.hidden = YES;
    }
}

#pragma mark - UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField endEditing:YES];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.questionType == questionTypeText||self.questionType == questionTypeTextArea || self.questionType == questionTypeLabel) {
        return YES;
    }else{
    
        NSMutableArray *optionNameArr = [NSMutableArray array];
        for (QuestionOptionsModel *option in self.questionModel.QuestionOptions) {
            [optionNameArr addObject:option.Name];
        }
        
        [SGActionView showBtnSheetWithTitle:nil itemTitles:optionNameArr selectedHandle:^(NSInteger index) {
            NSLog(@"%d",index);
            
            QuestionOptionsModel *option = self.questionModel.QuestionOptions[index];
            
            self.textField.text = self.questionModel.answer = option.Id;
            
        }];
        return NO;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.questionType == questionTypeText||self.questionType == questionTypeTextArea || self.questionType == questionTypeLabel) {
        
        self.questionModel.answer = textField.text;
    }
}
@end
