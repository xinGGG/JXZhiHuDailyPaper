//
//  UIApplication+ActivityViewController.m
//  DragonPassEn
//
//  Created by xing on 16/3/21.
//  Copyright © 2016年 Ray. All rights reserved.
//

#import "UIApplication+ActivityViewController.h"

@implementation UIApplication (ActivityViewController)

- (UIViewController *)activityViewController {
    __block UIWindow *normalWindow = [self.delegate window];
    if (normalWindow.windowLevel != UIWindowLevelNormal) {
        [self.windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.windowLevel == UIWindowLevelNormal) {
                normalWindow = obj;
                *stop        = YES;
            }
        }];
    }
    
    return [self p_nextTopForViewController:normalWindow.rootViewController];
}

- (UIViewController *)p_nextTopForViewController:(UIViewController *)inViewController {
    while (inViewController.presentedViewController) {
        inViewController = inViewController.presentedViewController;
    }
    
    if ([inViewController isKindOfClass:[UITabBarController class]]) {
        UIViewController *selectedVC = [self p_nextTopForViewController:((UITabBarController *)inViewController).selectedViewController];
        return selectedVC;
    } else if ([inViewController isKindOfClass:[NavigationViewController class]]) {
        UIViewController *selectedVC = [self p_nextTopForViewController:((NavigationViewController *)inViewController).visibleViewController];
        return selectedVC;
    } else {
        return inViewController;
    }
}
@end
