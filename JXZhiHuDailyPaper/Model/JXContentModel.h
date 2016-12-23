//
//  JXContentModel.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXContentModel : NSObject
@property (nonatomic,strong) NSString   *body;
@property (nonatomic,strong) NSArray    *css;
@property (nonatomic,strong) NSString   *ga_prefix;
@property (nonatomic,strong) NSString   *ID;
@property (nonatomic,strong) NSString   *image;
@property (nonatomic,strong) NSString   *image_source;
@property (nonatomic,strong) NSArray    *images;
@property (nonatomic,strong) NSArray    *js;
@property (nonatomic,strong) NSString   *share_url;
@property (nonatomic,strong) NSString   *title;
@property (nonatomic,strong) NSString   *type;

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
