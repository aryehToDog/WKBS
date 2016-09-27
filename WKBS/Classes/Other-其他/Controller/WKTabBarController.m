//
//  WKTabBarController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/26.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTabBarController.h"
#import "WKTabBar.h"
#import "WKEssenceViewController.h"
#import "WKNewViewController.h"
#import "WKFollowViewController.h"
#import "WKMeViewController.h"
@interface WKTabBarController ()

@end

@implementation WKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupVc];
    
    //替换系统tabBar
    [self setValue:[[WKTabBar alloc]init] forKeyPath:@"tabBar"];
}


/** 初始化控制器 */
- (void)setupVc {

    //设置tabbaritem富文本属性
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    NSMutableDictionary *SelDict = [NSMutableDictionary dictionary];
    SelDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    SelDict[NSForegroundColorAttributeName] = [UIColor darkTextColor];
    [item setTitleTextAttributes:SelDict forState:UIControlStateSelected];
    
    
    //精华
    [self setupOneController:[[WKEssenceViewController alloc]init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    //新帖
    [self setupOneController:[[WKNewViewController alloc]init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    //关注
    [self setupOneController:[[WKFollowViewController alloc]init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    //我
    [self setupOneController:[[WKMeViewController alloc]init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

/** 初始化一个控制器 */
- (void)setupOneController: (UIViewController *)Vc title: (NSString *)title image: (NSString *)image selectedImage: (NSString *)selectedImage {

    UIViewController *vc = Vc;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];

//    vc.view.backgroundColor = WKRandomColor;
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:vc];
   
}



@end
