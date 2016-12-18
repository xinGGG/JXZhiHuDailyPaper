//
//  UIBarButtonItem+Extension.m
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 ljx. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)itemWithNmlImg:(NSString *)nmlImg hltImg:(NSString *)hltImg target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:nmlImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hltImg] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentMode = UIViewContentModeScaleAspectFill;
    //        btn.contentMode = UIViewContentModeScaleAspectFit;
    
    //    [btn setTitle:@"xxxxxsx" forState:UIControlStateNormal];
    //        btn.bounds = CGRectMake( 0, 0, 17, 17);
    // 间接设置尺寸,它会根据图片和文字大小进行适配一个最合适尺寸
    [btn sizeToFit];
    //    btn.w *= 0.5;
    //     btn.h *= 0.5;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+(instancetype)backItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_withtext_highlighted"] forState:UIControlStateHighlighted];
    [backBtn setImage:[UIImage imageNamed:@"navigationbar_back_withtext"] forState:UIControlStateNormal];
    [backBtn setTitle:title forState:UIControlStateNormal];
    
    // 添加颜色
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    // 设置文字大小
    backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 添加事件
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    [backBtn sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}


+(instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 设置文字大小
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置按钮禁用的文字颜色
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}


+(instancetype)itemWithTitle:(NSString *)title titleColor:(id)titlecolor target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titlecolor forState:UIControlStateNormal];
    // 设置文字大小
    
    btn.titleLabel.font = [UIFont systemFontOfSize:15];;
    
    // 设置按钮禁用的文字颜色
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return  [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
