//
//  JXMainViewController.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/18.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXMainViewController.h"
#import "JXMainViewModel.h"
#import "JXMainTableViewCell.h"
#import "JXContentViewController.h"
@interface JXMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation JXMainViewController

- (void)loadView {
    self.view = [UIView new];
    //    self.view.backgroundColor = RGBA(238, 239, 243, 1);
    self.tableView = [UITableView newAutoLayoutView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //约束
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
#pragma mark - 布局
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view];
        [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.view];
        self.didSetupConstraints   = YES;
    }
    
    [super updateViewConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    //监听数组变化 刷新tableView
    [self.viewModel.updatedContentSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
    
    //网络请求成功处理
    [self.viewModel.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"%@",x);
        JXSuccess(@"更新成功");
        //这部分应该通过 数组变化来做刷新 一个方法尽量只作一个事情。如果ViewModel要清空数组（额外清空）这部分就会造成耦合
        //[self.tableView reloadData];
    }];
    
    //加载操作
    [self.viewModel.getDataCommand.executing subscribeNext:^(id x) {
        @strongify(self);
        BOOL isLoading = [x boolValue];
        if (isLoading) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];

        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
    //错误操作
    [self.viewModel.connectionErrors subscribeNext:^(id x) {
        @strongify(self);
        JXError([(NSError *)x domain]);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self.tableView.mj_header beginRefreshing];
        [self.viewModel.getDataCommand execute:@YES];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self.tableView.mj_footer beginRefreshing];
        [self.viewModel.getDataCommand execute:@NO];
    }];
    
    
    
    // Enter the refresh status immediately
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView-delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JXMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell = [[JXMainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.viewModel titleForSection:section];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.clickCellCommand execute:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)configureCell:(JXMainTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    //    cell.textLabel.text = @"title";
    //    cell.detailTextLabel.text = @"content";
    cell.model = [self.viewModel modelAtIndexPath:indexPath];
}


@end
