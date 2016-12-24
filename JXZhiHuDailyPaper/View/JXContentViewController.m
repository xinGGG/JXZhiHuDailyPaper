//
//  JXContentViewController.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/22.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXContentViewController.h"
#import "JXContentViewModel.h"
#import "CycleScrollView.h"

@interface JXContentViewController ()<UIWebViewDelegate>
@property (nonatomic, assign) BOOL              didSetupConstrains;
@property (nonatomic, strong) UIWebView         *webView;
@property (nonatomic, strong) TopView           *topView;

@end

@implementation JXContentViewController


- (void)loadView {
    self.view = [UIView new];
    self.webView = [UIWebView newAutoLayoutView];
    self.webView.delegate = self;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    //    self.view.backgroundColor = RGBA(238, 239, 243, 1);
    [self.view addSubview:self.topView];
  
    //约束
    [self.view setNeedsUpdateConstraints];
}


- (void)updateViewConstraints {
    if (!self.didSetupConstrains) {
#pragma mark - 布局
        [self.webView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
        [self.webView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        [self.webView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        [self.webView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];

        self.didSetupConstrains   = YES;
    }
    
    [super updateViewConstraints];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    @weakify(self);
    [self.viewModel.loadCammand execute:self.viewModel.ID];
    [self.viewModel.loadCammand.executing subscribeNext:^(id x) {
        @strongify(self);
        BOOL isLoading = [x boolValue];
        if (isLoading) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];

    //错误操作
    [self.viewModel.connectionErrors subscribeNext:^(id x) {
        @strongify(self);
//        JXError([(NSError *)x domain]);
        JXError(@"Error");
        
    }];
    
    //htmlString 改变就重刷
    [[RACObserve(self.viewModel,HTMLString) filter:^BOOL(id value) {
        if (self.viewModel.HTMLString.length==0 ) {
            return NO;
        };
        return YES;
    }] subscribeNext:^(id x) {
        JXSuccess(@"更新成功");
        [self reloadHtml];
        self.topView.detailStory = self.viewModel.contentModel;
    }];
    
    [RACObserve(self,viewModel) subscribeNext:^(id x) {
        NSLog(@"%@",_viewModel);
    }];
}

- (void)reloadHtml{
    [self.webView loadHTMLString:self.viewModel.HTMLString baseURL:nil];
//    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.viewModel.HTMLString]]];
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
#pragma mark - layer
- (TopView *)topView{
    if (_topView == nil) {
        _topView = [TopView attchToView:self.view observeScorllView:self.webView];
    }
    return _topView;
}

@end
