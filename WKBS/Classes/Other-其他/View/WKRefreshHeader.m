//
//  WKRefreshHeader.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/2.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKRefreshHeader.h"

@implementation WKRefreshHeader

/** 
 *   初始化操作
 */

//- (void)prepare {
//
//    [super prepare];
//
//    self.automaticallyChangeAlpha = YES;
//    self.lastUpdatedTimeLabel.textColor = [UIColor redColor];
//    self.stateLabel.textColor = [UIColor grayColor];
//    
//    [self setTitle:@"等待刷新------" forState:MJRefreshStateIdle];
//    
//    [self setTitle:@"松开刷新!!!!!!!" forState:MJRefreshStatePulling];
//    
//    [self setTitle:@"正在刷新~~~~~~~" forState:MJRefreshStateRefreshing];
//}
- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    
    self.lastUpdatedTimeLabel.hidden = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    [self setTitle:@"等待刷新------" forState:MJRefreshStateIdle];
    
    [self setTitle:@"松开刷新!!!!!!!" forState:MJRefreshStatePulling];
    
    [self setTitle:@"正在刷新~~~~~~~" forState:MJRefreshStateRefreshing];
    
    self.stateLabel.textColor = [UIColor grayColor];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}
@end
