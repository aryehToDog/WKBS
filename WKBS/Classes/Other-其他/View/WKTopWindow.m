//
//  WKTopWindow.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/10/7.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKTopWindow.h"

@implementation WKTopWindow

static UIWindow *window_;

+ (void)showTopView {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        window_ = [[UIWindow alloc]init];
        window_.frame = [UIApplication sharedApplication].statusBarFrame;
        window_.backgroundColor = [UIColor clearColor];
        window_.windowLevel = UIWindowLevelAlert;
        
        //显示窗口
        window_.hidden = NO;
        //添加一个手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topWindowClick)];
        [window_ addGestureRecognizer:tap];
        
    });

}

+ (void)topWindowClick {

    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    [self findScrollViewInView:window];
}

/** 查找窗口中所有的空间 */
+ (void)findScrollViewInView:(UIView *)view {

    for (UIView *subView in view.subviews) {
        [self findScrollViewInView:subView];
    }

    //如果不是scrollview就直接返回
    if (![view isKindOfClass:[UIScrollView class]]) return;

    //如果不在同一个窗口进行重叠也返回
    if (![view intersectWithView:[UIApplication sharedApplication].keyWindow]) return;
    
    UIScrollView *scrollView = (UIScrollView *)view;
    
    CGPoint offest = scrollView.contentOffset;
    offest.y = -scrollView.contentInset.top;
    
    [scrollView setContentOffset:offest animated:YES];
}


@end
