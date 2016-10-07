//
//  WKEssenceViewController.m
//  WKBS
//
//  Created by 阿拉斯加的狗 on 16/9/27.
//  Copyright © 2016年 阿拉斯加的🐶. All rights reserved.
//

#import "WKEssenceViewController.h"
#import "WKTitleButton.h"
#import "WKAllViewController.h"
#import "WKVideoViewController.h"
#import "WKVoiceViewController.h"
#import "WKWordViewController.h"
#import "WKPictureViewController.h"
#import "WKRecommendTagViewController.h"

@interface WKEssenceViewController () <UIScrollViewDelegate>

@property (nonatomic,strong)UIButton *selectBtn;
@property (nonatomic,strong)UIView *indicatorView;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *titleView;
@end

@implementation WKEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupChildVc];
    
    [self setupScrollView];
    
    [self setupTitleView];

   
}

- (void)setupChildVc {

    WKAllViewController *allVc = [[WKAllViewController alloc]init];
    [self addChildViewController:allVc];
    
    WKVideoViewController *videoVc = [[WKVideoViewController alloc]init];
    [self addChildViewController:videoVc];
    
    WKVoiceViewController *voiceVc = [[WKVoiceViewController alloc]init];
    [self addChildViewController:voiceVc];
    
    WKPictureViewController *pictureVc = [[WKPictureViewController alloc]init];
    [self addChildViewController:pictureVc];
    
    WKWordViewController *wordVc = [[WKWordViewController alloc]init];
    [self addChildViewController:wordVc];

}

- (void)setupScrollView {

    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    scrollView.frame = self.view.bounds;
    NSUInteger count = self.childViewControllers.count;
    
    scrollView.contentSize = CGSizeMake(scrollView.wk_width * count, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    
}


- (void)setupTitleView {

    UIView *titleView = [[UIView alloc]init];
    self.titleView = titleView;
    //设置颜色
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    
    titleView.wk_width = self.view.wk_width;
    titleView.wk_x = 0;
    titleView.wk_height = 35;
    titleView.wk_y = 64;
    
    //创建按钮
    NSArray *titles = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    NSUInteger count = titles.count;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = titleView.wk_width / count;
    CGFloat btnH = titleView.wk_height;
    for (NSUInteger i = 0; i < count; i ++) {
        
        WKTitleButton *btn = [WKTitleButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btnX = i * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [titleView addSubview:btn];
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //创建一个指示器
    UIView *indicatorView = [[UIView alloc]init];
    [titleView addSubview:indicatorView];
    
    WKTitleButton *firstBtn = titleView.subviews[0];
    
    indicatorView.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    indicatorView.wk_height = 1;
    indicatorView.wk_y = titleView.wk_height - indicatorView.wk_height;
    self.indicatorView = indicatorView;
    
    [firstBtn.titleLabel sizeToFit];
    indicatorView.wk_width = firstBtn.titleLabel.wk_width;
    indicatorView.wk_centerX = firstBtn.wk_centerX;
    
    firstBtn.selected = YES;
    self.selectBtn = firstBtn;

}

- (void)setupNav {

    self.view.backgroundColor = WKCommonBgColor;
    
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置leftButton
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlighted:@"MainTagSubIconClick" target:self action:@selector(tagClick)];

}

#pragma mark - 按钮点击
- (void)buttonClick:(WKTitleButton *)btn {

    //如果选中按钮跟所在按钮相等 会发送一个通知
    if (btn == self.selectBtn) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:WKTitleButtonDidRepeatClickNotification object:nil];
        
    }
    
    
    self.selectBtn.selected = NO;
    btn.selected = YES;
    self.selectBtn = btn;
    
    //设置指示器的位置
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.wk_width = btn.titleLabel.wk_width;
        self.indicatorView.wk_centerX = btn.wk_centerX;
    }];
    
    
    //点击按钮进行切换控制器
    CGPoint offest = self.scrollView.contentOffset;
    offest.x = btn.tag * self.scrollView.wk_width;
    [self.scrollView setContentOffset:offest animated:YES];

}

- (void)tagClick {
    WKRecommendTagViewController *recommVc = [[WKRecommendTagViewController alloc]init];
    [self.navigationController pushViewController:recommVc animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

/*
 *   开启动画才会调用
 */

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    NSUInteger index = scrollView.contentOffset.x / scrollView.wk_width;
//    UIView *childView = self.childViewControllers[index].view;
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.view.superview ) {
        return;
    }
    
    //设置所在控制器的view的frame
    childVc.view.frame = scrollView.bounds;
    
    [scrollView addSubview:childVc.view];

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    //调用动画的scrollview
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSUInteger index = scrollView.contentOffset.x / scrollView.wk_width;
    
    WKTitleButton *btn = self.titleView.subviews[index];
//    //获取到当前所点的索引
    [self buttonClick:btn];
}



@end
