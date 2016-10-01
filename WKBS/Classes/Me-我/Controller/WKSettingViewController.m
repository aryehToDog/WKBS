//
//  WKSettingViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKSettingViewController.h"

@interface WKSettingViewController ()

@end

@implementation WKSettingViewController

- (instancetype)init {
    
    return [self initWithStyle:UITableViewStyleGrouped];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WKCommonBgColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"setting";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"清楚缓存";
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

@end
