//
//  WKCommentViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/6.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKCommentViewController.h"
#import "WKRefreshHeader.h"
#import "WKRefreshFooter.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "WKHTTPSessionManager.h"
#import "WKTopic.h"
#import "WKComment.h"
#import "WKCommentCell.h"
#import "WKTopicCell.h"
@interface WKCommentViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@property (nonatomic,strong)WKHTTPSessionManager *manager;

//保存模型的属性
@property (nonatomic,strong)WKComment *savedTopCmt;

/** 最热评论数组 */
@property (nonatomic,strong)NSArray<WKComment *> *hotestComments;
/** 最新评论数组 */
@property (nonatomic,strong)NSMutableArray<WKComment *> *latestComments;

@end

@implementation WKCommentViewController

- (WKHTTPSessionManager *)manager {
    
    if (!_manager) {
        
        _manager = [WKHTTPSessionManager manager];
        
    }
    
    return _manager;
}


static NSString * const WKCommentID = @"comment";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    [self setupHeader];
    
}

- (void)setupHeader {

    self.savedTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    self.topic.cellHight = 0;
    UIView *header = [[UIView alloc]init];
    WKTopicCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WKTopicCell class]) owner:nil options:nil].lastObject;
    cell.topic = self.topic;
    [header addSubview:cell];
    
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.cellHight);
    
    //设置header的frame
    header.wk_height = cell.wk_height + WKMargin * 2;

    self.tableView.tableHeaderView = header;
}

- (void)setNav {
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

}


- (void)setupTableView {
    
    self.tableView.backgroundColor = WKCommonBgColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WKCommentCell class]) bundle:nil] forCellReuseIdentifier:WKCommentID];

    //自动计算cell的行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44;
    
}

- (void)setupRefresh {
    //下拉刷新新数据
    self.tableView.mj_header = [WKRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.mj_header beginRefreshing];
    //上拉刷新更多数据
    self.tableView.mj_footer = [WKRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];

}

/** 
 *   下拉刷新新数据
 */

- (void)loadNewComments {

    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.topic.ID;
    parame[@"hot"] = @1;
    
    [self.manager GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        self.hotestComments = [WKComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [WKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (self.latestComments.count == total) {
            //隐藏上拉刷新控件
            self.tableView.mj_footer.hidden = YES;
        }
        
        //结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
    

}

/**
 *   上拉刷新更多数据
 */

- (void)loadMoreComments {
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSString *url = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"a"] = @"dataList";
    parame[@"c"] = @"comment";
    parame[@"data_id"] = self.topic.ID;
    //获取最后一个帖子的id
    parame[@"lastcid"] = self.latestComments.lastObject.ID;
    
    [self.manager GET:url parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            //结束刷新
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        
        NSArray *array = [WKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:array];
        
        [self.tableView reloadData];
        
        int total = [responseObject[@"total"] intValue];
        if (self.latestComments.count == total) {
            
            //隐藏上拉刷新控件或者直接显示上拉完成
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            //结束刷新
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    }];

    
}

- (void)keyboardWillChangeFrame: (NSNotification*)info {
    
    //获取键盘弹出的高度
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat keyBoardY = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    self.bottomMargin.constant = screenH - keyBoardY;
    
    
    //获取键盘弹出的时间
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
       
        [self.view layoutIfNeeded];
        
    }];

}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topic.top_cmt = self.savedTopCmt;
    self.topic.cellHight = 0;
}
/** 
 *    tableView 即将开始进行拖拽的时候
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.view endEditing:YES];

}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.hotestComments.count) return 2;
    if (self.latestComments.count) return 1;
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0 && self.hotestComments.count) {
        return self.hotestComments.count;
    }else {
        return self.latestComments.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WKCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:WKCommentID];
    
    if (indexPath.section == 0 && self.hotestComments.count) {
        cell.comment = self.hotestComments[indexPath.row];
    }else {
        cell.comment = self.latestComments[indexPath.row];
    }
    return cell;
}

/** 
 *   组头的标题
 */

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UILabel *lable = [[UILabel alloc]init];
//    
//    if (section == 0 && self.hotestComments.count) {
//        
//        lable.text = @"最热评论";
//        
//    }else {
//        lable.text = @"最新评论";
//    }
//    return lable;
//}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

        if (section == 0 && self.hotestComments.count) {
    
            return @"最热评论";
    
        }else {
            return @"最新评论";
        }

}

@end
