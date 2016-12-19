//
//  JXStorieModel.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXStorieModel : NSObject
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *ga_prefix;
@property (nonatomic,strong) NSString *title;

+(instancetype)initWithDict:(NSDictionary *)dict;

@end
