//
//  WKFollowViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKFollowViewController.h"
#import "WKLoginRegisterViewController.h"
@interface WKFollowViewController ()

@end

@implementation WKFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WKCommonBgColor;
    
    self.navigationItem.title = @"我的关注";

    //设置leftButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlighted:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
}

- (void)followClick {
    
    WKFunc;
    
}

- (IBAction)loginBtn {
    
    WKLoginRegisterViewController *login = [[WKLoginRegisterViewController alloc]init];
    
    [self presentViewController:login animated:YES completion:nil];
    
}


@end
