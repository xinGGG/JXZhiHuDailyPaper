//
//  JXHtmlAnalyzingTool.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/23.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXHtmlAnalyzingTool.h"

@implementation JXHtmlAnalyzingTool
+ (NSString *)setupWebWithHtmlBody:(NSString *)htmlBody WithCss:(NSArray *)css{
    NSString *html = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",[css firstObject],htmlBody];
    return html;
}
//获取图片
@end
