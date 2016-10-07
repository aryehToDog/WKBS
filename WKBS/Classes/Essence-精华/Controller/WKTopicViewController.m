//
//  WKTopicViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/4.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopicViewController.h"
#import "WKHTTPSessionManager.h"
#import <MJRefresh.h>
#import "WKRefreshHeader.h"
#import "WKTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "WKRefreshFooter.h"
#import "WKTopicCell.h"
#import "WKCommentViewController.h"
#import "WKNewViewController.h"
@interface WKTopicViewController ()
@property (nonatomic,strong)NSMutableArray *topics;
@property (nonatomic,copy)NSString *maxTime;
@property (nonatomic,strong)WKHTTPSessionManager *manager;
@end

static NSString *const topicId = @"topic";

@implementation WKTopicViewController

- (WKTopicType)type {

    return 0;
}

- (WKHTTPSessionManager *)manager {
    
    if (!_manager) {
        
        _manager = [WKHTTPSessionManager manager];
        
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    //加载数据
    [self setupRefresh];
    
    //接收通知
    [self setNote];
}

- (void)setNote {

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WKTabBarButtonDidRepeatClickNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:WKTitleButtonDidRepeatClickNotification object:nil];

}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

/** 
 *   重复点击底部tabBar进行刷新
 */

- (void)tabBarButtonDidRepeatClick {

    //判断当前控制器的view(帖子上的view) 是否在窗口上  如果不在直接返回  不然会调用五次
    if (self.view.window == nil) return;
    
    //判断当前view是否跟控制器进行重叠 如果不是在重叠直接返回
    if (![self.view intersectWithView:self.view.window]) return;
    
    //进行刷新
    [self.tableView.mj_header beginRefreshing];
}


/** 双击所在标题会进行刷新 */
- (void)titleButtonDidRepeatClick {

    //判断当前控制器的view(帖子上的view) 是否在窗口上  如果不在直接返回  不然会调用五次
    if (self.view.window == nil) return;
    
    //判断当前view是否跟控制器进行重叠 如果不是在重叠直接返回
    if (![self.view intersectWithView:self.view.window]) return;
    
    //进行刷新
    [self.tableView.mj_header beginRefreshing];

}


- (void)setupTableView {
    
    self.tableView.backgroundColor = WKCommonBgColor;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //取消tableview的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WKTopicCell class]) bundle:nil] forCellReuseIdentifier:topicId];
    
    
}

- (void)setupRefresh {
    
    //下拉刷新新数据
    self.tableView.mj_header = [WKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadingNewTopic)];
    //开始首页进行刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    //上拉刷新更多数据
    self.tableView.mj_footer = [WKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingMoreTopic)];
}


/** 
 *    新帖及精华帖
 */
- (NSString *)a {

    return [self.parentViewController isKindOfClass:[WKNewViewController class]] ? @"NewList" : @"list";

}

/**
 *   下拉刷新更多数据
 */

- (void)loadingNewTopic {
    
    //取消上一次的操作
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = self.a;
    parame[@"c"] = @"data";
    parame[@"type"] = @(self.type);
    
    [self.manager GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/alasijiadegou/Desktop/new_top.plist" atomically:YES];
        self.maxTime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [WKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新数据
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        WKLog(@"数据请求失败---%@",error);
        
    }];
    
    
}


/**
 *   上拉刷新更多数据
 */
- (void)loadingMoreTopic {
    
    //取消上一次的操作
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = self.a;
    parame[@"c"] = @"data";
    parame[@"type"] = @(self.type);
    parame[@"maxtime"] = self.maxTime;
    
    [self.manager GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.maxTime = responseObject[@"info"][@"maxtime"];
        NSArray *array = [WKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:array];
        
        //刷新数据
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        WKLog(@"数据请求失败---%@",error);
        
    }];
    
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WKTopic *topic = self.topics[indexPath.row];
    
    WKTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicId];
    
    cell.topic = topic;
    
    return cell;
    
}


#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //点击到评论控制器
    WKCommentViewController *commVc = [[WKCommentViewController alloc]init];
    commVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commVc animated:YES];
}

@end
