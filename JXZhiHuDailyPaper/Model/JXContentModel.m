//
//  JXContentModel.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXContentModel.h"

@implementation JXContentModel
+(instancetype)initWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.body = [dict objectForKeyWithoutNull:@"body"];
        self.css = [dict objectForKeyWithoutNull:@"css"];
        self.ga_prefix = [dict objectForKeyWithoutNull:@"ga_prefix"];
        self.ID = [dict objectForKeyWithoutNull:@"id"];
        self.image = [dict objectForKeyWithoutNull:@"image"];
        self.image_source = [dict objectForKeyWithoutNull:@"image_source"];
        self.images = [dict objectForKeyWithoutNull:@"images"];
        self.js = [dict objectForKeyWithoutNull:@"js"];
        self.share_url = [dict objectForKeyWithoutNull:@"share_url"];
        self.title = [dict objectForKeyWithoutNull:@"title"];
        self.type = [dict objectForKeyWithoutNull:@"type"];
    }
    return self;
}

@end
