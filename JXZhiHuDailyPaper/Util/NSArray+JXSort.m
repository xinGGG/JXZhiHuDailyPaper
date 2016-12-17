//
//  NSArray+JXSort.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/17.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "NSArray+JXSort.h"

@implementation NSArray (JXSort)
-(NSArray*)SortOfList:(NSArray*)list
{
    
    NSStringCompareOptions comparisonOptions = NSLiteralSearch|NSWidthInsensitiveSearch|NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1,NSString *obj2){
        NSRange range = NSMakeRange(0,obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    
    return [list sortedArrayUsingComparator:sort];
    
}

@end
