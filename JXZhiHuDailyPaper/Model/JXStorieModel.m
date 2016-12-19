//
//  JXStorieModel.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXStorieModel.h"

@implementation JXStorieModel

+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.images = [NSArray arrayWithArray:[dict objectForKeyWithoutNull:@"images"]];
        self.type = [dict objectForKeyWithoutNull:@"type"];
        self.ID = [dict objectForKeyWithoutNull:@"id"];
        self.ga_prefix = [dict objectForKeyWithoutNull:@"ga_prefix"];
        self.title = [dict objectForKeyWithoutNull:@"title"];
    };
    return self;
}

@end
