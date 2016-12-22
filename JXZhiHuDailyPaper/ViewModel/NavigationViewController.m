//
//  NavigationViewController.m
//  Tabbar+Navigation
//
//  Created by xing on 15/6/27.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "NavigationViewController.h"
@interface NavigationViewController ()

@end

@implementation NavigationViewController
+(void)initialize {
    
    /**
     *  判断由JXNavigationViewController产生 优化性能
     */
    if ( self == [NavigationViewController class]) {
        
        [self setupNav];
        
        [self setupItem];
    }
}

/**
 *  导航栏主题颜色+标题样式
 */
+ (void)setupNav {
    
    //导航栏主题颜色
    UINavigationBar *bar = [UINavigationBar appearance];
    //bar 背景颜色
//    bar.barTintColor = UIColorFromRGB(223, 223, 223);
    bar.barTintColor = RGB(255,255,255);
//        bar.barTintColor = UIColorFromRGB(145, 0 , 0);

    //bar 默认图标颜色
    bar.tintColor = [UIColor whiteColor];
    bar.shadowImage = [[UIImage alloc] init];

    //    self.titleLabel = [UILabel newAutoLayoutView];
    //    self.titleLabel.backgroundColor = [UIColor clearColor];
    //    self.titleLabel.textColor = UIColorFromRGB(51, 51, 51);
    //    self.titleLabel.font = [UIFont systemFontOfSize:22.0];

    //透明、占位属性
//    bar.opaque = NO;
//    bar.translucent = NO;
    
    //标题样式
    NSMutableDictionary *barStyle = [NSMutableDictionary dictionary];
    barStyle[NSForegroundColorAttributeName] =  RGB(51, 51, 51);
    barStyle[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [bar setTitleTextAttributes:barStyle];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

/**
 *  导航栏左右按钮
 */
+ (void)setupItem{
    
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
//    dictM[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    dictM[NSFontAttributeName] = BFONT;
//    [item setTitleTextAttributes:dictM forState:UIControlStateNormal];
    
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSForegroundColorAttributeName] = HexRGB(0x2b354c);
    dictM[NSFontAttributeName] =  [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:dictM forState:UIControlStateNormal];

//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)                                                      forBarMetrics:UIBarMetricsDefault];

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    NSInteger currentCount = self.childViewControllers.count;
    
    if (currentCount > 0 ) {

        //兼容右边手势滑动操作
        UIBarButtonItem *item = [UIBarButtonItem itemWithNmlImg:@"icon-back" hltImg:@"icon-back" target:self action:@selector(popView)];
        viewController.navigationItem.backBarButtonItem = item;
        viewController.navigationItem.leftBarButtonItem = item;
//        [self.navigationItem setHidesBackButton:YES];
    }
    
    [super pushViewController:viewController animated:animated];
} 

- (void)popView{
    
    [self popViewControllerAnimated:YES];
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
