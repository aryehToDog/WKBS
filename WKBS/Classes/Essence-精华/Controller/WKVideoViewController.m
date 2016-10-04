//
//  WKVideoViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/1.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKVideoViewController.h"

@interface WKVideoViewController ()

@end

@implementation WKVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (WKTopicType)type {
    
    return WKTopicTypeVideo;;
}
@end
