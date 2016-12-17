//
//  JXCache.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/17.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXCache.h"

@implementation JXCache
+ (YYCache *)AppCache
{
    static YYCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[YYCache alloc] initWithName:@"app_cache"];
        
    });
    return cache;
}


@end
