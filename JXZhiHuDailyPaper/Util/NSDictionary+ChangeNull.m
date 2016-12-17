//
//  NSDictionary+ChangeNull.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "NSDictionary+ChangeNull.h"

@implementation NSDictionary (ChangeNull)

-(id)objectForKeyWithoutNull:(id)aKey
{
    
    id result = [self objectForKey:aKey];
    if (!result||[result isEqual:[NSNull null]]) {
        result = @"";
        return result;
    }
    if (!result||[result isKindOfClass:[NSNull class]]) {
        result = @"";
        return result;
    }
    if ([result isEqual:@"null"]) {
        result=@"";
        return result;
    }
    if ([result isEqual:@"(null)"]) {
        result=@"";
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [result stringValue];
    }
    
    if ([result isKindOfClass:[NSDictionary class]]||[result isKindOfClass:[NSArray class]]) {
        return result;
    }
    
    return result;
}


//将NSDictionary中的Null类型的项目转化成@""
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        
        [resDic setObject:obj forKey:keyArr[i]];
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}



@end

