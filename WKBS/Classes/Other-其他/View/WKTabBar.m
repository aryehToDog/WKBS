//
//  WKTabBar.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTabBar.h"

@interface WKTabBar ()

@property (nonatomic,weak)UIButton *publishButton;

@end

@implementation WKTabBar

#pragma mark - 懒加载
- (UIButton *)publishButton {

    if (!_publishButton) {
        
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }

    return _publishButton;
}


- (void)layoutSubviews {

    [super layoutSubviews];

    //进行布局
    CGFloat ButtonW = self.wk_width / 5;
    CGFloat ButtonH = self.wk_height;
    CGFloat tabBarButtonY = 0;
    int tabBarIndex = 0;
    
    //添加一个按钮
    for (UIView *button in self.subviews) {
        
        //判断类型
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")] )  continue;
                
            CGFloat tabBarButtonX = ButtonW * tabBarIndex;
        
        if (tabBarIndex >= 2) {
            
            tabBarButtonX += ButtonW;
            
        }
  
            button.frame = CGRectMake(tabBarButtonX, tabBarButtonY, ButtonW, ButtonH);
            
            tabBarIndex ++;
        
    }
    
    //设置按钮的frame
    self.publishButton.wk_size = CGSizeMake(ButtonW, ButtonH);
    self.publishButton.wk_centerX = self.wk_width * 0.5;
    self.publishButton.wk_centerY = self.wk_height * 0.5;
    
}

- (void)publishClick {

    WKFunc

}

@end
