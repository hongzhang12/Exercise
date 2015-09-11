//
//  DataModel.m
//  SMSAMA
//
//  Created by wangjizeng on 14-5-19.
//  Copyright (c) 2014年 wangjizeng. All rights reserved.
//

#import "DataModel.h"

@implementation WODataModel
@synthesize woId,address,callDateTime,city,lat,lng,locationId,locationNum,phone,priorityDesc,problemDescription,requestNum,zippost,status,statusId,logo,callName,messageCount,troubleShooting,notToExceed,technician,tradeCode,tradeName,retailer,assignedName,scheduleEndTime,scheduleStartTime,content,messFrom,msgType,recurring,tradeID,floorType,isSelected,paidCount,pendingCount,stpv,isRecurringWO,scheduledTime,photoId,attachContent,ttsqft,turf,frequency,ofRestRooms,landscapingSize,storeType,irrigation,clientName,addTime,scheduleCategory,floorCareOrLandScaping,additionalDetail,responsibilityEntity,position,isFDFloorCare,workOrderType,scheduleTime,serviceType,isNeedPhoto,isWOMessage,topTradeId;

-(id)init
{
    self = [super init];
    if (self )
    {
        isNeedPhoto = NO;
        isSelected = NO;
        isWOMessage = NO;
        woId = address = callDateTime = city = lat = lng = locationId = locationNum = phone = problemDescription = priorityDesc = requestNum = zippost = status = statusId = logo = callName = messageCount = troubleShooting = notToExceed = technician = tradeCode = tradeName = retailer = assignedName = scheduleEndTime = scheduleStartTime=  content = messFrom = msgType = recurring = tradeID = floorType = paidCount = pendingCount = stpv = isRecurringWO = scheduledTime = photoId = attachContent = ttsqft = turf = frequency = ofRestRooms = landscapingSize=storeType= irrigation = clientName = addTime = scheduleCategory = floorCareOrLandScaping= additionalDetail = responsibilityEntity=position=isFDFloorCare= workOrderType = scheduleTime = serviceType = topTradeId =@"";
    }
    return self;
}
@end

@implementation QuestionOptionsModel
+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
@end

@implementation QuestionModel
+ (BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(void)setSubCount:(int)subCount{
    _subCount = subCount;
    
}
- (NSMutableArray *)subQuestionArr{
    if (_subQuestionArr == nil) {
        _subQuestionArr = [NSMutableArray array];
    }
    return _subQuestionArr;
}
@end