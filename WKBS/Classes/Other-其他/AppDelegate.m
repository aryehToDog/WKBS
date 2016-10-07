//
//  AppDelegate.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/26.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "AppDelegate.h"
#import "WKTabBarController.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

/** 上一次选中的索引 */
@property (nonatomic,assign)NSInteger lastSelectedIndex;

@end

@implementation AppDelegate


#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (tabBarController.selectedIndex == self.lastSelectedIndex) {
        
        //发出通知
        [[NSNotificationCenter defaultCenter]postNotificationName:WKTabBarButtonDidRepeatClickNotification object:nil];
    }

    //记录索引值
    self.lastSelectedIndex = tabBarController.selectedIndex;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //设置根控制器
    WKTabBarController *tabVc = [[WKTabBarController alloc]init];
    tabVc.delegate = self;
    
    self.window.rootViewController = tabVc;
    
    //显示主窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
