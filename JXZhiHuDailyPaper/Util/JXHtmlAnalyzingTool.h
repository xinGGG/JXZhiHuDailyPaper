//
//  JXHtmlAnalyzingTool.h
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXHtmlAnalyzingTool : NSObject
+ (NSString *)setupWebWithHtmlBody:(NSString *)htmlBody WithCss:(NSArray *)css;
@end
