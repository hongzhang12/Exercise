   //
//  ZHAccountModel.m
//  第三方登陆xx
//
//  Created by zhanghong on 15/7/3.
//  Copyright (c) 2015年 zhanghong. All rights reserved.
//

#import "ZHAccountModel.h"
#define AccountInfo [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSAllDomainsMask, YES) lastObject]stringByAppendingPathComponent:@"account.plist"]
@implementation ZHAccountModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.oAuthToken forKey:@"oAuthToken"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.profileImage forKey:@"profileImage"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.oAuthToken  = [aDecoder decodeObjectForKey:@"oAuthToken"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.profileImage = [aDecoder decodeObjectForKey:@"profileImage"];
        
    }
    return self;
}
+ (ZHAccountModel *)accountModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:AccountInfo];
}
@end
