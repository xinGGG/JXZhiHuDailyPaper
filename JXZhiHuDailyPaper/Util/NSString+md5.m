//
//  NSString+md5.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/17.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "NSString+md5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (md5)
-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
@end 

