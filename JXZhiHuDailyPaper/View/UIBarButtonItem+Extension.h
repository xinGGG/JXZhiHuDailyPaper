//
//  UIBarButtonItem+Extension.m
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 ljx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/*
 * 返回一个UIBarButtonItem
 * @param nmlImg 普通状态图片
 * @param hltImg 高亮状态图片
 * @param target 目标
 * @param action 方法
 */
+(instancetype)itemWithNmlImg:(NSString *)nmlImg hltImg:(NSString *)hltImg target:(id)target action:(SEL)action;

/*
 * 返回一个返回按钮
 * @param title 返回按钮标题
 * @param target 目标
 * @param action 方法
 */

+(instancetype)backItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;


+(instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
+(instancetype)itemWithTitle:(NSString *)title titleColor:(id)titlecolor target:(id)target action:(SEL)action;
@end
