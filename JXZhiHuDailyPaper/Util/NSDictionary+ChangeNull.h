//
//  NSDictionary+ChangeNull.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/14.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ChangeNull)

-(id)objectForKeyWithoutNull:(id)aKey;

+(NSDictionary *)nullDic:(NSDictionary *)myDic;

//+(id)changeType:(id)myObj;


@end
